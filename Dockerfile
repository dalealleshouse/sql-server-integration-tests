FROM python:3.9-slim AS scripter

WORKDIR /usr/src/app

RUN echo "deb http://security.debian.org/debian-security jessie/updates main" >> /etc/apt/sources.list
RUN apt-get update && \
    apt-get install -y libicu63 libssl1.0.0 libffi-dev libunwind8 python3-dev && \
    pip install --upgrade pip && pip install mssql-scripter

ARG CONNECT_STRING

RUN mssql-scripter \
    --connection-string="$CONNECT_STRING" \
    --target-server-version 2014 \
    --display-progress \
    -f ./schema.sql

################################################################################
FROM mcr.microsoft.com/mssql/server:2017-latest-ubuntu

LABEL maintainer="dalealleshouse@gmail.com"

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY --from=scripter /usr/src/app/*.sql .
COPY ./*.sh /usr/src/app/

RUN  apt-get update && apt-get install dos2unix
RUN dos2unix ./*.sh

ENV SA_PASSWORD ONE2three4!
ENV ACCEPT_EULA Y

EXPOSE 1433

CMD /bin/bash ./entrypoint.sh

