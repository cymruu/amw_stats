FROM alpine:latest
RUN apk add imagemagick
WORKDIR /results

CMD [ "convert", "statuses_pie.png", "top_mods.png", "top_tags.png", "reaction_time_histogram.png", "hour_distribution_heatmap.png", "-append", "combined.png"]
