#!/bin/bash

set -e

ROOT="$(git rev-parse --show-toplevel)"

cd "$ROOT"

swa start app/build --api-location api
