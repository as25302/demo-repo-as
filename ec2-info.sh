#!/bin/bash
# show info about this ec2 instance

# need a token first (IMDSv2), without it curl returns 401
TOKEN=$(curl -s -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
URL=http://169.254.169.254/latest/meta-data

echo "=== EC2 Instance Information ==="
echo "Instance ID: $(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" $URL/instance-id)"
echo "Instance Type: $(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" $URL/instance-type)"
echo "Public IP: $(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" $URL/public-ipv4)"
echo "AZ: $(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" $URL/placement/availability-zone)"
echo "Hostname: $(hostname)"
