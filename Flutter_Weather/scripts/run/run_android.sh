#!/usr/bin/env bash

set -e

ENVIRONMENT=$1

flutter run -t lib/main/main_${ENVIRONMENT}.dart --vmservice-out-file=detective_connect.txt  --no-sound-null-safety