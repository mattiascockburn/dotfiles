#!/bin/bash

[[ -z "$1" ]] && {
  echo 'Failed: need a certname to continue'
  exit 1
}
n="$1"

openssl req -x509 -nodes -subj "/CN=${n}" -newkey rsa:4096 -keyout "${n}.key" -out "${n}.crt" -days 365
