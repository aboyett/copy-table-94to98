FROM openjdk:7-jdk

RUN apt-get update && apt-get install -y --no-install-recommends \
    libjarjar-java maven

ARG BUILD_UID=1000

RUN adduser --uid $BUILD_UID builder 

USER builder

WORKDIR /src

CMD ["sh", "./build-copy-table.sh"]
