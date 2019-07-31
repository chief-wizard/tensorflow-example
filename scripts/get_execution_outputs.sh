#!/bin/bash
execution_id="$1"

function get_execution_data() {
  curl -L \
    -H 'Content-Type: application/json' \
    -H "Authorization: Token $VALOHAI_API_TOKEN" \
    "https://app.valohai.com/api/v0/executions/$execution_id"
}

get_execution_data | jq '.outputs'
