#!/usr/bin/env bash

# Generate environment_config.dart with Development variables.
# Author : OLIVE Jean-Paul

flutter pub run environment_config:generate \
--serverUrl=localhost:8081 \
--resourceManagerStorage:'gs://resourcemanager-2a15b.appspot.com' \
--useHttps=false

echo Development settings applied.