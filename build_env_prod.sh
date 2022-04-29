#!/usr/bin/env bash

# Generate environment_config.dart with Production variables.
# Author : OLIVE Jean-Paul

if [ -z $1 ]
then
  echo "The parameter server URL couldn't be null"
  exit 1
fi

if [ -z $2 ]
then
  echo "The variable storage url couldn't be null"
  exit 1
fi

flutter pub run environment_config:generate \
--serverUrl=$1 \
--resourceManagerStorage=$2 \
--useHttps=true

echo Production settings applied.