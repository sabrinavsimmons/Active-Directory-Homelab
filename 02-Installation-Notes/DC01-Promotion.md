# DC01 Domain Controller Promotion
**Date:** February 12, 2026  
**Technician:** Sabri  
**Domain Created:** sabrilab.local

---

## Active Directory Domain Services Installation

### Installation Steps
1. Opened Server Manager
2. Selected "Add roles and features"
3. Selected "Role-based or feature-based installation"
4. Selected DC01 as target server
5. Selected "Active Directory Domain Services" role
6. Added required features when prompted
7. Completed installation (no additional features selected)
8. Installation succeeded

---

## Domain Controller Promotion

### Promotion Configuration
**Deployment Type:** Add a new forest  
**Root domain name:** sabrilab.local  
**NetBIOS name:** SABRILAB  

**Domain Controller Options:**
- Forest functional level: Windows Server 2016
- Domain functional level: Windows Server 2016
- DNS server: ✅ Enabled
- Global Catalog: ✅ Enabled
- DSRM password: Set and documented

**DNS Options:**
- DNS delegation warning ignored (normal for new forest)

**Paths (Default):**
- Database: C:\Windows\NTDS
- Log files: C:\Windows\NTDS
- SYSVOL: C:\Windows\SYSVOL

### Prerequisites Check
- All prerequisite checks passed successfully
- No critical errors
- Minor warnings about DNS delegation (expected)

### Promotion Process
- Clicked "Install"
- Configuration completed successfully
- Server automatically restarted
- Total time: ~15 minutes

---

## Post-Promotion Verification

### Login Changes
- Login screen now shows: SABRILAB\Administrator
- Successfully logged in as domain administrator

### Server Manager Verification
- AD DS role showing in Server Manager
- No error flags or warnings
- New administrative tools available

### Active Directory Users and Computers
- Opened AD Users and Computers from Tools menu
- Verified sabrilab.local domain visible
- Confirmed DC01 listed in Domain Controllers container
- Default containers present:
  - Builtin
  - Computers
  - Domain Controllers
  - ForeignSecurityPrincipals
  - Managed Service Accounts
  - Users

---

## Current Status

**Domain Controller:** ✅ Fully operational  
**Domain:** sabrilab.local ✅ Active  
**DNS:** ✅ Running  
**Ready for:** OU creation, user accounts, Group Policy

---

## Next Steps
- Create custom OU structure
- Create user accounts
- Implement Group Policy Objects
- Join first workstation to domain

---

## Project Completion Summary

**Final Configuration:**
- Domain: sabrilab.local fully operational
- DNS: Resolving correctly for domain clients
- Group Policy: 3 GPOs created and verified
- User Accounts: 14 total (10 manual, 4 automated)
- Workstations: 1 domain-joined and tested

**PowerShell Automation:**
- Created bulk user provisioning script
- CSV-driven user creation implemented
- Validation and error handling added
- Successfully automated creation of 4 test users

**Domain Statistics:**
- Total Users: 14
  - IT Department: 4 users
  - Finance: 3 users
  - HR: 3 users
  - Sales: 4 users
- Total GPOs: 3
- Domain Controllers: 1 (DC01)
- Domain-Joined Computers: 1 (WS01)

**Project Duration:** 4 sessions over 5 days (February 11-15, 2026)
**Total Hours:** Approximately 15 hours

**Status:** ✅ Complete and production-ready for lab environment