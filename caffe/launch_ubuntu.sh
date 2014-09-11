#! /bin/bash

pip install awscli

AMI="ami-25dcff24"
INSTANCE_TYPE="g2.2xlarge"
PRICE="0.05"
KEYPAIR=""
REGION="ap-northeast-1"
SECURITY_GROUPS="default"

cat << EOF >> config.json
{
    "ImageId": "${AMI}",
    "KeyName": "${KEYPAIR}",
    "InstanceType": "${INSTANCE_TYPE}",
    "BlockDeviceMappings": [{
      "DeviceName": "/dev/sda1",
      "Ebs": {
        "VolumeSize": 20,
        "DeleteOnTermination": true,
        "VolumeType": "gp2",
        "Encrypted": false
      }
    }],
    "Monitoring": {
        "Enabled": true
    },
    "SecurityGroups": [
        "${SECURITY_GROUPS}"
    ]
}

EOF

aws ec2 request-spot-instances \
--spot-price ${PRICE} \
--region ${REGION} \
--instance-count 1 \
--launch-specification file://./config.json > request.json

rm -rf config.json