#!/bin/sh

# exit if command fails
set -e
SINCE=$(date -v-Sun -v-7d -u +"%Y-%m-%dT00:00:00Z")
UNTIL=$(date -v-Sun -u +"%Y-%m-%dT00:00:00Z")

docker build -t docker-export docker-export
docker run --rm \
-e AMW_STATS_MONGO_HOST=$AMW_STATS_MONGO_HOST \
-e SINCE=$SINCE \
-e UNTIL=$UNTIL \
-v $(pwd)/exported:/workspace/exported \
docker-export

docker build -t docker-stats docker-stats
docker run --rm \
-e SINCE=$SINCE \
-e UNTIL=$UNTIL \
-v $(pwd)/exported:/workspace/exported \
-v $(pwd)/pandas:/workspace/pandas \
docker-stats


docker build ./docker-magisk -t docker-magisk
docker run --rm \
-v $(pwd)/pandas/results:/results \
docker-magisk

docker build ./docker-post -t docker-post
docker run --rm \
-v $(pwd)/pandas/results:/results \
-e APPKEY=$APPKEY \
-e SECRET=$SECRET \
-e ACCOUNT_KEY=$ACCOUNT_KEY \
docker-post
