FROM tkmr/workstation

# Install word2vec
RUN svn checkout http://word2vec.googlecode.com/svn/trunk/ /usr/local/word2vec
RUN cd /usr/local/word2vec && make && chmod -R 777 /usr/local/word2vec

# Install mecab
RUN apt-get -y -q install mecab mecab-naist-jdic python-mecab

# Clean up APT when done.
# RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
