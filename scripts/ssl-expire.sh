#! /bin/bash

HOSTNAME=$1
PORT=${2:-443}
# ------------------------------------------------------

DAY_OFFSET=""

for IP in $(dig +short A $HOSTNAME); do
  EXPARY_DATE=$(echo "QUIT" | openssl s_client -connect $IP:$PORT -servername $HOSTNAME 2>/dev/null | openssl x509 -inform pem -noout -enddate | cut -d "=" -f 2)

  if [[ "$EXPARY_DATE" != "" ]]; then
    CURRENT_OFFSET="$((($(date -d "$EXPARY_DATE" +%s) - $(date +%s))/(3600 * 24)))"

    if [[ -z "$DAY_OFFSET" ]]; then
        DAY_OFFSET=$CURRENT_OFFSET
    fi

    # Current <= Offset
    if [[ "$CURRENT_OFFSET" -le "$DAY_OFFSET" ]]; then
      DAY_OFFSET=$CURRENT_OFFSET
    fi
  fi
done


if [[ "$DAY_OFFSET" -gt 0 ]]; then
  echo $DAY_OFFSET
else
  echo 0
fi

exit 0
