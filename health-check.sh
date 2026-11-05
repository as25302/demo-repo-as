#!/bin/bash
# health check for jenkins lab
echo "=== Health Check: $(hostname) ==="
date
echo
echo "Uptime:"
uptime
echo
echo "Disk:"
df -h /
echo
echo "Memory:"
free -h
echo
echo "Jenkins service:"
systemctl is-active jenkins
echo "=== Health Check Completed ==="
