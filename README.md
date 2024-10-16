# shell_scripting
Bash scripting
use export command to set variables for username and gittoken

synatx: export username="seena127"

check the parameters using echo $username

For backup automation to s3 bucket configure aws cli in ec2 instance

to set a cronjob

crontab -e

add the cron value eg to perform execution of script at 10PM regularly use "0 22 * * * /home/ubuntu/backup/backup.sh"

after adding check the cron value using crontab -l

#To redirect outputs and error to log files use "0 22 * * * /path/to/your/script.sh >> /path/to/logfile.log 2>&1"
