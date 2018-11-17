FROM alpine:latest
MAINTAINER peterstechblog
RUN apk update && apk add sudo bash && rm -rf /var/cache/apk/*

ADD ./scripts/benchmark_io /
ADD ./docker/start.sh /
ENTRYPOINT ["/start.sh"]

