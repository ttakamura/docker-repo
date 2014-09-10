FROM 247d535101235709f65009c7f092d63d34047224386fb03a00512774a346a75f

RUN apt-get update
RUN apt-get -y -q install locate build-essential git-core postgresql-server-dev-9.2
RUN cd /usr/local && git clone https://github.com/eulerto/pg_similarity.git && cd pg_similarity && USE_PGXS=1 make && USE_PGXS=1 make install
