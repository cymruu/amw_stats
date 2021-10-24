SINCE=$(date -v-Sun -v-7d -u +"%Y-%m-%dT00:00:00Z")
echo exporting data since: $SINCE
docker run --rm -v $(pwd)/exported:/exported -e AMW_STATS_MONGO_HOST=$AMW_STATS_MONGO_HOST -e SINCE=$SINCE mongo /bin/bash -c 'mkdir -p exported/ && cd exported/ && mongoexport --uri="$AMW_STATS_MONGO_HOST" --collection=confessions --out=confessions.json --query="{\"createdAt\": { \"\$gte\": { \"\$date\": \"$SINCE\" } }}" --jsonArray'
docker run --rm -v $(pwd)/exported:/exported -e AMW_STATS_MONGO_HOST=$AMW_STATS_MONGO_HOST -e SINCE=$SINCE mongo /bin/bash -c 'mkdir -p exported/ && cd exported/ && mongoexport --uri="$AMW_STATS_MONGO_HOST" --collection=replies --out=replies.json --query="{\"createdAt\": { \"\$gte\": { \"\$date\": \"$SINCE\" } }}" --jsonArray'
docker run --rm -v $(pwd)/exported:/exported -e AMW_STATS_MONGO_HOST=$AMW_STATS_MONGO_HOST -e SINCE=$SINCE mongo /bin/bash -c 'mkdir -p exported/ && cd exported/ && mongoexport --uri="$AMW_STATS_MONGO_HOST" --collection=actions --out=actions.json --query="{\"time\": { \"\$gte\": { \"\$date\": \"$SINCE\" } }}" --jsonArray'
docker run --rm -v $(pwd)/exported:/exported -e AMW_STATS_MONGO_HOST=$AMW_STATS_MONGO_HOST -e SINCE=$SINCE mongo /bin/bash -c 'mkdir -p exported/ && cd exported/ && mongoexport --uri="$AMW_STATS_MONGO_HOST" --collection=users --out=users.json --fields="_id,username" --jsonArray'

docker run --rm -v $(pwd)/exported:/exported -v $(pwd)/results:/results -v $(pwd)/scripts:/scripts -v $(pwd)/r-libs:/usr/local/lib/R/site-library r-base /bin/bash -c 'mkdir -p results/ && Rscript /scripts/amw_stats.r'



