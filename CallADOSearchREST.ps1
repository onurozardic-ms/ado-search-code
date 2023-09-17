# Use the Azure DevOps REST API to do the code search (see https://docs.microsoft.com/en-us/rest/api/azure/devops/search/code-search-results/fetch-code-search-results?view=azure-devops-rest-7.1)
# Server is your ADO on-prem instance
# Collection is the collection/organizaton to search
# Project is the team project to search

# Basic Settings
$uri = "https://server/collection/project/_apis/search/codesearchresults?api-version=7"
$pat = "put-some-pat-here"
# Prepare Authentication Header
$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f "", $pat)))
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Authorization", ("Basic {0}" -f $base64AuthInfo))
$headers.Add("Content-Type", "application/json")
# Set the REST Call Body
# searchText is the text to be searched
$body = @{
  searchText = 'juice'
  '$skip' = 0
  '$top' = 1000
  includeSnippet = 'false'
} | ConvertTo-Json

# Call API:
$result = Invoke-RestMethod -Method Post -Headers $headers -Uri $uri -Body $body
# Result object has two members: int count, blob results
Write-Output $result.count
Write-Output $result.results
