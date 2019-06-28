#!/usr/bin/env bash

gradle :build

docker-compose build 

docker-compose up -d

echo -e "\e[1mWill be running soon!\e[0m"


function wait_for_server() {
  until $(docker-compose exec $1 curl --output /dev/null --silent --head --fail $2); do
    sleep 1
    echo -n '.'
  done
  echo
}

function open_browser() {
    if [ -x "$(command -v xdg-open)" ]; then
        xdg-open "$1"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        open "$1"
    else 
        start "$1"
    fi
}

echo -n " => Waiting for web ..."
wait_for_server 'web' 'http://localhost:8080/web-app'
echo -n " => Waiting for keycloak ..."
wait_for_server 'keycloak' 'http://localhost:8080/auth'

echo -e "\e[1mReady! Ready! Visit http://localhost/web-app (Linux, Docker Desktop for Mac and Windows) or http://\$(docker-machine ip)/web-app (Docker Toolbox)\e[0m"

#  portable way to check whether a 'docker-machine' command exists in $PATH and is executable:
if [ -x "$(command -v docker-machine)" ]; then
    open_browser "http://$(docker-machine ip)/web-app"
else
    open_browser "http://localhost/web-app"
fi