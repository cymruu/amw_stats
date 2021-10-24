set -u
SINCE=$(date --date="last Sunday - 7 days" --iso-8601=seconds)
mongoexport --uri="$AMW_STATS_MONGO_HOST" --collection=confessions --out=../exported/confessions.json --query="{\"createdAt\": { \"\$gte\": { \"\$date\": \"$SINCE\" } }}" --jsonArray
mongoexport --uri="$AMW_STATS_MONGO_HOST" --collection=replies --out=../exported/replies.json --query="{\"createdAt\": { \"\$gte\": { \"\$date\": \"$SINCE\" } }}" --jsonArray
mongoexport --uri="$AMW_STATS_MONGO_HOST" --collection=actions --out=../exported/actions.json --query="{\"time\": { \"\$gte\": { \"\$date\": \"$SINCE\" } }}" --jsonArray
mongoexport --uri="$AMW_STATS_MONGO_HOST" --collection=users --out=../exported/users.json --fields="_id,username" --jsonArray
