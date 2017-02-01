#!/usr/bin/env bash

set -e
BOB_DIR="`dirname \"$0\"`"

echo "Unpacking Scripts..."
mkdir ./Scripts || true
mv $BOB_DIR/Scripts/* ./Scripts

echo "Adding .gitignore..."
mv $BOB_DIR/.gitignore ./

echo "Symlinking Dockerignore..."
ln -s .gitignore .dockerignore || true

echo "Adding Dockerfiles..."
mv $BOB_DIR/Dockerfile* ./

rm -r $BOB_DIR
