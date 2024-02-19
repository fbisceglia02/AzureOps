#!bin/bash
runId=$(gh run list -L 1 --json databaseId | jq -r '.[0].databaseId')

gh run download $runId -n key-pip

pip=$(cat pip-addr)