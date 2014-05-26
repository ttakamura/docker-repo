FROM phusion/baseimage:latest

# Set correct environment variables.
ENV HOME /root
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

# takamura user
RUN useradd -m -d /home/takamura -p takamura takamura && adduser takamura sudo && chsh -s /bin/bash takamura
RUN mkdir /home/takamura/.ssh
RUN echo 'ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAwOtlzyFbURlNjv8Hdf4oclNv02ck6hrjNPXPmdrlso4rfoE/cQtbd4RiBAuNtrr2hLuui1ki9oIs9PDcGRKJL/ZAMh2u6zlW5/fpreFOIKcHw8YmjEzIvJ9Ps9aBCEXC7efgsgwkjmuUiHVps8vlG4jqDBbEkbTsdK/eE00HGxQPpC583gXBfkEjKtMXPjSdczH5Z5GKtLc+rxrUT0D+o4ztVKLLYX36YjO2hCqAXIy2ZVHcC5l4UYU+KaO7uQyoKkHxr5egvDwSJrTFaNr9vNhz7cLUZwEpmuOSTlebNGCtKJzrJ0rT7i7z65ZLlbyXtEAZUXGk1MYyyl405/7rvQ== ttakamura@Tatsuya-Takamura-no-MacBook-Pro.local' >> /home/takamura/.ssh/authorized_keys
RUN chown -R takamura:takamura /home/takamura
RUN chmod 700 /home/takamura/.ssh && chmod 600 /home/takamura/.ssh/authorized_keys

# install dependencies
RUN sed -i".bak" -e 's/\/\/archive.ubuntu.com/\/\/ap-northeast-1.ec2.archive.ubuntu.com/g' /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y -q build-essential openjdk-6-jdk python-dev python-boto libcurl4-nss-dev libsasl2-dev autoconf libtool git ruby emacs wget python-setuptools curl zsh tmux subversion

# ssh keys
RUN echo "takamura ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/takamura
RUN echo "AuthorizedKeysFile     /etc/ssh_keys/authorized_keys" >> /etc/ssh/sshd_config
RUN mkdir /etc/ssh_keys
RUN echo 'ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAwOtlzyFbURlNjv8Hdf4oclNv02ck6hrjNPXPmdrlso4rfoE/cQtbd4RiBAuNtrr2hLuui1ki9oIs9PDcGRKJL/ZAMh2u6zlW5/fpreFOIKcHw8YmjEzIvJ9Ps9aBCEXC7efgsgwkjmuUiHVps8vlG4jqDBbEkbTsdK/eE00HGxQPpC583gXBfkEjKtMXPjSdczH5Z5GKtLc+rxrUT0D+o4ztVKLLYX36YjO2hCqAXIy2ZVHcC5l4UYU+KaO7uQyoKkHxr5egvDwSJrTFaNr9vNhz7cLUZwEpmuOSTlebNGCtKJzrJ0rT7i7z65ZLlbyXtEAZUXGk1MYyyl405/7rvQ== ttakamura@Tatsuya-Takamura-no-MacBook-Pro.local' >> /etc/ssh_keys/authorized_keys
RUN chown -R takamura:takamura /etc/ssh_keys
RUN chmod 700 /etc/ssh_keys && chmod 600 /etc/ssh_keys/authorized_keys
