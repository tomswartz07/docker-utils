#!/bin/bash

# Remove all stopped containers
docker rm -v $(docker ps -a -q) || true

# Remove all 'dangling' images
docker rmi $(docker images -q --filter "dangling=true") || true
