FROM ubuntu:18.04
MAINTAINER peterstechblog

RUN apt-get update && apt-get -y install sudo

ADD ./scripts/benchmark_io /
ADD ./docker/start.sh /
ENTRYPOINT ["/start.sh"]

