#!/bin/sh

# exit if command fails
set -e

docker run --rm \
-e AMW_STATS_MONGO_HOST \
-e SINCE \
-e UNTIL \
-v $(pwd)/exported:/workspace/exported \
docker-export

docker run --user root --rm \
-e SINCE \
-e UNTIL \
-e PERIOD \
-v $(pwd)/exported:/workspace/exported \
-v $(pwd)/results:/workspace/pandas/results \
docker-stats

docker run --rm \
-v $(pwd)/results:/results \
docker-imagemagick

docker run --rm \
-v $(pwd)/results:/results \
-e APPKEY \
-e SECRET \
-e ACCOUNT_KEY \
docker-post
