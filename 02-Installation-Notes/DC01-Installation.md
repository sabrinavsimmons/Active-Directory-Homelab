# DC01 Installation Notes
**Date:** February 11, 2026  
**Technician:** Sabrina  
**Purpose:** Domain Controller for sabrilab.local Active Directory lab

---

## VM Configuration

**Hypervisor:** Proxmox VE  
**VM ID:** 125  
**VM Name:** DC01

### Hardware Specifications
- **CPU:** 2 cores (host type)
- **RAM:** 4 GB
- **Disk:** 60 GB (SSD storage - ssd-vg)
- **Network:** vmbr2 (AD Lab Network - 192.168.10.0/24)
- **BIOS:** UEFI
- **Additional:** TPM 2.0 enabled

---

## Windows Server 2022 Installation

### Installation Steps
1. Created VM with Windows Server 2022 ISO mounted
2. Booted from ISO and started Windows Setup
3. Selected language/keyboard: English (United States)
4. Clicked "Install now"
5. Skipped product key (evaluation version)
6. Selected: **Windows Server 2022 Standard Evaluation (Desktop Experience)**
7. Accepted license terms
8. Selected "Custom: Install Windows only (advanced)"

### Driver Installation Issue & Resolution
**Problem:** Windows Setup could not see the 60GB disk  
**Cause:** VirtIO SCSI drivers not loaded  
**Solution:**
- Mounted virtio-win.iso to VM
- In Windows Setup, clicked "Load driver"
- Browsed to D:\vioscsi\2k22\amd64
- Installed Red Hat VirtIO SCSI controller driver
- Changed CD back to Windows Server ISO
- Disk appeared and installation proceeded

### Post-Installation Configuration
- Set Administrator password
- Logged in to Windows Server desktop
- Server Manager opened automatically

---

## Post-Installation Optimization

### VirtIO Guest Tools Installation
**Purpose:** Improve VM performance (disk I/O, network, graphics)

**Steps:**
1. Mounted virtio-win.iso to CD drive in Proxmox
2. Opened File Explorer in Windows
3. Navigated to CD Drive (D:)
4. Ran virtio-win-gt-x64.msi installer
5. Accepted defaults and installed all components
6. Restarted VM to activate drivers

**Verification:**
- Opened Device Manager
- Confirmed "Red Hat VirtIO Ethernet Adapter" in Network adapters
- Confirmed "Red Hat VirtIO SCSI controller" in Storage controllers
- Confirmed multiple VirtIO entries in System devices

---

## Computer Configuration

### Rename Computer
**Original name:** WIN-[random]  
**New name:** DC01

**Steps:**
1. Right-click Start → System
2. Clicked "Rename this PC"
3. Entered: DC01
4. Restarted to apply changes

---

## Network Configuration

### Static IP Assignment
**Network Segment:** 192.168.10.0/24  
**Assigned IP:** 192.168.10.10  
**Purpose:** Domain Controller requires static IP

**Configuration:**
- IP Address: 192.168.10.10
- Subnet Mask: 255.255.255.0
- Default Gateway: 192.168.10.1
- DNS Server: 127.0.0.1 (localhost - will be configured when DC is promoted)

**Steps:**
1. Right-click Start → Network Connections
2. Change adapter options
3. Right-click Ethernet → Properties
4. Selected IPv4 → Properties
5. Configured static IP settings
6. Applied changes

**Verification:**
- Opened Command Prompt
- Ran: `ipconfig`
- Confirmed IP: 192.168.10.10
- Confirmed Subnet: 255.255.255.0
- Confirmed Gateway: 192.168.10.1

---

**Completed:**
✅ Windows Server 2022 installed  
✅ VirtIO drivers installed and verified  
✅ Computer renamed to DC01  
✅ Static IP configured and verified  
✅ System ready for Active Directory installation

**Next Steps:**
- Install Active Directory Domain Services role
- Promote DC01 to Domain Controller
- Create sabrilab.local domain
- Configure DNS
- Begin OU structure creation

---

### Network Connectivity Tests (February 11, 2026)
**Ping Gateway (192.168.10.1):**
- Result: SUCCESS
- Packets: Sent = 4, Received = 4, Lost = 0 (0% loss)
- Response time: <1ms

**Ping Self (192.168.10.10):**
- Result: SUCCESS
- Network adapter fully functional

**Conclusion:** Network configuration verified and operational. Ready for AD installation.

---

## Notes & Lessons Learned

- VirtIO drivers must be loaded during Windows Setup for disk to be visible
- Keep virtio-win.iso readily available in Proxmox storage
- Always verify network configuration with ipconfig after changes
- Desktop Experience edition required for GUI management tools
- Static IP must be set before promoting to Domain Controller

---

## Time Investment
**Total time:** ~4 hours  
**Breakdown:**
- Planning and documentation: 45 min
- VM creation and Windows installation: 90 min
- Driver installation and troubleshooting: 30 min
- Post-installation configuration: 45 min
- Documentation: 30 min