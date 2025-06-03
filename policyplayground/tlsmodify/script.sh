#!/bin/bash

SUBSCRIPTION_ID='c550fb2d-3f43-40b7-9e36-f1d47f436e42'

az policy definition create --name 'enforce-tls1.2-modify' --display-name 'Enforce TLS 1.2 for Storage Accounts' --description 'This policy ensures that TLS 1.2 is used for all storage accounts.' --rules enforce-tls1.2-modify-policy.json --mode Indexed


az policy assignment create --policy 'enforce-tls1.2-modify' --scope '/subscriptions/$SUBSCRIPTION_ID'
