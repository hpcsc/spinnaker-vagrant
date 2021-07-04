#!/bin/bash

set -euo pipefail

ACCOUNT_NAME=$1

hal config provider kubernetes enable

if [ -z "$(hal config provider kubernetes account list | grep ${ACCOUNT_NAME})" ]; then
  CONTEXT=$(kubectl config current-context)
  echo "=== Add kubernetes account ${ACCOUNT_NAME} with context ${CONTEXT}"
  hal config provider kubernetes account add ${ACCOUNT_NAME} \
    --context ${CONTEXT} \
    --provider-version v2
else
  echo "=== kubernetes account ${ACCOUNT_NAME} exists"
fi

sudo hal deploy apply
