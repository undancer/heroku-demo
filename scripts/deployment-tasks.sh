#!/usr/bin/env bash

echo "release sh"

env

curl -i -n https://api.heroku.com/apps/$HEROKU_APP_NAME/releases/ \
        -H "Accept: application/vnd.heroku+json; version=3"