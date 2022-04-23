#!/usr/bin/env bash

# Generate environment_config.dart with Production variables.
# Author : OLIVE Jean-Paul

flutter pub run environment_config:generate \
--serverUrl=10.0.2.2:8081 \
--resourceManagerStorage:'gs://resourcemanager-2a15b.appspot.com' \
--useHttps=false

echo Emulator settings applied.