#!/usr/bin/bash

##### JAVASCRIPT OBJECT #####
# const myObject = {
#   aKey: "a value",
#   anotherKey: "another value"   
# }

##### REDIS HASH #####
redis-cli HSET myObject aKey "a value" anotherKey "another value" # sets a
# hash with key=myObject, and fields aKey and anotherKey, with values 
# "a value" and "another value"