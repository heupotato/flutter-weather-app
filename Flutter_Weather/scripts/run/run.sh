#!/usr/bin/env bash

set -e

DIR=`dirname $0`

#ENVIRONMENT="mock"
#ENVIRONMENT="dev"
ENVIRONMENT="preprod"
#ENVIRONMENT="prod"

if [ "$(uname)" == "Darwin" ]; then
    . "${DIR}/run_ios.sh" "${ENVIRONMENT}"
else
    . "${DIR}/run_android.sh" "${ENVIRONMENT}"
fi