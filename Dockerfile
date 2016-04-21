FROM markbnj/apache-jena:3.0.1
MAINTAINER betz.mark@gmail.com

RUN apk add --update p7zip && \
    mkdir -p /var/yago/tdf

ADD ttl /var/yago/ttl
ADD extract.sh /usr/local/bin/

RUN /usr/local/bin/extract.sh /var/yago/ttl
