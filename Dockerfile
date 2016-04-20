FROM markbnj/apache-jena:3.0.1
MAINTAINER betz.mark@gmail.com

RUN mkdir -p /var/data/yago && \
    curl -o /tmp/yago3_entire_ttl.7z http://resources.mpi-inf.mpg.de/yago-naga/yago/download/yago/yago3_entire_ttl.7z && \


ENTRYPOINT ["fuseki-server", "--update"]