Relatively recent ansible layout using docker
---------------------------------------------

Build and deployment scripts are now in the same
repo as the source code (living in ``project/`` directory).

``do.sh`` is a helper script to be able to easily:

#. build the project via docker build container
   (i.e. without maven installed locally), using
   the shared cache (``~/.m2``),
#. bump versions,
#. run tests,
#. build docker containers to be deployed on environments.

``ops-tools`` directory contains everything related to
the ops side of the project, including Jenkinsfile,
Dockerfiles and ansible scripts.

The intended usage is::

    $ ./do.sh buildcontainer
    $ ./do.sh build
    $ ./do.sh package
    $ docker push company-project:$VERSION
    $ cd ops-tools
    $ ansible-playbook -i environments/dev deploy.yml -e "version=$VERSON"
