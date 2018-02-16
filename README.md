# dd_logging
Example repro for [Centralized Secure Docker Logging Proof of Concept](https://docs.google.com/document/d/12CT_IAhL02ZL4MYX1MY0qDztUGsCJIH6-aZ2NbAmiBw/edit?usp=sharing "Centralized Secure Docker Logging Proof of Concept")

## Instructions

To build packer-ami you will need the following:

* An aws account
* ./aws.credentials file   [https://docs.aws.amazon.com/cli/latest/userguide/cli-config-files.html](https://docs.aws.amazon.com/cli/latest/userguide/cli-config-files.html)
* to clone this repo
* add your own [filebeat.yml](https://github.com/elastic/beats/blob/master/filebeat/filebeat.yml) and [packetbeat.yml](https://github.com/elastic/beats/blob/master/packetbeat/packetbeat.yml) to /packer

packer template file is uswest1.json

to run packer on osx please install via:
```brew install packer```
then to build packer ami run:
```packer build uswest1.json```

For using terraform you will need to have the following defined within a main.tfvars file:
* key_name
* subnet_id

## Considerations / Gotchas
Main consideration of this repo was time -- and quickly coming up with an example of possible ways to deploy logging shippers using terraform/packer.

A better design would be to create an Ansible role for configuring/launching filebeat/packetbeat shippers, and to strip the user_data.sh file down to bare minimum (if using it at all -- for instance setting ec2 instance env variables from ec2metadata can be useful but is not required)...  
So ideally using packer to build a base ami, use terraform to provision instances using that base ami, and use Ansible to configure software that will be running on these instances, and then use Consul for service discovery. 

The Terraform module that is referenced but not committed here is from https://registry.terraform.io/  
This allows me to reference an aws-verified ec2 module directly by using:
``source = "terraform-aws-modules/ec2-instance/aws"``

More information on how terraform registry works can be found here: https://www.terraform.io/docs/modules/sources.html#terraform-registry
