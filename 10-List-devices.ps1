# ref. https://learn.microsoft.com/en-us/graph/api/teamworkdevice-list?view=graph-rest-beta&tabs=http


# Using Powershell SDK
Get-MgBetaTeamworkDevice | Format-List



# Using REST

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Authorization", $graphToken)

$response = Invoke-RestMethod 'https://graph.microsoft.com/beta/teamwork/devices' -Method 'GET' -Headers $headers
$response | ConvertTo-Json