$password = Import-CliXml -Path passwd.xml
Unlock-SecretStore -Password $password
$ClientSecret = Get-Secret -Name appSecret -AsPlainText


$ApplicationID = "db002c96-ee09-4f12-8da1-d261c2dff78e"
$TenantID = "dev.goziro.com"

$graphtokenBody = @{ 
 Grant_Type = "client_credentials" 
 Scope = "https://graph.microsoft.com/.default" 
 Client_Id = $ApplicationID 
 Client_Secret = $ClientSecret 
} 

$graphToken = Invoke-RestMethod -Uri "https://login.microsoftonline.com/$TenantID/oauth2/v2.0/token" -Method POST -Body $graphtokenBody | Select-Object -ExpandProperty Access_Token 

$teamstokenBody = @{ 
 Grant_Type = "client_credentials" 
 Scope = "48ac35b8-9aa8-4d74-927d-1f4a14a0b239/.default" 
 Client_Id = $ApplicationID 
 Client_Secret = $ClientSecret 
} 

$teamsToken = Invoke-RestMethod -Uri "https://login.microsoftonline.com/$TenantID/oauth2/v2.0/token" -Method POST -Body $teamstokenBody | Select-Object -ExpandProperty Access_Token 

Connect-MicrosoftTeams -AccessTokens @("$graphToken", "$teamsToken")

Connect-Graph -AccessToken ($graphToken | ConvertTo-SecureString -AsPlainText)

Write-Output "GRAPH TOKEN DETAILS:"
$graphToken | Get-JwtPayload | ConvertFrom-JSON | Format-List

Write-Output "TEAMS TOKEN DETAILS:"
$teamsToken | Get-JwtPayload | ConvertFrom-JSON | Format-List