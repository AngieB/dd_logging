#!/bin/bash 

result=$( docker container ls --filter status=running  | grep "Up" )

if [[ -n "$result" ]]; then
  echo "Containers are running"
else
  echo "No running containers"
fi

containers=$( docker ps | awk '{if(NR>1) print $NF}')

for container in $containers
do
  echo "Container: $container"
  log_location=($(docker inspect --format='{{.LogPath}}' $container ))
    for index in ${!log_location[*]}; do
    echo "${log_location[index]}"
  done
done
