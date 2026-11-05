#!/bin/bash
# health check for ec2 instance

echo "=== EC2 Health Check ==="
date
echo

echo "Disk:"
df -h /
DISK=$(df / | tail -1 | awk '{print $5}' | tr -d '%')
if [ $DISK -gt 90 ]; then
    echo "CRITICAL: disk is almost full ($DISK%)"
fi
echo

echo "Memory:"
free -h
echo

echo "Jenkins:"
if systemctl is-active --quiet jenkins; then
    echo "jenkins is running"
else
    echo "CRITICAL: jenkins is not running"
fi
