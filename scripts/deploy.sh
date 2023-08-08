#!/bin/bash

set -e

ROOT="$(git rev-parse --show-toplevel)"

source "$ROOT/.env.local"

az deployment group create \
    --resource-group IMAUG-SWA \
    --template-file "$ROOT/azuredeploy.bicep" \
    --parameters repositoryToken="$GH_TOKEN" \
    --mode Complete
