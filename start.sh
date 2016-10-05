#!/bin/bash

set -e

export CRON_SCHEDULE=${CRON_SCHEDULE:-11 3 * * *}

usage() {
    cat <<EOF
Error: must specify an certbot operation
EOF
    exit 1
}

if [ $# -lt 2 ]; then
   usage
fi


case $1 in 

    scheduled)
	shift 1
	if [ $# -eq 0 ]; then usage; fi
	echo "Scheduling cron:$CRON_SCHEDULE, command: certbot $*" 
	LOGFIFO='/var/log/cron.fifo'
	if [[ ! -e "$LOGFIFO" ]]; then
	    mkfifo "$LOGFIFO"
	fi
	echo -e "$CRON_SCHEDULE /opt/certbot/venv/bin/certbot $* > $LOGFIFO 2>&1" | crontab -
	cron
	tail -f "$LOGFIFO"
	;;
    
    *)
	certbot $*
esac
