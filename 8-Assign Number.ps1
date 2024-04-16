$sitename = Read-Host -Prompt 'Please Provide Site Name (ex. MN or MTL)'
$upn =  Read-Host -Prompt 'Please Provide UPN' 

$siteToAreaCode = @{
  “MTL” = “438”
  “MN” = “612”
}

$areaCode = $siteToAreaCode[$sitename]

$csPhoneNumberAssignmentParams = @{
    CapabilitiesContain = 'UserAssignment'
    NumberType = 'CallingPlan'
    PstnAssignmentStatus = 'Unassigned'
    TelephoneNumberContain = $areaCode

  }


$siteNumbers = Get-CsPhoneNumberAssignment @csPhoneNumberAssignmentParams

Set-CsPhoneNumberAssignment -Identity $upn -PhoneNumberType CallingPlan -PhoneNumber $siteNumbers[0].TelephoneNumber 

Get-CsOnlineUser -Identity $upn | Select-Object UserPrincipalName, LineUri




# Get Users with phoneNumber 
#Get-CsOnlineUser -Filter {LineUri -like 'tel:+1438*'} | Select-Object UserPrincipalName, LineUri