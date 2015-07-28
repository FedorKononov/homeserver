#!/bin/sh
### BEGIN INIT INFO
# Provides:          skeleton
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Example initscript
# Description:       This file should be used to construct scripts to be
#                    placed in /etc/init.d.
### END INIT INFO

# Carry out specific functions when asked to by the system
case "$1" in
	start)

		echo "starting boogeyman"
		# start new proceses
		#/usr/bin/php /home/boogeyman/htdocs/artisan backuper:db_backup >> /tmp/backuper.log
		/usr/bin/php /home/boogeyman/htdocs/artisan updater:update >> /tmp/updater.log
		/usr/bin/php /home/boogeyman/htdocs/artisan boogeyman:scare < /dev/null > /tmp/boogeyman.log 2>/dev/null &
		/usr/bin/nodejs /home/boogeyman/notif/app.js < /dev/null > /tmp/boogeyman-notif.log 2>/dev/null &

		exit 0
	;;
	stop)
		# kill all current processes
		for pid in $(ps aux | grep boogeyman | awk '{print $2}')
		do
			#echo $pid

			if [ "$$" != "$pid" ]
				then
					kill -15 $pid 2> /dev/null
			fi
		done
		exit 0
	;;
  *)
    echo "Usage: /etc/init.d/boogeyman {start|stop}"
    exit 1
    ;;
esac

exit 0