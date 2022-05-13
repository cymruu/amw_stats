# exit if command fails
set -e
SINCE=$(date -v-Sun -v-7d -u +"%Y-%m-%dT00:00:00Z")
echo exporting data since: $SINCE
docker run --rm -v $(pwd)/exported:/exported -e AMW_STATS_MONGO_HOST=$AMW_STATS_MONGO_HOST -e SINCE=$SINCE mongo /bin/bash -c 'mkdir -p exported/ && cd exported/ && mongoexport --uri="$AMW_STATS_MONGO_HOST" --collection=confessions --out=confessions.json --query="{\"createdAt\": { \"\$gte\": { \"\$date\": \"$SINCE\" } }}" --jsonArray'
docker run --rm -v $(pwd)/exported:/exported -e AMW_STATS_MONGO_HOST=$AMW_STATS_MONGO_HOST -e SINCE=$SINCE mongo /bin/bash -c 'mkdir -p exported/ && cd exported/ && mongoexport --uri="$AMW_STATS_MONGO_HOST" --collection=replies --out=replies.json --query="{\"createdAt\": { \"\$gte\": { \"\$date\": \"$SINCE\" } }}" --jsonArray'
docker run --rm -v $(pwd)/exported:/exported -e AMW_STATS_MONGO_HOST=$AMW_STATS_MONGO_HOST -e SINCE=$SINCE mongo /bin/bash -c 'mkdir -p exported/ && cd exported/ && mongoexport --uri="$AMW_STATS_MONGO_HOST" --collection=actions --out=actions.json --query="{\"time\": { \"\$gte\": { \"\$date\": \"$SINCE\" } }}" --jsonArray'
docker run --rm -v $(pwd)/exported:/exported -e AMW_STATS_MONGO_HOST=$AMW_STATS_MONGO_HOST -e SINCE=$SINCE mongo /bin/bash -c 'mkdir -p exported/ && cd exported/ && mongoexport --uri="$AMW_STATS_MONGO_HOST" --collection=users --out=users.json --fields="_id,username" --jsonArray'

docker build -t docker-stats docker-stats
docker run --rm \
-v $(pwd)/exported:/workspace/exported \
-v $(pwd)/pandas:/workspace/pandas \
docker-stats


docker build ./docker-magisk -t docker-magisk
docker run --rm \
-v $(pwd)/pandas/results:/results \
docker-magisk \
/bin/sh -c 'cd /results && convert statuses_pie.png top_mods.png top_tags.png reaction_time_histogram.png -append combined.png'

docker build ./docker-post -t docker-post
docker run --rm \
-v $(pwd)/pandas/results:/results \
-e APPKEY=$APPKEY \
-e SECRET=$SECRET \
-e ACCOUNT_KEY=$ACCOUNT_KEY \
docker-post
