#!/usr/bin/env bash

set -exo pipefail

docker build -t swift-test -f Dockerfile~test ./
docker run --rm swift-test || set +x; RED='\033[0;31m' NC='\033[0m' echo -e "${RED}Tests exited with non-zero exit code${NC}"; tput bel; exit 1
