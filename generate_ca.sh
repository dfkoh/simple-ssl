#!/bin/bash
#
# Generate a private key and a public key/cert for use as a local CA
#
# If you are so inclined (and understand the security implications), you can
# import this public key into your local keystore, and then the certs you
# sign with the key will validate (and you'll get a shiny green lock when you
# visit a website using it in the browser)
#
# TODO: Add a mechanism to limit the signable domains of this CA
#
set -euo pipefail

# Example subject
# SUBJECT=/C=US/ST=State/L=City/O=Organization/CN=Name of your CA"

SUBJECT="${1:-}"
SUBJ_PARAM=""
if [ ! -z "$SUBJECT" ]; then
    SUBJ_PARAM="-subj $SUBJECT"
fi

openssl genrsa -out ca.key 2048
openssl req -new -x509 -sha256 -days 365 -key ca.key $SUBJ_PARAM -out ca.crt

