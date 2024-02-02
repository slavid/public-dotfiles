#/bin/bash
echo $(hostname)" --- "$(date +"%d/%m/%Y - %H:%M:%S")" --- "$(vcgencmd measure_temp)
