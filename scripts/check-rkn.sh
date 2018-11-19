#!/bin/bash

if [[ ! -z $1 ]]; then
    IP_STATUS=$(curl -s "https://api.app-service.pro/rkn/ip/$1/short")

    if [[ $IP_STATUS == "error" ]]; then
      echo "Error status"
      exit 1
    fi

    if [[ $IP_STATUS == "block" ]]; then
      echo 1
    else
      echo 0
    fi
fi

exit 0
