#!/bin/sh
set -e

SERVICE_NAME="company-project"

exec /bin/sh /data/${SERVICE_NAME}/bin/${SERVICE_NAME}.sh
