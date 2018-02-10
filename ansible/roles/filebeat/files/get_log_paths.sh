#!/bin/bash

# result=$( docker container ls --filter status=running  | grep "Up" )
#
# if [[ -n "$result" ]]; then
#   echo "Containers are running"
# else
#   echo "No running containers"
# fi

containers=$( docker ps | awk '{if(NR>1) print $NF}')

for container in $containers
do
  log_location=($(docker inspect --format='{{.LogPath}}' $container ))
    for index in ${!log_location[*]}; do
    echo "${log_location[index]}" >> /Users/angie/dd_logging_1/ansible/roles/filebeat/files/log_paths.txt
  done
done
