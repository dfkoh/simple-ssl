#!/bin/bash

set -euo pipefail

if [ $# -lt 2 ]; then
    cat <<EOF 1>&2
    USAGE: $0 <ca cert> [<subject>]
    Note - don't include common name in the subject - it will be set to localhost
EOF
    exit 1
fi

CACERT=$1
shift
SUBJECT="${1:-}"
shift

SUBJ_PARAM=""
if [ ! -z "$SUBJECT" ]; then
    SUBJ_PARAM="-subj $SUBJECT"
fi


openssl req -newkey rsa:2048 -sha256 -keyout server.key -nodes -subj "${SUBJECT}/CN=localhost" -out server.csr
openssl x509 -req -extfile <(printf "subjectAltName=DNS:localhost") -sha256 -days 365 -in server.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out server.crt
