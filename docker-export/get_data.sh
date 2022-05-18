#!/bin/sh

# exit if command fails
set -e

echo exporting data from: $SINCE - $UNTIL
mongoexport --quiet --uri="$AMW_STATS_MONGO_HOST" --collection=confessions --out=confessions.json --query="{\"createdAt\": {\"\$gte\": {\"\$date\": \"$SINCE\"},\"\$lte\": {\"\$date\": \"$UNTIL\"}}}" --jsonArray
mongoexport --quiet --uri="$AMW_STATS_MONGO_HOST" --collection=replies --out=replies.json --query="{\"createdAt\": {\"\$gte\": {\"\$date\": \"$SINCE\"},\"\$lte\": {\"\$date\": \"$UNTIL\"}}}" --jsonArray
mongoexport --quiet --uri="$AMW_STATS_MONGO_HOST" --collection=actions --out=actions.json --query="{\"time\": { \"\$gte\": { \"\$date\": \"$SINCE\"},\"\$lte\": {\"\$date\": \"$UNTIL\"}}}" --jsonArray
mongoexport --quiet --uri="$AMW_STATS_MONGO_HOST" --collection=users --out=users.json --fields="_id,username" --jsonArray

mv *.json exported/
