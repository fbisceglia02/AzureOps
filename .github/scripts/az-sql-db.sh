#!bin/bash

RESOURCE_GROUP='az-sql-db-rg'
ADMIN_USER='fbisceglia02'
ADMIN_PASS='P4ssw0rd!'

az group create \ 
    -n $RESOURCE_GROUP
    -l eastus

az sql server create \
    --name fbisceglia02 \
    --resource-group az-sql-db-rg \
    --location eastus \
    --admin-user $ADMIN_USER \
    --admin-password $ADMIN_PASS \
    --enable-public-network true

az sql db create \
    --resource-group az-sql-db-rg \
    --server fbisceglia02 \
    --name SampleDB \
    --service-objective GP_Gen5_2 \
    --edition GeneralPurpose \
    --zone-redundant false 

az sql server firewall-rule create \
    --resource-group az-sql-db-rg \
    --server fbisceglia02 \
    --name AllowAzureServices \
    --start-ip-address 0.0.0.0 \
    --end-ip-address 0.0.0.0


az sql server firewall-rule create \
    --resource-group az-sql-db-rg \
    --server fbisceglia02 \
    --name AllowMyIP \
    --start-ip-address 93.61.72.18 \
    --end-ip-address 93.61.72.182
