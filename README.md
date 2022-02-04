# CREU

Concepts for REdis Usage (créu) is my study repository for basic Redis concepts.

[Redis](https://redis.io/) is an in-memory, key-value data store, used primarily for cache and message broking.

## Basic CLI commands

Based on Redis official website [tutorial](https://try.redis.io/)

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

### `SADD` 
