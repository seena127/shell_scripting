#!/bin/bash
################
#Author: Bhaskara sreenivasa sarma
#Date: 16-10-2024
#Notes: System monitoring based shell scripting
#
practice(){
if [ $# -ne 3 ]; then
        echo "please provide cpu and memory threshold arguments as variables in format: ./alerting.sh cpu_threshold memory_threshold disk_space_threshold"
        exit 1
else
        echo "performing monitoring for the system based on threshold value"
fi
}
practice "$@"

CPU_Threshold=$1
Memory_Threshold=$2
Disk_needed=$3

#calculating current memory and cpu usage in machine
Mem_usage=$(free |awk '/Mem:/ {print $3/$2 *100}')
CPU_usage=$(mpstat 1 1|awk '/Average:/ {print 100 - $12}')
Disk_available=$( df -h | awk '$NF=="/"{print 100-$5+0}')

#Function to check cpu and memor usage
#
calc(){
if(($(echo "$Mem_usage>=$Memory_Threshold" | bc -l))); then
        echo "Memory usage above threshold limit,Memory usage value: $Mem_usage"
fi
if(($(echo "$CPU_usage>$CPU_Threshold"|bc -l)));then
        echo "CPU Usage above threshold limit, cpu usage: $Mem_usage"
fi
if(($(echo "$Disk_needed>$Disk_available" | bc -l) )); then
        echo "Disk available is less than needed,, disk available percent: $Disk_usage"
fi
echo "CPU usage value: $CPU_usage"
echo "Memory usage value: $Mem_usage"
echo "Disk space Available: $Disk_available"
}

#calling the function
calc


#to configure with aws sns using aws cli 
#perform aws configure
#SNS_TOPIC_ARN="arn:aws:sns:us-east-1:123456789012:YourSNSTopic"
#aws sns publish --topic-arn "$SNS_TOPIC_ARN" --message "$message" --subject "System Monitoring Alert"
