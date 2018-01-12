#!/bin/sh

# A simple init script

#rootdir=/var/www/vamp-plugins.org
rootdir=/home/cannam/code/vamp-rdf-download-index

logdir="$rootdir/log"
logfile="$logdir/spark.log"

find_pid() {
    ps auxw | grep 'java pluginlist' | grep -v grep | awk '{ print $2; }'
}

start() {
    if [ ! -d "$logdir" ]; then
	if [ -d "$rootdir" ]; then
	    mkdir -p "$logdir" || return 1
	else
	    echo "Root dir $rootdir not found" ; return 1
	fi
    fi
    if [ -f "$logfile" ]; then
        echo "*** Restarting at $(date)" >> "$logfile"
    fi
    ( cd "$rootdir" && ./scripts/run.sh >> "$logfile" 2>&1 & ) || return 1
}    

stop() {
    pid=$(find_pid)
    if [ -n "$pid" ]; then
	kill -HUP "$pid" && echo "Killed pid $pid"
    else
	echo "Failed to find pid of running app" ; return 1
    fi
}

case $1 in

    start)
	echo "Starting Vamp Spark app..."
	pid=$(find_pid)
	if [ -n "$pid" ]; then 
	    echo "Seems to be already running, with pid $pid"; exit 1;
	fi
	start && echo "(Check $logfile for logs)" && echo Done;;

    stop)
	echo "Stopping Vamp Spark app..."
	stop && echo Done;;

    restart)
	echo "Restarting Vamp Spark app..."
	stop
	start && echo "(Check $logfile for logs)" && echo Done;;

    *)
	echo "Usage: $0 {start|stop|restart}"
	exit 2;;

esac;

	    
