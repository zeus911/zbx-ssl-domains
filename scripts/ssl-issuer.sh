#! /bin/bash

HOSTNAME=$1
PORT=${2:-443}
# ------------------------------------------------------

for IP in $(dig +short A $HOSTNAME); do
  ISSUER=$(echo "QUIT" | openssl s_client -connect $IP:$PORT -servername $HOSTNAME 2>/dev/null | openssl x509 -inform pem -noout -issuer | awk -F 'CN = ' '{print $2}')
done

if [[ "$ISSUER" != "" ]]; then
  echo $ISSUER
fi

exit 0
