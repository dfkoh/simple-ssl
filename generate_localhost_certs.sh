#!/bin/bash

set -euo pipefail

if [ $# -lt 2 ]; then
    cat <<EOF 1>&2
    USAGE: $0 <ca key> <ca cert> [<subject>]
    Note - don't include common name in the subject - it will be set to localhost
EOF
    exit 1
fi

CA_KEY=$1
CA_CERT=$2
SUBJECT=${3:-}
SUBJ_PARAM=""
if [ ! -z "$SUBJECT" ]; then
    SUBJ_PARAM="-subj $SUBJECT"
fi


openssl req -newkey rsa:2048 -sha256 -keyout server.key -nodes -subj "${SUBJECT}/CN=localhost" -out server.csr
openssl x509 -req -extfile <(printf "subjectAltName=DNS:localhost") -sha256 -days 365 -in server.csr -CA $CA_CERT -CAkey $CA_KEY -CAcreateserial -out server.crt
