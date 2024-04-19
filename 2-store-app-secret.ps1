# ref https://learn.microsoft.com/en-us/powershell/utility-modules/secretmanagement/get-started/using-secretstore?view=ps-modules

# Ask for a password that we will use to create a secure vault and store in encrypted xml file
$appSecret = Read-Host -AsSecureString -Prompt 'Input your Application Secret'
$password = Import-CliXml -Path passwd.xml
Unlock-SecretStore -Password $password
Set-Secret -Name appSecret -Secret $appSecret





