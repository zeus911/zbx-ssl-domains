#!/bin/nash

JSHON=$(which jshon)

if [[ -z $JSHON ]]; then
  echo "Package jshon not installed, fix: apt install jshon"
  exit 1
fi

if [[ ! -z $1 ]]; then
    EXPARY_JSON=$(curl -s "https://api.app-service.pro/whois/$1")

    if [[ -z $EXPARY_JSON ]]; then
      exit 1
    fi

    STATUS_CODE=$(echo $EXPARY_JSON | $JSHON -e status_code)

    if [[ $STATUS_CODE == 200 ]]; then
      DAYS_OFFSET=$(echo $EXPARY_JSON | $JSHON -e domain_data -e expire_left_days)

      if [[ $DAYS_OFFSET -gt 0 ]]; then
        echo $DAYS_OFFSET
      else
        echo 0
      fi

      exit 0
    else
      ERR_MESSAGE=$(echo $EXPARY_JSON | $JSHON -e error_message | sed "s/\"//g")

      if [[ ! -z $ERR_MESSAGE ]]; then
        echo $ERR_MESSAGE
      fi

      exit 1
    fi
fi
