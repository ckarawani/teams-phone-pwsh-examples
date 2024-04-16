# ref https://learn.microsoft.com/en-us/powershell/utility-modules/secretmanagement/get-started/using-secretstore?view=ps-modules


$password = Read-Host -AsSecureString -Prompt 'Input Password for Vault'


# Create encrypted XML file with creds to vault
$securePasswordPath = 'passwd.xml'
$password |  Export-Clixml -Path $securePasswordPath

Register-SecretVault -Name SecretStore -ModuleName Microsoft.PowerShell.SecretStore -DefaultVault


# Change store configuration for interaction to NONE and set timeout
$storeConfiguration = @{
    PasswordTimeout = 3600 # 1 hour
    Interaction = 'None'
    Confirm = $false
    Password = $password

}
Set-SecretStoreConfiguration @storeConfiguration