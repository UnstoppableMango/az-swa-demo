#!/bin/bash

set -e

TMP_FILE="/tmp/empty.bicep"
touch "$TMP_FILE"

az deployment group create \
    --resource-group IMAUG-SWA \
    --template-file "$TMP_FILE" \
    --mode Complete \
    --verbose
