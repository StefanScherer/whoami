#!/bin/bash
set -e

docker version
uname -a
echo "Updating Docker engine to have multi-stage builds"
sudo service docker stop
curl -fsSL https://get.docker.com/ | sudo sh
echo "Enabling docker client experimental features"
mkdir -p ~/.docker
echo '{ "experimental": "enabled" }' > ~/.docker/config.json
docker version

if [ -d tmp ]; then
  docker rm build
  rm -rf tmp
fi

docker build -t whoami --build-arg "arch=$ARCH" .
