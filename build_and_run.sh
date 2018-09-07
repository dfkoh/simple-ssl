#!/bin/bash

set -euo pipefail

docker build -t myssl .
docker run -p 4443:443 -p 4480:80 -d myssl
