#!/bin/bash
# EC2 health monitoring - prints OK / WARNING / CRITICAL per check
STATUS=0

echo "=== EC2 Health Report: $(hostname) - $(date) ==="

# Disk usage on /
DISK=$(df / --output=pcent | tail -1 | tr -dc '0-9')
if [ "$DISK" -ge 90 ]; then echo "CRITICAL: disk usage ${DISK}%"; STATUS=2
elif [ "$DISK" -ge 80 ]; then echo "WARNING: disk usage ${DISK}%"
else echo "OK: disk usage ${DISK}%"; fi

# Available memory
MEM=$(free | awk '/Mem:/ {printf "%d", $7/$2*100}')
if [ "$MEM" -le 5 ]; then echo "CRITICAL: only ${MEM}% memory available"; STATUS=2
elif [ "$MEM" -le 15 ]; then echo "WARNING: ${MEM}% memory available"
else echo "OK: ${MEM}% memory available"; fi

# CPU load vs core count
CORES=$(nproc)
LOAD=$(awk '{print $1}' /proc/loadavg)
if awk "BEGIN {exit !($LOAD > $CORES * 2)}"; then echo "CRITICAL: load $LOAD on $CORES cores"; STATUS=2
elif awk "BEGIN {exit !($LOAD > $CORES)}"; then echo "WARNING: load $LOAD on $CORES cores"
else echo "OK: load $LOAD on $CORES cores"; fi

# Jenkins service
if systemctl is-active --quiet jenkins; then echo "OK: jenkins service active"
else echo "CRITICAL: jenkins service not active"; STATUS=2; fi

echo "=== Health check finished ==="
exit 0
