#!/bin/bash

set -euo pipefail

MINIO_ROOT_USER=minioadmin
MINIO_ROOT_PASSWORD=minioadmin
MINIO_ENCRYPTION_KEY=minio-encryption-key

NAME=minio
if [ -z "$(sudo docker ps -f name=${NAME} | grep ${NAME})" ]; then
  echo "Running a new minio container"
  sudo docker run -p 9001:9000 \
    --name ${NAME} \
    -d \
    -e "MINIO_ROOT_USER_FILE=${MINIO_ROOT_USER}" \
    -e "MINIO_ROOT_PASSWORD_FILE=${MINIO_ROOT_PASSWORD}" \
    -e "MINIO_KMS_SECRET_KEY_FILE=minio-encryption-key:${MINIO_ENCRYPTION_KEY}" \
    -v /home/vagrant/data/minio/disk1:/disk1 \
    -v /home/vagrant/data/minio/disk2:/disk2 \
    -v /home/vagrant/data/minio/disk3:/disk3 \
    -v /home/vagrant/data/minio/disk4:/disk4 \
    minio/minio server /disk{1...4}
else
  echo "Starting minio container"
  sudo docker start ${NAME}
fi


echo ${MINIO_ROOT_PASSWORD} | hal config storage s3 edit \
  --access-key-id ${MINIO_ROOT_USER} \
  --secret-access-key \
  --endpoint http://127.0.0.1:9001

hal config storage edit --type s3
