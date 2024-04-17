# ref. https://learn.microsoft.com/en-us/microsoftteams/teams-powershell-application-authentication

$ClientSecret   = "…"
$ApplicationID = "00000000-0000-0000-0000-000000000000"
$TenantID = "YYYYYYYY-YYYY-YYYY-YYYY-YYYYYYYYYYYY"

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