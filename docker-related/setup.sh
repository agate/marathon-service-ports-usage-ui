#!/usr/bin/env bash

APP_NAME=webapp
APP_HOME=/home/app
APP_DIR=${APP_HOME}/${APP_NAME}
REPO=https://github.com/agate/marathon-service-ports-usage-ui.git

ruby -e 'ENV.map{ |e| puts "env #{e.first};" }' > /etc/nginx/main.d/rb_env.conf

cd $APP_HOME

if [ -d $APP_DIR/.git ]; then
  echo "webapp already exist"
else
  git clone $REPO $APP_NAME
fi

chown -R app:app $APP_DIR

cd $APP_DIR
su - app -c "cd $APP_DIR; bundle install"
