#!/bin/bash

# Set EC2 instance id
EC2_INSTANCE_ID=$(ec2metadata --instance-id)

# Set EC2 instance local IP
EC2_LOCAL_IP=$(ec2metadata --local-ipv4)

# Set EC2 instance hostname
EC2_HOSTNAME=$(ec2metadata --local-hostname)

#Gather env from tags
ENVIRONMENT=$(aws ec2 describe-tags --filters "Name=resource-id,Values=${EC2_INSTANCE_ID}" "Name=key,Values=env" --region "eu-west-1" --query "Tags[*].Value" --output=text)

# Write systemd unit file
cat << EOF > /etc/systemd/system/docker-container@packetbeat.service
[Unit]
Description=packetbeat
Requires=docker.service
After=docker.service

[Service]
Restart=always
ExecStartPre=-/usr/bin/docker rm -f packetbeat
ExecStart=/usr/bin/docker run --name packetbeat \
--restart=on-failure:10 \
--volume=/etc/packetbeat/packetbeat.yml:/usr/share/packetbeat/packetbeat.yml \
--net=host \
--cap-add=NET_ADMIN \
docker.elastic.co/beats/packetbeat:6.1.2

ExecStop=/usr/bin/docker stop packebeat

WantedBy=default.target
EOF

systemctl enable docker-container@packetbeat.service
systemctl start docker-container@packetbeat.service

systemctl enable filebeat.service
systemctl start filebeat.service
