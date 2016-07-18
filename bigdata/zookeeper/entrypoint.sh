#!/usr/bin/env bash

mkdir -p /zookeeper/data /zookeeper/wal /zookeeper/log
mkdir -p /tmp/zookeeper

if [ -n "$SERVERS" ]; then
	
	h=`hostname`
	i=$((${#str}-1))
	echo ${h:$i:1} > /tmp/zookeeper/myid

	IFS=\, read -a servers <<<"$SERVERS"
	for i in "${!servers[@]}"; do 
		printf "\nserver.%i=%s:2888:3888" "$((1 + $i))" "${servers[$i]}" >> /zookeeper/conf/zoo.cfg
	done
	echo '' >> /zookeeper/conf/zoo.cfg
fi

echo 'Starting Zookeeper server...'
zkServer.sh start-foreground