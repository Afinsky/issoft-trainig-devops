#!/bin/bash

#set -x
_pid=$(pgrep -x $1 | head -1)

function list_offspring {
  tp=`pgrep -P $1`          #get childs pids of parent pid
  for i in $tp; do          #loop through childs
    if [ -z $i ]; then      #check if empty list
      echo "Pid $1 has no children"
      kill -9 $1
      exit                  #if empty: exit
    else                    #else
      echo -n -e "Childs pid is $i . Parrent is $1\n"         #print childs pid
      list_offspring $i     #call list_offspring again with child pid as the parent
    fi;
  done
}

list_offspring $_pid

