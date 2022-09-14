#!/bin/bash
cd '/root/Steam/steamapps/common/7 Days to Die Dedicated Server'
config_7days
./startserver.sh -configfile=serverconfig.xml &
while true; do
    sleep 10
    tail -f /7days_data/7DaysToDieServer_Data/*.txt
done