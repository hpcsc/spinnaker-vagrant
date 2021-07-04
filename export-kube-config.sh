#!/bin/bash

set -euo pipefail

CONTEXT=minikube

rm -rf ./tmp && mkdir ./tmp
KUBE_CONFIG=$(kubectl config view --context ${CONTEXT} --minify)

CA_CERT_PATH=$(echo "${KUBE_CONFIG}" | yq eval '.clusters[0].cluster.certificate-authority' -)
CLIENT_CERT_PATH=$(echo "${KUBE_CONFIG}" | yq eval '.users[0].user.client-certificate' -)
CLIENT_KEY_PATH=$(echo "${KUBE_CONFIG}" | yq eval '.users[0].user.client-key' -)
cp -vf ${CA_CERT_PATH} ./tmp
cp -vf ${CLIENT_CERT_PATH} ./tmp
cp -vf ${CLIENT_KEY_PATH} ./tmp


REPLACE_CA_CERT_SED="s|${CA_CERT_PATH}|/vagrant/tmp/$(basename ${CA_CERT_PATH})|g"
REPLACE_CLIENT_CERT_SED="s|${CLIENT_CERT_PATH}|/vagrant/tmp/$(basename ${CLIENT_CERT_PATH})|g"
REPLACE_CLIENT_KEY_SED="s|${CLIENT_KEY_PATH}|/vagrant/tmp/$(basename ${CLIENT_KEY_PATH})|g"
sed "${REPLACE_CA_CERT_SED}; ${REPLACE_CLIENT_CERT_SED}; ${REPLACE_CLIENT_KEY_SED}" \
  <(echo "${KUBE_CONFIG}") > ./tmp/kube.config
