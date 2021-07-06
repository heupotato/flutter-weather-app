#!/usr/bin/env bash

set -e

ENVIRONMENT=$1
FLAVOR="${ENVIRONMENT}"

flutter run -t lib/main/main_${ENVIRONMENT}.dart --no-sound-null-safety