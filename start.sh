./scripts/get_data.sh
(($? != 0)) && { printf '%s\n' "get_data failed set env variable AMW_STATS_MONGO_HOST"; exit 1; }
mkdir -p results
rm results/*
Rscript amw_stats.r
cd results/
convert actionsInLastWeek.png activityPerDay.png activityPerHour.png tags.png -append $(date --iso-8601)result.png
