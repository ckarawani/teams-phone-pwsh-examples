$upnInput =  Read-Host -Prompt 'Comma Seperated List of Users to License' 
$skuInput =  Read-Host -Prompt 'Comma Seperated List of Liceses to assign (Ex. MCOPSTNC,SPE_E5)' 

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
