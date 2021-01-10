./get_data.sh
(($? != 0)) && { printf '%s\n' "get_data failed set env variable AMW_STATS_MONGO_HOST"; exit 1; }
mkdir -p plots
Rscript amw_stats.r