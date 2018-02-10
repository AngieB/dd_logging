# dd_logging
Example repro for [Centralized Secure Docker Logging Proof of Concept](https://docs.google.com/document/d/12CT_IAhL02ZL4MYX1MY0qDztUGsCJIH6-aZ2NbAmiBw/edit?usp=sharing "Centralized Secure Docker Logging Proof of Concept") 

## Instructions

To build packer-ami you will need the following":

* An aws account
* ./aws.credentials file   [https://docs.aws.amazon.com/cli/latest/userguide/cli-config-files.html](https://docs.aws.amazon.com/cli/latest/userguide/cli-config-files.html)
* to clone this repo
* add your own [filebeat.yml](https://github.com/elastic/beats/blob/master/filebeat/filebeat.yml) and [packetbeat.yml](https://github.com/elastic/beats/blob/master/packetbeat/packetbeat.yml) to /packer 
