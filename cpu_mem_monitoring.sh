#!/bin/bash
################
#Author: Bhaskara sreenivasa sarma
#Date: 16-10-2024
#Notes: System monitoring based shell scripting
#
practice(){
if [ $# -ne 2 ]; then
        echo "please provide cpu and memory threshold arguments as variables in format: ./alerting.sh cpu_threshold memory_threshold"
else
        echo "performing monitoring for the system based on threshold value"
fi
}
practice "$@"

CPU_Threshold=$1
Memory_Threshold=$2

#calculating current memory and cpu usage in machine
Mem_usage=$(free |awk '/Mem:/ {print $3/$2 *100}')
CPU_usage=$(mpstat 1 1|awk '/Average:/ {print 100 - $12}')


#Function to check cpu and memor usage
#
calc(){
if(($(echo "$Mem_usage>=$Memory_Threshold" | bc -l))); then
        echo "Memory usage above threshold limit,Memory usage value: $Mem_usage"
fi
if(($(echo "$CPU_usage>$CPU_Threshold"|bc -l)));then
        echo "CPU Usage above threshold limit, cpu usage: $Mem_usage"
fi
echo "CPU usage value: $CPU_usage"
echo "Memory usage value: $Mem_usage"
}

#calling the function
calc
