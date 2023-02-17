#!/bin/bash

set -e
set -x

rm -f docker-compose.yml
#rm -f .gitmodules

if [[ $RAILS_ENV == "production" ]]; then
  ln -s config/docker-c]ompose/prod.yml docker-compose.yml
#elif [[ $RAILS_ENV == "staging" ]]; then
#  ln -s config/docker-compose/staging.yml docker-compose.yml
#elif [[ "$(uname -s)" == "Linux" ]]; then
#  ln -s config/docker-compose/linux.yml docker-compose.yml
elif [[ "$(uname -s)" == "Darwin" ]]; then
  ln -s config/docker-compose/mac.yml docker-compose.yml
fi

#cp config/gitmodules/${RAILS_ENV:-dev} .gitmodules

docker-compose pull
docker-compose build
docker-compose run --rm hub bundle exec rails db:prepare
