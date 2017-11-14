#!/usr/bin/env bash

# Replace the following with something like TESTIMPORTMODULE="MyPackageTests"
TESTIMPORTMODULE="Replace me with Test Target name! `false`" || echo "Open Scripts/generate_LinuxMain.sh and fix line 3" && exit 1

SOURCERY_VERSION="$(sourcery --version)"
if [ "$SOURCERY_VERSION" != "0.9.0" ]
then
  echo "You need sourcery 0.9.0 – please `brew install sourcery`"
  exit 1
fi

set -e
SCRIPTS="`dirname \"$0\"`"
TESTS="$SCRIPTS/../Tests"

sourcery --sources $TESTS --templates $SCRIPTS/LinuxMain.stencil --output $TESTS --args testimports="@testable import $TESTIMPORTMODULE"
mv $TESTS/LinuxMain.generated.swift $TESTS/LinuxMain.swift
