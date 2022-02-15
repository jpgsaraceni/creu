#!/usr/bin/bash
# lists are commonly used for social media feeds
redis-cli LPUSH posts postId1
redis-cli LPUSH posts postId2
redis-cli LPUSH posts postId3
redis-cli LPUSH posts postId4
redis-cli LPUSH posts postId5
redis-cli LPUSH posts postId6
redis-cli LPUSH posts postId7
redis-cli LPUSH posts postId8
# get 5 latest posts that will be initially showed
redis-cli LRANGE 0 4
