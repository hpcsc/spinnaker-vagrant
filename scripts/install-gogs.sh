#!/bin/bash

set -euo pipefail

ACCOUNT_NAME=$1

cd ${HOME}/gogs
docker-compose up -d

hal config artifact gitrepo enable
hal config artifact gitrepo account add ${ACCOUNT_NAME} \
  --username-password-file ${HOME}/gogs/credentials

sudo hal deploy apply
