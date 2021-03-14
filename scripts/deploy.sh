#!/bin/sh
# deployment script for automated updates via github actions

# ensure exclusive execution with flock
LOCK_FILE=/tmp/monitoring-deployment.lock
exec 200>"$LOCK_FILE"
flock -n 200 || exit

# get latest repo version
git pull

# update deployment
docker-compose up -d --remove-orphans

# cleanup old/stale images
docker image prune -af
