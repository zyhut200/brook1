#!/bin/bash

### BEGIN INIT INFO
# Provides:          Brook-pf
# Required-Start:    $network $local_fs $remote_fs
# Required-Stop:     $network $local_fs $remote_fs
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Lightweight port forwarding tool
# Description:       Start or stop the Brook-pf
### END INIT INFO

NAME="Brook-ay"
NAME_BIN="brook relay"
FILE="/usr/local/brook-ay"
CONF="${FILE}/brook.conf"
LOG="${FILE}/brook.log"
C=33255

do_start(){
    killall brook
	while read line
    do
        eval nohup $FILE/brook relay -f :$C -t $line >> "${LOG}" 2>&1 &
        C=$((C+11))
    done < "${CONF}"
}
do_stop(){
    killall brook
}
do_status(){
    echo ""
}

do_restart(){
    echo ""
}

case "$1" in
	start|stop|restart|status)
	do_$1
	;;
	*)
	echo -e "使用方法: $0 { start | stop | restart | status }"
	RETVAL=1
	;;
esac
exit $RETVAL