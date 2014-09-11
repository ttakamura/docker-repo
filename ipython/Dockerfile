#  FROM phusion/baseimage:latest
#
#  # Set correct environment variables.
#  ENV HOME /root
#  RUN /etc/my_init.d/00_regen_ssh_host_keys.sh
#
#  # takamura user
#  RUN useradd -m -d /home/takamura -p takamura takamura && adduser takamura sudo && chsh -s /bin/bash takamura
#  RUN mkdir /home/takamura/.ssh
#  RUN echo 'ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAwOtlzyFbURlNjv8Hdf4oclNv02ck6hrjNPXPmdrlso4rfoE/cQtbd4RiBAuNtrr2hLuui1ki9oIs9PDcGRKJL/ZAMh2u6zlW5/fpreFOIKcHw8YmjEzIvJ9Ps9aBCEXC7efgsgwkjmuUiHVps8vlG4jqDBbEkbTsdK/eE00HGxQPpC583gXBfkEjKtMXPjSdczH5Z5GKtLc+rxrUT0D+o4ztVKLLYX36YjO2hCqAXIy2ZVHcC5l4UYU+KaO7uQyoKkHxr5egvDwSJrTFaNr9vNhz7cLUZwEpmuOSTlebNGCtKJzrJ0rT7i7z65ZLlbyXtEAZUXGk1MYyyl405/7rvQ== ttakamura@Tatsuya-Takamura-no-MacBook-Pro.local' >> /home/takamura/.ssh/authorized_keys
#  RUN chown -R takamura:takamura /home/takamura
#  RUN chmod 700 /home/takamura/.ssh && chmod 600 /home/takamura/.ssh/authorized_keys
#
#  # install dependencies
#  RUN sed -i".bak" -e 's/\/\/archive.ubuntu.com/\/\/ap-northeast-1.ec2.archive.ubuntu.com/g' /etc/apt/sources.list
#  RUN apt-get update
#  RUN apt-get install -y -q build-essential openjdk-6-jdk python-dev python-boto libcurl4-nss-dev libsasl2-dev autoconf libtool git ruby emacs wget python-setuptools curl zsh tmux subversion
#
#  # ssh keys
#  RUN echo "takamura ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/takamura
#  RUN echo "AuthorizedKeysFile     /etc/ssh_keys/authorized_keys" >> /etc/ssh/sshd_config
#  RUN mkdir /etc/ssh_keys
#  RUN echo 'ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAwOtlzyFbURlNjv8Hdf4oclNv02ck6hrjNPXPmdrlso4rfoE/cQtbd4RiBAuNtrr2hLuui1ki9oIs9PDcGRKJL/ZAMh2u6zlW5/fpreFOIKcHw8YmjEzIvJ9Ps9aBCEXC7efgsgwkjmuUiHVps8vlG4jqDBbEkbTsdK/eE00HGxQPpC583gXBfkEjKtMXPjSdczH5Z5GKtLc+rxrUT0D+o4ztVKLLYX36YjO2hCqAXIy2ZVHcC5l4UYU+KaO7uQyoKkHxr5egvDwSJrTFaNr9vNhz7cLUZwEpmuOSTlebNGCtKJzrJ0rT7i7z65ZLlbyXtEAZUXGk1MYyyl405/7rvQ== ttakamura@Tatsuya-Takamura-no-MacBook-Pro.local' >> /etc/ssh_keys/authorized_keys
#  RUN chown -R takamura:takamura /etc/ssh_keys
#  RUN chmod 700 /etc/ssh_keys && chmod 600 /etc/ssh_keys/authorized_keys
#
#  # ///////////////////
#
#  # Install word2vec
#  RUN svn checkout http://word2vec.googlecode.com/svn/trunk/ /usr/local/word2vec
#  RUN cd /usr/local/word2vec && make && chmod -R 777 /usr/local/word2vec
#
#  # Install other tools
#  RUN apt-get -y -q install mecab mecab-naist-jdic python-mecab
#  RUN apt-get -y -q install python-sklearn libboost-all-dev
#  RUN cd /usr/local/word2vec && git clone https://github.com/nishio/mycorpus.git && cd mycorpus && git clone https://github.com/nishio/word2vec_boostpython && cd word2vec_boostpython && python setup.py install
#  RUN apt-get -y -q install dstat unzip git
#
#  # compilers and basic tools
#  RUN apt-get install -y -q gfortran libxml2-dev libxslt-dev python-numpy python-scipy python-matplotlib libopenblas-base libatlas3gf-base liblapack-dev openjdk-7-jdk ipython-notebook
#  RUN easy_install pip && pip install gensim==0.10.0 cython pygments pypandoc CodernityDB
#
#  RUN apt-get remove -y -q ipython-notebook && pip install ipython==2.1.0
#  RUN apt-get install -y -q pandoc
#  RUN pip install pandas
#  RUN apt-get install -y -q postgresql-client python-psycopg2 tmux mosh mecab-ipadic-utf8 mecab-jumandic-utf8 nkf language-pack-ja
#
#
#
#  # misc
#  RUN echo 'userdic = /mnt/tool/mecab/hatena.dic, /mnt/tool/mecab/wikipedia.dic' >> /etc/mecabrc
#  RUN pip install lshash==0.0.4dev
#  ADD ipag.ttc /usr/local/word2vec/mycorpus/ipag.ttc
#  RUN update-locale LANG=ja_JP.UTF-8
#
#  commit as tab_inc/sim_items:v1
#

FROM tab_inc/sim_items:v1

RUN pip install theano
RUN apt-add-repository -y ppa:staticfloat/juliareleases && apt-get update && apt-get install -y julia
RUN chown root /usr/lib/sudo/sudoers.so && apt-get install -y libnettle4
RUN julia -e 'Pkg.add("IJulia")' && julia -e 'Pkg.add("PyPlot")'


RUN mkdir      /etc/service/ipython
ADD ipython.sh /etc/service/ipython/run
RUN chmod 755  /etc/service/ipython/run
RUN mkdir      /mnt2

CMD ["/sbin/my_init"]
