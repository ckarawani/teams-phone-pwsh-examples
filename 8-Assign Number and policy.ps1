$sitename = Read-Host -Prompt 'Provide Site Name (ex. MN,MTL or CHI)'
$upn =  Read-Host -Prompt 'Provide UPN' 

$siteToAreaCode = @{
  “MTL” = “+1438”
  “MN” = “+1612”
  "CHI" = "+1312"
}

$emergencyLocations = @{
  “MTL” = “49153c34-b322-4a95-8391-10b555ec7575”
  “MN” = “36d0783d-475f-4d6c-a637-649cf1bad87c” 
  "CHI" = "cf9250bd-f7ea-4aae-8161-ad530bc7e49b"
}

$emergencyPolicies = @{
  “MTL” = “MTL Emergency Policy”
  “MN” = “MN Emergency Policy”
  "CHI" = "CHI Emergency Policy"
}

$areaCode = $siteToAreaCode[$sitename]

$csPhoneNumberAssignmentParams = @{
    CapabilitiesContain = 'UserAssignment'
    # NumberType = 'CallingPlan'
    PstnAssignmentStatus = 'Unassigned'
    TelephoneNumberStartsWith = $areaCode

  }


$siteNumbers = Get-CsPhoneNumberAssignment @csPhoneNumberAssignmentParams

Set-CsPhoneNumberAssignment -Identity $upn -PhoneNumberType CallingPlan -PhoneNumber $siteNumbers[0].TelephoneNumber -LocationId $emergencyLocations[$sitename]
Grant-CsTeamsEmergencyCallingPolicy -Identity $upn -PolicyName $emergencyPolicies[$sitename]


Get-CsOnlineUser -Identity $upn | Format-List UserPrincipalName, LineUri, TeamsEmergencyCallingPolicy




# Get Users with phoneNumber 
#Get-CsOnlineUser -Filter {LineUri -like 'tel:+1438*'} | Select-Object UserPrincipalName, LineUri
# Montreal Direct Routing Numbers +14504971648,+14504971649, +14504971650