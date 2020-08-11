#!/bin/bash

set -e

if [ "$#" -gt 0 ]; then
    TMC_API_TOKEN=${TMC_API_TOKEN?"TMC_API_TOKEN not set"}
    tmc login --name default -c
    tmc system context use default
    echo Launching webhook server
    python3 server.py
else
  exec "$@"
fi


