#!/bin/bash
#
# This script generates a new self-signed certificate for domain 'localhost'.
# It outputs two files: ssl.key, and ssl.cert, which are the new private key
# and the new certificate
set -euo pipefail

# See https://superuser.com/questions/226192/avoid-password-prompt-for-keys-and-prompts-for-dn-information
# The private key is not password-encrypted due to the no DES option (-nodes)
# This certificate will also expire in 365 days
openssl req \
    -new \
    -newkey rsa:4096 \
    -days 365 \
    -nodes \
    -x509 \
    -subj "/C=US/CN=ffs.cms.gov" \
    -keyout server.key \
    -out server.crt

