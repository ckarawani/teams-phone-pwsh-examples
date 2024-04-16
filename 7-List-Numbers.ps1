$csPhoneNumberAssignmentParams = @{
    CapabilitiesContain = 'UserAssignment'
    NumberType = 'CallingPlan'
  #  PstnAssignmentStatus = 'Unassigned'
   # TelephoneNumberContain ='1612'

  }


Get-CsPhoneNumberAssignment @csPhoneNumberAssignmentParams | Format-Table TelephoneNumber, PstnAssignmentStatus

Write-Output "Assigned Numbers" 
Get-CsOnlineUser -Filter {LineUri -like 'tel:*'} | Format-Table UserPrincipalName, LineUri




