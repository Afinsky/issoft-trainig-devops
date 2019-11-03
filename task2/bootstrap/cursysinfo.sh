#!/bin/bash
#This is manual script, not of system, that moved into /bin directory
uptime; echo -e '\n'
echo -n "Process count: "; ps aux | wc -l; echo -e '\n'
free -h; echo -e '\n'
df -ha /dev/sd* | grep -E sd??; echo -e '\n'

ip -4 a; echo -e '\n'

uname -a
