FROM postgres:13-alpine
LABEL maintainer="heka1024 <heka1024@gmail.com>"
ARG ARG_PG_BIGM_VERSION="1.2-20200228"

ENV PG_BIGM_VERSION=${ARG_PG_BIGM_VERSION}

RUN apk --update --no-cache add --virtual build-dependencies curl make gcc musl-dev postgresql-dev icu-dev \
    && cd /tmp \
    && curl -k -L -O "https://osdn.net/dl/pgbigm/pg_bigm-$PG_BIGM_VERSION.tar.gz" \
    && tar zxfv "pg_bigm-$PG_BIGM_VERSION.tar.gz" \
    && cd "pg_bigm-$PG_BIGM_VERSION" \
    && make USE_PGXS=1 \
    && make USE_PGXS=1 install \
    && echo "shared_preload_libraries = 'pg_bigm'" >> /usr/local/share/postgresql/postgresql.conf.sample \
    && rm -fr "/tmp/pg_bigm-$PG_BIGM_VERSION" \
    && apk del --purge build-dependencies