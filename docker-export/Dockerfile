FROM mongo

WORKDIR /workspace

ENV SINCE $SINCE
ENV AMW_STATS_MONGO_HOST $AMW_STATS_MONGO_HOST

COPY get_data.sh .

CMD ["sh", "get_data.sh"]
