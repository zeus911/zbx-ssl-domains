#!/bin/bash
VHOSTS='/etc/zabbix/domains/ssl'

# {"data":[
# {"{#DOMAIN}":"domains.sh"},
# {"{#DOMAIN}":"nginx.sh"},
# {"{#DOMAIN}":"services"}
# ]}

for DOMAIN in $(ls ${VHOSTS} | grep '.conf'); do
  DOMAIN=${DOMAIN/.conf/}

  if [ "$OUTPUT" == "" ]; then
    OUTPUT="{\"{#DOMAIN}\":\"${DOMAIN}\"}"
  else
    OUTPUT="${OUTPUT},{\"{#DOMAIN}\":\"${DOMAIN}\"}"
  fi
done

echo "{\"data\":[${OUTPUT}]}"

exit 0
