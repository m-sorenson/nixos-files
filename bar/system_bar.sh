#! /usr/bin/env bash

while :; do
    echo -n "^fn(FontAwesome:size=13)^fn() $(acpi -b | cut -d ',' -f 2)   "
    echo  "^fn(FontAwesome:size=13)^fn() $(date +%T)   "
    sleep 1
done | dzen2 -x '1520' -y '0' -h '25' -w '400' -ta 'r' -fg '#cfd8dc' -bg '#212121' -fn 'Iosevka' -dock

