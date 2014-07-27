#
# Ubuntu Dockerfile
#
# https://github.com/ccp999/hub
#

# Pull base image.
FROM dockerfile/nodejs

# Install zeromq
RUN \
  apt-get install -y libtool autoconf automake uuid-dev && \
  cd /tmp && \
  wget http://download.zeromq.org/zeromq-4.0.4.tar.gz && \
  tar xvzf zeromq-4.0.4.tar.gz && \
  rm -f zeromq-4.0.4.tar.gz && \
  cd zeromq-4.0.4 && \
  ./autogen.sh && \
  ./configure && \
  make && \
  make install && \
  ldconfig

 # Install zeromq Node.js Binding
RUN npm install -g zmq

# install sqlite3
RUN apt-get install -y sqlite3-doc sqlite3 libsqlite3-dev
 
# Install Mongrel2
RUN \
  cd /tmp && \
  wget https://github.com/zedshaw/mongrel2/releases/download/v1.9.1/mongrel2-v1.9.1.tar.gz && \
  tar -xzvf mongrel2-v1.9.1.tar.gz && \
  cd mongrel2-v1.9.1/ && \
  make clean all && \
  make install

# Define mountable directories.
VOLUME ["/data"]

# Define working directory.
WORKDIR /data

# Define default command.
CMD ["bash"]