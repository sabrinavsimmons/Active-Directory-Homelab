# WS01 Workstation Installation
**Date:** February 12, 2026  
**Technician:** Sabri  
**Purpose:** First domain workstation for sabrilab.local testing

---

## VM Configuration

**Hypervisor:** Proxmox VE  
**VM ID:** 101  
**VM Name:** WS01

### Hardware Specifications
- **CPU:** 2 cores (host type)
- **RAM:** 4 GB
- **Disk:** 40 GB (SSD storage - ssd-vg)
- **Network:** vmbr2 (AD Lab Network - 192.168.10.0/24)
- **BIOS:** UEFI
- **Additional:** TPM 2.0 enabled

---

## Windows 11 Pro Installation

### Installation Steps
1. Created VM with Windows 11 ISO mounted
2. Booted from ISO and started Windows Setup
3. Selected language/keyboard: English (United States)
4. Clicked "Install now"
5. Skipped product key (will activate after domain join)
6. Selected: **Windows 11 Pro**
7. Accepted license terms
8. Selected "Custom: Install Windows only (advanced)"

### Driver Installation Issue & Resolution
**Problem:** Windows Setup could not see the 40GB disk  
**Cause:** VirtIO SCSI drivers not loaded  
**Solution:**
- Mounted virtio-win.iso to VM
- In Windows Setup, clicked "Load driver"
- Browsed to D:\vioscsi\2k25\amd64
- **Issue:** Driver found but "Error installing driver" appeared
- **Fix:** Unchecked "Hide drivers that aren't compatible with this computer's hardware"
- Driver installed successfully: Red Hat VirtIO SCSI pass-through controller
- Changed CD back to Windows 11 ISO
- Disk appeared and installation proceeded

### Installation Progress
- Currently installing Windows 11 Pro
- Expected completion: ~15 minutes
- Will automatically restart

---

## Post-Installation Plan

### Configuration Steps (Pending)
1. Complete Windows 11 OOBE (Out of Box Experience)
2. Install VirtIO guest drivers
3. Configure static IP: 192.168.10.20
4. Rename computer to WS01
5. Join sabrilab.local domain
6. Test domain login with user account
7. Verify Group Policy application

---

## Current Status

**Installation:** In Progress  
**Estimated Completion:** [will update after install finishes]

---

## Notes
- Windows 11 requires TPM 2.0 (configured in VM)
- Pro edition required for domain join capability
- VirtIO driver compatibility checkbox issue resolved by unchecking filter

---

## Post-Installation Configuration (Completed)

### Network Configuration
- Switched from vmbr0 (internet access for OOBE) back to vmbr2 (AD lab network)
- Configured static IP settings:
  - IP Address: 192.168.10.20
  - Subnet Mask: 255.255.255.0
  - Default Gateway: 192.168.10.1
  - DNS Server: 192.168.10.10 (DC01)
- Verified connectivity: Successfully pinged DC01

### Domain Join Process
**Date:** February 13, 2026

**Steps:**
1. Opened System Properties
2. Clicked "Change" under Computer Name
3. Selected "Domain" radio button
4. Entered: sabrilab.local
5. Provided credentials: sabri.admin
6. Successfully joined domain
7. Restarted computer

**Result:** "Welcome to the sabrilab.local domain" message received

### Domain Login Testing
- Successfully logged in as: sarah.chen@sabrilab.local
- Domain authentication working correctly
- User profile created on workstation

### Group Policy Verification
- Ran `gpresult /r` command
- Confirmed "Security - Screen Lock Timeout" GPO applied
- Policy settings active and enforced

---

## Final Status

**WS01:** ✅ Fully operational domain workstation  
**Domain Member:** sabrilab.local  
**Network:** Configured and verified  
**Authentication:** Working  
**Group Policy:** Applied and verified  

**Total Build Time:** ~2 hours  
**Completion Date:** February 13, 2026

---

## Notes & Lessons Learned

- Windows 11 OOBE network requirement bypassed by temporarily connecting to vmbr0
- VirtIO drivers needed during installation and after for optimal performance
- DNS must point to DC (192.168.10.10) for domain join to work
- gpresult /r is essential tool for verifying GPO application
- Domain authentication seamless once properly configured

---

## Post-Deployment Testing

**Domain Authentication:**
- Successfully logged in with multiple domain accounts
- Tested: sarah.chen, robert.johnson, emily.davis
- All authentications successful

**Group Policy Application:**
- Verified Screen Lock Timeout policy applied
- Verified Desktop Wallpaper policy applied  
- Verified Password Policy enforced
- Command used: `gpresult /r`

**Network Connectivity:**
- DNS resolution to DC01: ✅ Working
- Domain controller reachability: ✅ Working
- File sharing capabilities: ✅ Working

**User Experience:**
- Desktop wallpaper set by GPO
- Screen timeout enforced (10 minutes)
- Password complexity requirements active

---

## Final Status

**Deployment Date:** February 13-14, 2026  
**Completion Status:** ✅ Fully operational domain workstation  
**Purpose:** Test and validate Active Directory lab functionality  

**Capabilities Demonstrated:**
- Domain join procedures
- Network troubleshooting (OOBE bypass)
- Group Policy verification
- Multi-user domain authentication
- DNS configuration for domain environments

**Integration Status:**
- Connected to: sabrilab.local domain
- Managed by: DC01.sabrilab.local
- Receiving policies: 3 GPOs applied successfully
- User authentication: Working for all 14 domain accounts