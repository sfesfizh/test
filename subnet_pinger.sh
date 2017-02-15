#!/usr/bin/env bash

ip=1
until [ "$ip" -gt "$(sipcalc $1|grep -i usable|awk '{print $NF}'|cut -d"." -f4)" ]
do
    fping $(echo $1|cut -d"." -f1,2,3).$ip
    ip=$(($ip+1))
done