#!/usr/bin/env bash

sys=$(df -h | grep nvme0n1p2 | awk '{print "sys", "u" $3, "a" $4}')
hav=$(df -h | grep sdc1      | awk '{print "hav", "u" $3, "a" $4}')

echo "$sys | $hav"
