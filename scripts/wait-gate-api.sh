#!/bin/bash

set -euo pipefail


function wait_for_url() {
    set +e

    TIMEOUT_PERIOD=180
    DELAY=20

    local url=$1
    local t=$TIMEOUT_PERIOD

    curl --fail -s ${url}
    until [ $? = 0 ]  ; do
        t=$((t - DELAY))
        if [[ $t -eq 0 ]]; then
            echo "====== Url is not reachable after $TIMEOUT_PERIOD seconds"
            set -e
            exit 1
        fi

        echo "Url is not reachable yet, remaining time: $t seconds"
        sleep $DELAY
        curl --fail -s ${url}
    done

    echo "====== Url is reachable"
    set -e
}

wait_for_url http://127.0.0.1:8084/instanceTypes
