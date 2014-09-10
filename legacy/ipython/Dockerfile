FROM tkmr/workstation

# Install word2vec
RUN svn checkout http://word2vec.googlecode.com/svn/trunk/ /usr/local/word2vec
RUN cd /usr/local/word2vec && make && chmod -R 777 /usr/local/word2vec

# Install other tools
RUN apt-get -y -q install mecab mecab-naist-jdic python-mecab
RUN apt-get -y -q install python-sklearn libboost-all-dev
RUN cd /usr/local/word2vec && git clone https://github.com/nishio/mycorpus.git && cd mycorpus && git clone https://github.com/nishio/word2vec_boostpython && cd word2vec_boostpython && python setup.py install
RUN apt-get -y -q install dstat unzip git

# compilers and basic tools
RUN apt-get install -y -q gfortran libxml2-dev libxslt-dev python-numpy python-scipy python-matplotlib libopenblas-base libatlas3gf-base liblapack-dev openjdk-7-jdk ipython-notebook
RUN easy_install pip && pip install gensim==0.10.0 cython pygments pypandoc CodernityDB pandas lshash==0.0.4dev
RUN apt-get remove -y -q ipython-notebook && pip install ipython==2.1.0
RUN apt-get install -y -q pandoc postgresql-client python-psycopg2 tmux mosh mecab-ipadic-utf8 mecab-jumandic-utf8 nkf language-pack-ja

# misc
RUN echo 'userdic = /mnt/tool/mecab/hatena.dic, /mnt/tool/mecab/wikipedia.dic' >> /etc/mecabrc
RUN pip install
RUN update-locale LANG=ja_JP.UTF-8

# RUN mkdir      /etc/service/ipython
# ADD ipython.sh /etc/service/ipython/run
# RUN chmod 755  /etc/service/ipython/run

# CMD ["/sbin/my_init"]
