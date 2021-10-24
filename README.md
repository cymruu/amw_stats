# amw_stats
Scripts to generate weekly AMW stats

# usage
Before using set AMW_STATS_MONGO_HOST env variable to mongo database URI. 

`export AMW_STATS_MONGO_HOST="mongodb://THE_MONGO_URI"`

Then run `./start.sh`

If you have docker installed you can just run `./docker` to download data, generate stats & assemble charts into result image. 
