$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/json")
$headers.Add("Authorization", $graphToken)

$body = @"
{
  `"addLicenses`": [
    {
      `"disabledPlans`": [],
      `"skuId`": `"47794cd0-f0e5-45c5-9033-2eb6b5fc84e0`"
    },
    {
      `"disabledPlans`": [],
      `"skuId`": `"06ebc4ee-1bb5-47dd-8120-11324bc54e06`" 
    },
    {
      `"disabledPlans`": [],
      `"skuId`": `"dbd31205-338e-4dec-903d-44402e305e32`"
    }
  ],
  `"removeLicenses`": [ ]
}
"@

$response = Invoke-RestMethod 'https://graph.microsoft.com/v1.0/users/don.donais@dev.goziro.com/assignLicense' -Method 'POST' -Headers $headers -Body $body
$response | ConvertTo-Json