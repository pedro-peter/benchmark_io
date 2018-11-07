FROM centos:centos7
MAINTAINER peterstechblog
RUN yum install epel-release -y; yum install -y sysbench stress-ng && yum clean all

ADD scripts/benchmark_io /
ADD start.sh /
ENTRYPOINT ["/start.sh"]

