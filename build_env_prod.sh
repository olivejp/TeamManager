#!/usr/bin/env bash

# Generate environment_config.dart with Production variables.
# Author : OLIVE Jean-Paul

if [ -z "$TEAMATE_MANAGER_SERVER_URL" ]
then
  echo "The variable TEAMATE_MANAGER_SERVER_URL couldn't be null"
  exit 1
fi

if [ -z "$TEAMATE_MANAGER_RESOURCE_STORAGE" ]
then
  echo "The variable TEAMATE_MANAGER_RESOURCE_STORAGE couldn't be null"
  exit 1
fi

flutter pub run environment_config:generate \
--serverUrl=$TEAMATE_MANAGER_SERVER_URL \
--resourceManagerStorage=$TEAMATE_MANAGER_RESOURCE_STORAGE \
--useHttps=true

echo Production settings applied.