#!/bin/bash

echo "Webhook:"
read webhook

set -e

echo -n "${webhook}" > webhook.txt

kubectl -n ifn delete secret slackwebhook

kubectl -n ifn create secret generic slackwebhook \
  --from-file=./webhook.txt

rm -f webhook.txt
