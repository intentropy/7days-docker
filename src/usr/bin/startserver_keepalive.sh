#!/bin/bash
echo Starting 7d2d server
while true; do
    ./startserver.sh -configfile=serverconfig.xml
    echo 7d2d Server crash, restarting...
done