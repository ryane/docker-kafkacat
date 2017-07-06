FROM debian:stable-20170620

WORKDIR /build

ENV BUILD_PACKAGES "build-essential git curl ca-certificates zlib1g-dev python"
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends $BUILD_PACKAGES && \
    git clone https://github.com/edenhill/kafkacat.git && \
    cd kafkacat && \
    ./bootstrap.sh && \
    make install && \
    cd .. && rm -rf kafkacat && \
    apt-get remove --purge -y $BUILD_PACKAGES && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENTRYPOINT ["kafkacat"]
