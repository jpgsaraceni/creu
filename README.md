# CREU

Concepts for REdis Usage (créu) is my study repository for basic Redis concepts.

[Redis](https://redis.io/) is an in-memory, key-value data store, used primarily for cache and message broking.

## Contents

- [Install Redis](#install-redis) 
- [Start Redis Server](#start-redis-server)
- [CLI](#cli)
  - [SET](#set-to-write-a-new-key-value-pair)
  - [GET](https://github.com/jpgsaraceni/creu/edit/main/README.md#get-to-read-the-value-of-a-key)
  - [EXISTS](https://github.com/jpgsaraceni/creu/edit/main/README.md#exists-to-check-if-key-exists)
  - [DEL](https://github.com/jpgsaraceni/creu/edit/main/README.md#del-to-delete-a-key)
  - [INCR and DECR](https://github.com/jpgsaraceni/creu/edit/main/README.md#incr-and-decr-to-increment-or-decrement-the-value-of-a-key)
  - [EXPIRE](https://github.com/jpgsaraceni/creu/edit/main/README.md#expire-and-pexpire-to-set-number-of-seconds-or-milliseconds-until-a-key-is-deleted)
  - [TTL](https://github.com/jpgsaraceni/creu/edit/main/README.md#ttl-and-pttl-to-get-remaining-seconds-or-milliseconds-until-a-key-expires)
  - [RPUSH and LPUSH](https://github.com/jpgsaraceni/creu/edit/main/README.md#rpush-and-lpush-push-a-new-element-to-an-ordered-list-and-return-length-of-list)
  - [LRANGE](https://github.com/jpgsaraceni/creu/edit/main/README.md#lrange-reads-a-subset-of-the-list)
  - [LPOP and RPOP](https://github.com/jpgsaraceni/creu/edit/main/README.md#lpop-and-rpop-remove-and-return-an-element-from-a-list)
  - [LLEN](https://github.com/jpgsaraceni/creu/edit/main/README.md#llen-returns-the-number-of-elements-in-a-list)
  - [SADD](https://github.com/jpgsaraceni/creu/edit/main/README.md#sadd-adds-an-element-to-a-set)
  - [SREM](https://github.com/jpgsaraceni/creu/edit/main/README.md#srem-removes-an-element-from-a-set)
  - [Other operations with sets](https://github.com/jpgsaraceni/creu/edit/main/README.md#oher-set-operations)
  - [Sorted sets](https://github.com/jpgsaraceni/creu/edit/main/README.md#sorted-sets)
  - [Hashes](https://github.com/jpgsaraceni/creu/edit/main/README.md#hashes)
- [Scripts](#scripts)

## Install Redis

Redis oficial website [quick start](https://redis.io/topics/quickstart) suggests compiling from source (calm down, it's easy) Note: Redis has no oficial support for windows.

(good practice to do this in /usr/local)

```shell
wget http://download.redis.io/redis-stable.tar.gz
tar xvzf redis-stable.tar.gz
cd redis-stable
make
```

Put binaries in right place

```shell
sudo make install
```

## Start redis server

```shell
redis-server
```

## CLI

With a redis server running, execute:

```shell
redis-cli
```

You can check if Redis CLI is working correctly by pinging:

```console
127.0.0.1:6379> PING
PONG
```

Basic CLI commands (based on Redis official website [tutorial](https://try.redis.io/):

### `SET` to write a new key-value pair

Example:

```shell
SET somekey "somevalue"
```

### `GET` to read the value of a key

```shell
GET somekey
# "somevalue"
```

### `EXISTS` to check if key exists

```shell
EXISTS somekey
# (integer) 1
EXISTS anotherkey
# (integer) 0
```

### `DEL` to delete a key

```shell
DEL somekey
```

### `INCR` and `DECR` to increment or decrement the value of a key

If the key does not exist, `INCR` creates with value = 1 and `DECR` with value = -1.
`INCRBY` and `DECRBY` take the value to increment/decrement by as second argument.

```shell
INCR newkey
# (integer) 1
INCR newkey
# (integer) 2
INCRBY newkey 10
# (integer) 12
DECR newkey
# (integer) 11
DECRBY newkey 5
# (integer) 6
```

**Using `INCR` and `DECR` instead of reading, incrementing than writing asures atomicity in case of multiple clients executing concurrent operations.**

### `EXPIRE` (and `PEXPIRE`) to set number of seconds (or milliseconds) until a key is deleted

```shell
SET anotherkey "i will expire in 10 seconds"
EXPIRE anotherkey 10
```

### `TTL` (and `PTTL`) to get remaining seconds (or milliseconds) until a key expires

```shell
TTL anotherkey
# (integer) 5
```

If a key is expired, `TTL` returns -2. If the key is not set to expire, -1.

**You can set a TTL when creating a key using `EX`:**

```shell
SET expiresfast EX 1
```

**And cancel expiration with `PERSIST`**

```shell
PERSIST expiresfast
```

### `RPUSH` and `LPUSH` push a new element to an ordered list, and return length of list

If the list does not yet exist, it is created.
**`RPUSH` pushes to the end (right) and `LPUSH` pushes to the start (left)**

```shell
RPUSH mylist "first element" # (integer) 1
# 1) "first element"
LPUSH mylist "second element" # (integer) 2
# 1) "second element"
# 2) "first element"
RPUSH mylist "third element" # (integer) 3
# 1) "second element"
# 2) "first element"
# 3) "third element"
RPUSH mylist "accepts" "multiple" "arguments" # (integer) 6
# 1) "second element"
# 2) "first element"
# 3) "third element"
# 4) "accepts"
# 5) "multiple"
# 6) "arguments"
```

### `LRANGE` reads a subset of the list

Pass start and end (inclusive) indexes as arguments

```shell
LRANGE 0 -1 mylist
# the full list
```

### `LPOP` and `RPOP` remove and return an element from a list

```shell
LPOP mylist
# "second element"
```

### `LLEN` returns the number of elements in a list

```shell
LLEN mylist
# (integer) 4
```

### `SADD` adds an element to a set

Sets are similar to lists, except they aren't ordered and elements must be unique.

```shell
SADD setkey "first value" # (integer) 1
SADD setkey "also" "variadic" # (integer) 2
SADD setkey "first value" # (integer) 0
```

### `SREM` removes an element from a set

Returns 1 if removed or 0 if not present

```shell
SREM setkey "second value" # (integer) 0
SREM setkey "first value" # (integer) 1
```

### Oher set operations

```shell
SISMEMBER setkey "also" # (integer) 1
SISMEMBER setkey "something not in set" # (integer) 0
SMEMBERS setkey # 1) "also", 2) "variadic"
SUNION setkey existentset # 1) "also", 2) "variadic", 3) "elements from second set"
SPOP setkey 1 # 1) "also" ## randomly pops number of elements equal to argument
SRANDOM setkey 2 # 1) "also", 2) "variadic"
```

### Sorted sets

```shell
ZADD sortedset 10 "element with score 10"
ZADD sortedset 101 "element with score 101"
ZRANGE sortedset 0 -1 # 1) "element with score 10", 2) "element with score 101"
```

### Hashes

```shell
HSET myobject name "cool name" # 1
HSET myobject email "cool@email.com" # 1
HGETALL myobject # 1) "name", 2) "cool name", 3) "email", 4) "cool@email.com"
HGET myobject name # "cool name"
HSET myobject count 5 # 1
HINCRBY myobject count 6 # (integer) 11
HDEL myobject count # (integer) 1
```

## Scripts

- [Installing Redis](https://github.com/jpgsaraceni/creu/blob/main/scripts/install.sh)
- [Example of GET and SET commands](https://github.com/jpgsaraceni/creu/blob/main/scripts/set_and_get.sh)
