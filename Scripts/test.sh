#!/usr/bin/env bash

set -exo pipefail

docker build -t swift-test -f Dockerfile~test ./
docker run --rm swift-test || set +x; echo "Tests exited with non-zero exit code"; tput bel; exit 1
