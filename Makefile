start:
	redis-server --daemonize yes
	redis-cli ping
stop:
	redis-cli shutdown
start-cli:
	redis-server --daemonize yes
	redis-cli