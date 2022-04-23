#!/usr/bin/env bash

flutter pub run environment_config:generate --serverUrl=$TEAMATE_MANAGER_SERVER_URL --resourceManagerStorage=$TEAMATE_MANAGER_RESOURCE_STORAGE --useHttps=true

echo Production settings applied.