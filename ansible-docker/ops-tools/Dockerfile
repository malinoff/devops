FROM openjdk:8-alpine
MAINTAINER Dmitry Malinovsky <dmalinovsky@company.com>

COPY company-project /data/company-project
COPY entrypoint.sh /data/entrypoint.sh

RUN apk update \
  && apk add curl \
  && rm -rf /var/cache/apk/*

CMD ["/data/entrypoint.sh"]
