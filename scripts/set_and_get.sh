#!/usr/bin/bash
redis-server --daemonize yes # run redis-server in the background
redis-cli SET "somekey" "somevalue" # create a key "somekey" containing value "somevalue"
redis-cli GET "somekey" # get the value stored in key "somekey"
redis-cli shutdown # stop redis server