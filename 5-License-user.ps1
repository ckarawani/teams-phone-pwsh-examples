$upnInput =  Read-Host -Prompt 'Comma Seperated List of Users to License' 
$skuInput =  Read-Host -Prompt 'Comma Seperated List of Licenses to assign (Ex. MCOPSTNC,SPE_E5,)' 
# MCOPSTNC,SPE_E5,Microsoft_Teams_Calling_Plan_pay_as_you_go_(country_zone_1)


$upnArray = $upnInput.Split(",");
$skuArray = $skuInput.split(",");

$skusToAdd = New-Object System.Collections.ArrayList

foreach ($skuName in $skuArray) {
    $sku = Get-MgSubscribedSku | Where-Object SkuPartNumber -eq $skuName.Trim()
    [void]$skusToAdd.add(@{SkuId = $sku.SkuId})
}

foreach ($upn in $upnArray) {
    Set-MgUserLicense -UserId $upn -AddLicenses $skusToAdd.ToArray() -RemoveLicenses @()
}
