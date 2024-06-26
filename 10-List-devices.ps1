# ref. https://learn.microsoft.com/en-us/graph/api/teamworkdevice-list?view=graph-rest-beta&tabs=http


# Using REST

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Authorization", $graphToken)

$response = Invoke-RestMethod 'https://graph.microsoft.com/beta/teamwork/devices' -Method 'GET' -Headers $headers
$response | ConvertTo-Json


# Using Powershell SDK
Get-MgBetaTeamworkDevice | Ft @{label='User';e={$_.CurrentUser.DisplayName}}, @{label='Model';e={$_.HardwareDetail.Model}}, @{label='Manufacturer';e={$_.HardwareDetail.Manufacturer}}, HealthStatus



# Get-MgBetaTeamworkDevice | ConvertTo-Json -Depth 2

