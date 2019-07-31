#!/bin/bash
set -o pipefail
# shellcheck disable=SC2153
execution_id="$1"

function get_execution_data() {
  curl -L \
    -H 'Content-Type: application/json' \
    -H "Authorization: Token $VALOHAI_API_TOKEN" \
    "https://app.valohai.com/api/v0/executions/$execution_id"
}

execution_status="$(get_execution_data | jq '.status')"
while [[ "$execution_status" != "\"complete\"" ]]; do
  echo "Waiting for the execution $execution_id to finish…"
  sleep 5
  execution_status=$(get_execution_data | jq '.status')
done

echo "Execution $execution_id has finished"
