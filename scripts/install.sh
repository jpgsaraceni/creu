#!/usr/bin/bash
wget http://download.redis.io/redis-stable.tar.gz # download redis
tar xvzf redis-stable.tar.gz # unzip
cd redis-stable # enter directory
make # install
sudo make install # make sure binaries are in the right place
redis-server -- daemonize yes # run redis server in the background
redis-cli ping # PONG
redis-cli shutdown # kill redis-server