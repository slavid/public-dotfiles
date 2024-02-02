#!/bin/bash

#ps -au | grep Xorg | awk '{print $2}' | head -n 1 | xargs sudo renice -n -20 -p

# ps -eLf | grep Xorg | awk '{print $4}' | head -n 2 | xargs sudo renice -n -20 -p

while [[ -z "$(ps -au | grep Xorg |grep -v grep | awk '{print $2}')" ]]; do
#  echo "String vacio"
  sleep 0.5
done

#sleep 5
ps -au | grep Xorg | awk '{print $2}' | head -n 1 | xargs sudo renice -n -20 -p
