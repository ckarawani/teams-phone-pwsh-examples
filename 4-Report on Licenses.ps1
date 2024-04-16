# Ref https://learn.microsoft.com/en-us/entra/identity/users/licensing-service-plan-reference
$licenseCsvURL = 'https://download.microsoft.com/download/e/3/e/e3e9faf2-f28b-490a-9ada-c6089a1fc5b0/Product%20names%20and%20service%20plan%20identifiers%20for%20licensing.csv'
$translationTable = Invoke-RestMethod -Method Get -Uri $licenseCsvURL  | ConvertFrom-Csv

$licenseSkus = Get-MgSubscribedSku 

$report = @()

#ref. https://medium.com/@mozzeph/translate-microsoft-365-license-guids-to-product-names-in-powershell-e8fa373ace16
foreach ($sku in $licenseSkus) {

    $skuDetails = New-Object -TypeName psobject

    $skuNamePretty = ($translationTable | Where-Object {$_.GUID -eq $sku.skuId} | Sort-Object Product_Display_Name -Unique).Product_Display_Name

    $skuDetails | Add-Member -MemberType NoteProperty -Name "DisplayName" -Value $skuNamePretty
    $skuDetails | Add-Member -MemberType NoteProperty -Name "StringId" -Value $sku.skuPartNumber
    $skuDetails | Add-Member -MemberType NoteProperty -Name "LicenseId" -Value $sku.skuId
    $skuDetails | Add-Member -MemberType NoteProperty -Name "TotalLicenses" -Value $sku.PrepaidUnits.Enabled
    $skuDetails | Add-Member -MemberType NoteProperty -Name "ConsumedLicenses" -Value $sku.ConsumedUnits
    $skuDetails | Add-Member -MemberType NoteProperty -Name "AvailableLicense" -Value ($sku.PrepaidUnits.Enabled - $sku.ConsumedUnits) 

    $report += $skuDetails

}

Write-Output $report | Format-Table;


