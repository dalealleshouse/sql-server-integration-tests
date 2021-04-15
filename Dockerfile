# This Dockerfile attracts every other Dockerfile in the universe with a force
# proportional to the product of their masses and inversely proportional to the
# distance between them
FROM python:3.9-slim AS scripter

WORKDIR /usr/src/app

RUN echo "deb http://security.debian.org/debian-security jessie/updates main" >> /etc/apt/sources.list
RUN apt-get update && \
    apt-get install -y libicu63 libssl1.0.0 libffi-dev libunwind8 python3-dev && \
    pip install --upgrade pip && pip install mssql-scripter

ARG CONNECT_STRING

RUN mssql-scripter \
    --connection-string="$CONNECT_STRING" \
    --display-progress \
    --exclude-types User \
    -f ./02_schema.sql

################################################################################
FROM mcr.microsoft.com/mssql/server:2019-latest

LABEL maintainer="dalealleshouse@gmail.com"

USER root

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY --from=scripter /usr/src/app/*.sql .
COPY ./*.sql .
COPY ./run-initialization.sh .
COPY ./entrypoint.sh .

RUN  apt-get update && apt-get install dos2unix
RUN dos2unix ./*.sh

ENV SA_PASSWORD ONE2three4!
ENV ACCEPT_EULA Y

EXPOSE 1433

CMD /bin/bash ./entrypoint.sh

