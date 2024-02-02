#/bin/bash
#Variables
# Numero de procesadores (Alternativa: lscpu | grep CPU\(s\)\: | awk '{print $2}')
#NUM_PROC=$(nproc)
# Sacamos el primer valor de loadavg (carga en el sistema durante el ultimo minuto) y lo multiplicamos por 100 ((avg/nº cores)*100)
CPU_USE=$(cat /proc/loadavg | awk -v NUM_PROC="$(nproc)" '{print ($2 * 100)/NUM_PROC}')
# Dividimos entre el numero de cores y limitamos la division a 2 decimales (scale=2)
#CPU_USE=$(echo "scale=2; $CPU_USE/$NUM_PROC" | bc -l)
echo $(hostname)" --- "$(date +"%d/%m/%Y - %H:%M:%S")" --- "$(vcgencmd measure_temp)" --- "CPU: ""$CPU_USE"%"
