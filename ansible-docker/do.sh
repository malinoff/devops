#!/usr/bin/env bash
PLANG=java
PROJECT=project
PFULLNAME=company-project

COMMAND=$0
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
USERID=$(id -u)
GROUPID=$(id -g)
BC_NAME=company-build-${PLANG}-${PROJECT}

ENVIRON=$(env)

sub_buildcontainer() {
    set -ex
    docker build -t ${BC_NAME} \
                 --build-arg UID=$USERID \
                 --build-arg GID=$GROUPID \
                 --build-arg EXTERNAL_HOME=${HOME} \
                 -f ${ROOT}/ops-tools/Dockerfile.build \
                 ${ROOT}/ops-tools
    set +ex
}

sub_build() {
    set -ex
    _set_version
    # Mouting a non-existent ~/.m2 into a build container results in root:root ownership.
    # So we create ~/.m2 explicitly, just for the sake of sane permissions.
    mkdir -p ${HOME}/.m2 || true
    _bc_inside "./scripts/bumpVersion $VERSION"
    _bc_inside "mvn package -P skip-tests \
                            -D ci.build.timestamp=\$(date +%s) \
                            -D ci.build.number=\$BUILD_NUMBER"
    set +ex
}

sub_test() {
    set -ex
    _bc_inside 'mvn test'
    set +ex
}

sub_package() {
    set -ex
    _set_version
    unzip -d ${ROOT}/ops-tools/ ${ROOT}/${PFULLNAME}/target/${PFULLNAME}-${VERSION}-distr.zip
    mv ${ROOT}/ops-tools/${PFULLNAME}-${VERSION} ${ROOT}/ops-tools/${PFULLNAME}
    docker build -t ${PFULLNAME}:${VERSION} ${ROOT}/ops-tools
    set +ex
}

sub_help() {
    echo "Usage: $COMMAND <task>"
    echo "  Available tasks:"
    echo "    * help"
    echo "    * buildcontainer"
    echo "    * build"
    echo "    * test"
    echo "    * package"
}

_bc_inside() {
    echo ${1} | docker run --rm -i --init \
                     -v ${HOME}/.m2:${HOME}/.m2 \
                     -v ${ROOT}:${HOME} \
                     -u ${USERID}:${GROUPID} \
                     -e BUILD_NUMBER=${BUILD_NUMBER:-0} \
                     -e MAVEN_CONFIG=${HOME}/.m2 \
                     -e M2_HOME \
                     -e MAVEN_HOME \
                     ${BC_NAME} \
                     sh -
}

_set_version() {
    if [ -z ${VERSION} ]; then
        VERSION=$(python -c "import xml.etree.ElementTree as ET; \
                             root = ET.parse('${ROOT}/pom.xml'); \
                             elem = root.find('{http://maven.apache.org/POM/4.0.0}version'); \
                             print(elem.text)")
    fi
}

subcommand=$1
case $subcommand in
    "" | "-h" | "--help")
        sub_help
        ;;
    *)
        shift
        sub_${subcommand} $@
        if [ $? = 127 ]; then
            echo "Error: '$subcommand' is not a known subcommand." >&2
            sub_help
            exit 1
        fi
        ;;
esac
