FROM openjdk:7-jdk

RUN apt-get update && apt-get install -y --no-install-recommends \
    libjarjar-java maven

# install dumb-init for proper signal handling
RUN wget https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64.deb \
    && dpkg -i dumb-init_*.deb && rm dumb-init_*.deb

ARG BUILD_UID=1000

RUN adduser --uid $BUILD_UID builder 

USER builder

WORKDIR /src

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["sh", "./build-copy-table.sh"]
