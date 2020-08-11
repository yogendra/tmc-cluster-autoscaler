#!/bin/sh

set -e

if [ "$#" -eq 0 ]; then

  [[ -z $TMC_API_TOKEN ]] && echo "Environment variable TMC_API_TOKEN  not provided." 1>&2 && exit 1
  echo "API Token present in environment"
  
  tmc login --name default -c
  echo "TMC login successful"
  
  tmc system context use default
  echo "TMC context switched"

  echo "Launching webhook server"
  python3 server.py
else
  exec "$@"
fi


