

# -AllowClobber Overrides warning messages about installation conflicts about existing commands on a computer. 
# It’s possible for a new module to override or clobber an existing command already available from another module, 
# including core system modules that provide many of the foundational commands users expect to find in a PowerShell installation.

# -Force Automatically say "yes"


Install-Module -Name PowerShellGet -Force -AllowClobber

# Install Secret Management
# Ref https://learn.microsoft.com/en-us/powershell/utility-modules/secretmanagement/get-started/using-secretstore?view=ps-modules
Install-Module Microsoft.PowerShell.SecretManagement -Force -AllowClobber
Install-Module Microsoft.PowerShell.SecretStore -Force -AllowClobber


# Install MirosoftTeams
# Ref. https://learn.microsoft.com/en-us/microsoftteams/teams-powershell-install
Install-Module MicrosoftTeams -Force -AllowClobber

# Install graph (GA + Beta)
Install-Module Microsoft.Graph.Beta -Force -AllowClobber
Install-Module Microsoft.Graph -Force -AllowClobber

# Install JWT 
Install-Module JWT -Force -AllowClobber