set -u
SINCE=$(date --date="last Sunday - 7 days" --iso-8601=seconds)
mongoexport --uri="$AMW_STATS_MONGO_HOST" --collection=confessions --out=confessions.json --query="{\"createdAt\": { \"\$gte\": { \"\$date\": \"$SINCE\" } }}" --jsonArray
mongoexport --uri="$AMW_STATS_MONGO_HOST" --collection=replies --out=replies.json --query="{\"createdAt\": { \"\$gte\": { \"\$date\": \"$SINCE\" } }}" --jsonArray
mongoexport --uri="$AMW_STATS_MONGO_HOST" --collection=actions --out=actions.json --query="{\"time\": { \"\$gte\": { \"\$date\": \"$SINCE\" } }}" --jsonArray
mongoexport --uri="$AMW_STATS_MONGO_HOST" --collection=users --out=users.json --fields="_id,username" --jsonArray