<#
.SYNOPSIS
    Bulk create Active Directory users from CSV file
.DESCRIPTION
    Reads user data from users.csv and creates AD accounts in appropriate OUs
.AUTHOR
    Sabri
.DATE
    February 13, 2026
#>

# Import Active Directory module
Import-Module ActiveDirectory

# Import CSV file
$Users = Import-Csv -Path ".\users.csv"

# Define default password (should be changed on first login in production)
$DefaultPassword = ConvertTo-SecureString "TempPass123!" -AsPlainText -Force

# Process each user
foreach ($User in $Users) {
    # Create username (firstname.lastname format)
    $Username = "$($User.FirstName).$($User.LastName)".ToLower()
    
    # Determine OU based on department
    $OU = switch ($User.Department) {
        "IT"      { "OU=IT-Department,OU=Users,OU=_CORPORATE,DC=sabrilab,DC=local" }
        "Finance" { "OU=Finance,OU=Users,OU=_CORPORATE,DC=sabrilab,DC=local" }
        "HR"      { "OU=HR,OU=Users,OU=_CORPORATE,DC=sabrilab,DC=local" }
        "Sales"   { "OU=Sales,OU=Users,OU=_CORPORATE,DC=sabrilab,DC=local" }
        default   { "OU=Users,OU=_CORPORATE,DC=sabrilab,DC=local" }
    }
    
    # Create user parameters
    $UserParams = @{
        Name                  = "$($User.FirstName) $($User.LastName)"
        GivenName            = $User.FirstName
        Surname              = $User.LastName
        SamAccountName       = $Username
        UserPrincipalName    = "$Username@sabrilab.local"
        Title                = $User.Title
        Department           = $User.Department
        Path                 = $OU
        AccountPassword      = $DefaultPassword
        Enabled              = $true
        PasswordNeverExpires = $true
        ChangePasswordAtLogon = $false
    }
    
    # Try to create the user
    try {
        New-ADUser @UserParams
        Write-Host "✓ Created user: $Username in $($User.Department)" -ForegroundColor Green
    }
    catch {
        Write-Host "✗ Failed to create $Username : $_" -ForegroundColor Red
    }
}

Write-Host "`nBulk user creation complete!" -ForegroundColor Cyan