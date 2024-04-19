$sitename = Read-Host -Prompt 'Please Provide Site Name (ex. MN or MTL)'
$upn =  Read-Host -Prompt 'Please Provide UPN' 

$siteToAreaCode = @{
  “MTL” = “438”
  “MN” = “612”
}

$emergencyPolicies = @{
  “MTL” = “MTL Emergency Policy”
  “MN” = “MN Emergency Policy”
}

$areaCode = $siteToAreaCode[$sitename]

$csPhoneNumberAssignmentParams = @{
    CapabilitiesContain = 'UserAssignment'
    # NumberType = 'CallingPlan'
    PstnAssignmentStatus = 'Unassigned'
    TelephoneNumberContain = $areaCode

  }


$siteNumbers = Get-CsPhoneNumberAssignment @csPhoneNumberAssignmentParams

Set-CsPhoneNumberAssignment -Identity $upn -PhoneNumberType CallingPlan -PhoneNumber $siteNumbers[0].TelephoneNumber 
Grant-CsTeamsEmergencyCallingPolicy -Identity $upn -PolicyName $emergencyPolicies[$sitename]


Get-CsOnlineUser -Identity $upn | Format-List UserPrincipalName, LineUri, TeamsEmergencyCallingPolicy




# Get Users with phoneNumber 
#Get-CsOnlineUser -Filter {LineUri -like 'tel:+1438*'} | Select-Object UserPrincipalName, LineUri
# Montreal Direct Routing Numbers +14504971648,+14504971649, +14504971650