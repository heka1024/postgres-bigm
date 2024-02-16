FROM postgres:13
LABEL maintainer="heka1024 <heka1024@gmail.com>"

RUN apt update
RUN apt install -y postgresql-server-dev-13 make gcc wget libicu-dev

RUN wget --no-check-certificate https://osdn.net/dl/pgbigm/pg_bigm-1.2-20200228.tar.gz
RUN tar zxf pg_bigm-1.2-20200228.tar.gz
RUN cd pg_bigm-1.2-20200228 && make USE_PGXS=1 && make USE_PGXS=1 install

RUN echo shared_preload_libraries='pg_bigm' >> /var/lib/postgresql/data/postgresql.conf

ENTRYPOINT ["docker-entrypoint.sh"]
EXPOSE 5432
CMD ["postgres"]