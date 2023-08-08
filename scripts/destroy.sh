#!/bin/bash

set -e

TMP_FILE=$(mktemp)
BICEP_FILE="$TMP_FILE.bicep"
mv "$TMP_FILE" "$BICEP_FILE"

az deployment group create \
    --resource-group IMAUG-SWA \
    --template-file "$BICEP_FILE" \
    --mode Complete
