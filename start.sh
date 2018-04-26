#!/bin/bash
set -euo pipefail

docker stop letter > /dev/null 2>&1
docker rm letter > /dev/null 2>&1
docker run -d \
  --restart on-failure:3 \
  --name letter \
  letter
