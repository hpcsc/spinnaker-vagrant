#!/bin/bash

set -euo pipefail

VERSION=$1

hal config version edit --version $VERSION
hal config deploy edit --type localdebian
hal deploy apply
hal deploy connect

