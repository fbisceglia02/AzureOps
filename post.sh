curl -X POST -H "Authorization: token YOUR_TOKEN" \
     -H "Accept: application/vnd.github.v3+json" \
     -d '{
           "title": "Implement Automated Workflow for Data Backup",
           "body": "Develop and deploy an automated workflow for regular data backups using Power Automate, ensuring all critical data is securely stored and easily retrievable.",
           "assignees": ["fbisceglia02"]
         }' \
     https://api.github.com/repos/fbisceglia02/AzureOps/issues
