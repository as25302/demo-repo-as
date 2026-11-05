#!/bin/bash
# EC2 instance information (uses IMDSv2 token)
TOKEN=$(curl -s -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 300")
md() { curl -s -H "X-aws-ec2-metadata-token: $TOKEN" "http://169.254.169.254/latest/meta-data/$1"; }

echo "=== EC2 Instance Information ==="
echo "Instance ID:   $(md instance-id)"
echo "Instance Type: $(md instance-type)"
echo "Public IP:     $(md public-ipv4)"
echo "Private IP:    $(md local-ipv4)"
echo "Region:        $(md placement/region)"
echo "AZ:            $(md placement/availability-zone)"
echo "Hostname:      $(hostname)"
echo "OS:            $(. /etc/os-release && echo "$PRETTY_NAME")"
echo "Uptime:        $(uptime -p)"
