#!/bin/bash

verify_key="3xt3nd1ngpupp3t"
cert_name=$1

agent_key_file="/etc/puppetlabs/puppet/ssl/ca/requests/$cert_name.pem"
if [ ! -f $agent_key_file ]
then
  exit 1
fi

agent_key="$(openssl req -noout -text -in /etc/puppetlabs/puppet/ssl/ca/requests/"$cert_name".pem | grep challengePassword | awk -F':' '{ print $NF }')"

if [ "$verify_key" == "$agent_key" ]
then
  exit 0
else
  exit 1
fi
