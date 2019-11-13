#!/bin/sh

FN_IF="/var/lib/iserv/dns-ula/interface"

if ! [ -s "$FN_IF" ]
then
  exit 0
fi

IF="$(< "$FN_IF")" 

if ! netquery6 nic | grep -q '^'"$IF"'$'
then
  exit 0
fi

cat <<EOT
auto $IF
iface $IF inet6 auto
	address fd00::53/128

EOT
