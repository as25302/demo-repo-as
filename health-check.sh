#!/bin/bash
# Simple server health check for Jenkins lab
echo "=== Health Check: $(hostname) ==="
echo "Date: $(date)"
echo
echo "--- Uptime ---"
uptime
echo
echo "--- Disk usage ---"
df -h /
echo
echo "--- Memory ---"
free -h
echo
echo "--- Jenkins service ---"
systemctl is-active jenkins || echo "jenkins service not active"
echo
echo "=== Health Check Completed ==="
