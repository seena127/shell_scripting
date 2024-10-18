#!/bin/bash
#
#############
#Author: Bhaskara sreenivasa sarma
#Date: 18-10-2024
#Notes: log rotation for /var/log/syslog folder
#
#
check(){
        if [ $# -ne 2 ];then
                echo "please executhe script in ./alerting.sh archive_destination retention_period"
                exit 1
        else
                echo "log rotaion to $1 is being intiated"
        fi
        if [ ! -d "$1" ];then
                echo "creating mentioned directory as it does not exists currently: $1"
               mkdir -p $1
        fi

}
check "$@"
log_dir="/home/ubuntu/backup/new2"
destination="$1"

current_date=$(date +%Y%m%d)
for logfile in "$log_dir"/*.log; do
            if [[ -f "$logfile" ]]; then
                            rotated_log="$destination/$(basename "$logfile").$current_date.gz"
                             # Rotate the log
                            gzip -c "$logfile" > "$rotated_log" && echo "Rotated: $logfile to $rotated_log"\
                            # Clear the original log file
                            rm -rf  "$logfile"
                                        fi
                                done
time_mentioned="$2"

echo "Deleting log files of retention period $time_mentioned in minutes from $log_dir"

#use this for log roation in minutes
find "$destination" -type f -name "*.gz" -mmin +$time_mentioned -exec rm {} \;


#use this for log rotation for days
#find "$destination" -type f -name "*.gz" -mtime +$time_mentioned -exec rm {} \;

echo "Log rotation complete."
