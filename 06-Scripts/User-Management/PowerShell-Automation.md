# PowerShell Bulk User Creation Script
**Date:** February 15, 2026  
**Author:** Sabri  
**Purpose:** Automate Active Directory user provisioning from CSV data

---

## Overview

This script automates the creation of Active Directory user accounts by reading data from a CSV file and creating users in their appropriate departmental OUs. The script includes validation checks to prevent duplicate accounts and is designed to be safely re-run (idempotent).

---

## Features

- **CSV-driven user creation** - Bulk provision users from structured data
- **Automatic username generation** - Creates usernames in firstname.lastname format
- **Dynamic OU assignment** - Places users in correct departmental OUs based on CSV data
- **Duplicate prevention** - Checks for existing UPNs and SamAccountNames
- **Idempotent design** - Safe to run multiple times without creating duplicates
- **Debug output** - Shows username, UPN, and OU assignment for verification
- **Error handling** - Skips existing users with clear warning messages

---

## CSV Format

**Required Columns:**
- FirstName
- LastName
- Department (must match: IT, Finance, HR, or Sales)
- Title

**Example:**
```csv
FirstName,LastName,Department,Title
Robert,Johnson,HR,HR Manager
Emily,Davis,Finance,Senior Accountant
James,Brown,Sales,Account Executive
Maria,Garcia,IT,Network Administrator
```

---

## Script Logic

1. Import Active Directory module
2. Read CSV file
3. For each user:
   - Trim whitespace from names
   - Generate username (firstname.lastname)
   - Create UPN (username@sabrilab.local)
   - Determine target OU based on department
   - Check if UPN already exists (skip if found)
   - Check if SamAccountName already exists (skip if found)
   - Create AD user account
   - Display success or skip message

---

## OU Structure

Users are automatically placed in department-specific OUs:

- IT → `OU=IT-Department,OU=Users,OU=_CORPORATE,DC=sabrilab,DC=local`
- Finance → `OU=Finance,OU=Users,OU=_CORPORATE,DC=sabrilab,DC=local`
- HR → `OU=HR,OU=Users,OU=_CORPORATE,DC=sabrilab,DC=local`
- Sales → `OU=Sales,OU=Users,OU=_CORPORATE,DC=sabrilab,DC=local`

---

## Usage

**Prerequisites:**
- Active Directory PowerShell module
- Domain Controller access
- CSV file with user data
- Administrative privileges

**Steps:**
1. Prepare CSV file with user data
2. Save CSV as `C:\Scripts\users.csv`
3. Run PowerShell ISE as Administrator
4. Open `New-BulkADUsers-Clean.ps1`
5. Press F5 to execute

---

## Output Examples

**Success:**
```
DEBUG: Username=[robert.johnson] UPN=[robert.johnson@sabrilab.local] OU=[OU=HR,OU=Users,OU=_CORPORATE,DC=sabrilab,DC=local]
Skip (UPN exists): robert.johnson@sabrilab.local
```

**Debug Information:**
- Cyan text shows generated username, UPN, and target OU
- Yellow text indicates user was skipped (already exists)
- Script provides clear feedback for each user processed

---

## Technical Details

**Default Password:** TempPass123!  
**Password Policy:** 
- 12 character minimum
- Complexity required
- 90-day expiration
- 24 password history

**Account Settings:**
- Enabled: Yes
- Password Never Expires: Yes (for lab environment)
- Change Password at Logon: No (for lab environment)

*Note: In production, passwords should expire and require change on first login*

---

## Troubleshooting Journey

**Challenges Encountered:**
1. CSV import variable mismatch ($User vs $Users)
2. Incorrect Get-ADUser filter syntax
3. Quoting and variable interpolation errors
4. UPN uniqueness constraints (forest-wide)
5. CN (Name) conflicts within OUs
6. Missing $ variable references
7. Handling duplicate user creation on re-runs

**Solutions Implemented:**
- Cleaned up variable usage for consistency
- Added defensive checks for existing UPNs and SamAccountNames
- Implemented debug output for validation
- Made script idempotent with skip logic
- Added proper error handling and user feedback

---

## Skills Demonstrated

- PowerShell scripting
- Active Directory cmdlets (New-ADUser, Get-ADUser)
- CSV data processing (Import-Csv)
- Control flow (foreach, switch)
- Error handling (try/catch, conditionals)
- String manipulation (.ToLower(), .Trim())
- Variable interpolation
- Secure password handling (ConvertTo-SecureString)
- Idempotent design patterns
- Debug output and logging

---

## Future Enhancements

Potential improvements for production use:
- Transcript logging to file
- Summary report (created/skipped/failed counts)
- CSV column validation
- Command-line parameters
- Progress bar for large datasets
- Export results to audit CSV
- Email notification on completion

---

## Notes

- Script designed for lab/learning environment
- Production use would require additional security hardening
- Password policy should be adjusted for production requirements
- Consider integrating with HR onboarding systems for automation