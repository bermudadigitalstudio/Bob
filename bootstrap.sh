#!/usr/bin/env bash

set -e
BOB_DIR="`dirname \"$0\"`"

echo "Unpacking Scripts..."
mv $BOB_DIR/Scripts/* ./

if [ ! -f ".gitignore" ]
then
  echo "Adding .gitignore..."
  mv $BOB_DIR/.gitignore ./
fi

echo "Symlinking Dockerignore..."
ln -s .gitignore .dockerignore

echo "Adding Dockerfiles..."
mv $BOB_DIR/Dockerfile* ./

rm -r $BOB_DIR
