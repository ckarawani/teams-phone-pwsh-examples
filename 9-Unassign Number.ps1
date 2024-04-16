$upn =  Read-Host -Prompt 'Please Provide UPN of user to unassign number from' 


$lineToRemove = Get-CsOnlineUser -Identity $upn | Select-Object LineUri
Write-Output "Removing $lineToRemove from $upn"

Remove-CsPhoneNumberAssignment -Identity $upn -RemoveAll
Grant-CsTeamsEmergencyCallingPolicy -Identity $upn -PolicyName $null


Get-CsOnlineUser -Identity $upn | Format-List UserPrincipalName, LineUri, TeamsEmergencyCallingPolicy


