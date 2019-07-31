#!/bin/bash
set -e

project_id="$VALOHAI_PROJECT_ID"
# shellcheck disable=SC2153
git_sha="$GIT_SHA"

echo "Git SHA: $git_sha"
echo "Fetching the repository in Valohai…"

response=$(curl -L -H 'Content-Type: application/json' \
         -H "Authorization: Token $VALOHAI_API_TOKEN" \
         -X POST \
         -d '{"name": "fetch"}' \
         "https://app.valohai.com/api/v0/projects/$project_id/fetch")
echo "$response"

function execution_data {
  cat << EOF
  {
    "project": "$project_id",
    "commit": "$git_sha",
    "step": "Preprocess dataset (MNIST)"
  }
EOF
}

echo "Creating a Valohai execution…"
response=$(curl -H 'Content-Type: application/json' \
         -H "Authorization: Token $VALOHAI_API_TOKEN" \
         -X POST \
         -d "$(execution_data)" \
         'https://app.valohai.com/api/v0/executions/')

execution_id=$(echo "$response" | jq '.id')
echo "Created Valohai execution $execution_id"
