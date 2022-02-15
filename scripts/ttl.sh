#!/usr/bin/bash
redis-cli SET somekey "some value" EX 10 # set key with TTL=10 seconds
redis-cli TTL somekey # get TTL of somekey