#!/bin/bash

# load configuration file, per user options overide global options.
mkdir -p $HOME/.rdp
source $HOME/.rdp/rdp.cfg

# if no arg is given print host inventory and exit.
if [ $# -eq 0 ];
then
  echo "host domain description gateway" > /tmp/rdp_header
  echo "---- ------ ----------- -------" > /tmp/rdp_lines
  grep '^RDP_HOSTS' $HOME/.rdp/rdp.cfg | cut -d "[" -f2 | sed 's/]=//' | tr -s '"' " " | cut -d " " -f1,2,3,4 > /tmp/rdp_body
  cat /tmp/rdp_header /tmp/rdp_lines /tmp/rdp_body | column -t
  exit
fi

# exit if host does not exist in the config.
if ! [[ -v "RDP_HOSTS[$1]" ]];
then
  echo "$1: Not such host in $HOME/.rdp/rdp.cfg"
  exit 1
fi

# Get the arguments
DOMAIN=`echo ${RDP_HOSTS[$1]} | cut -d " " -f1`
DESCRIPTION=`echo ${RDP_HOSTS[$1]} | cut -d " " -f2`
GATEWAY=`echo ${RDP_HOSTS[$1]} | cut -d " " -f3`
USERNAME=`echo ${RDP_HOSTS[$1]} | cut -d " " -f4`
PASSWORD=`echo ${RDP_HOSTS[$1]} | cut -d " " -f5`
PORT=$(( ( RANDOM % 30000 ) + 10000 ))

nohup bash -c """ssh -L $PORT:$1:3389 $GATEWAY -S /tmp/.rdp-$1 -M -fN rpd-$1 && \
                 xfreerdp /dynamic-resolution /cert-ignore /v:localhost:$PORT /u:"$USERNAME" /p:"$PASSWORD" /title:"$1" /bpp:15 /d:"$DOMAIN" /timeout:30000
                 ssh -S /tmp/.rdp-$1 -O exit rdp-$1""" 2>/dev/null &

                 
