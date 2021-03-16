# Windows 10 Profile

Intended to be used with Retail Node Installer, this Windows 10 OS profile contains a few configurations files that ultimately will install Windows 10 OS to disk provided prerequisites are met.

## Target Device Prerequisites

* x86 Bare Metal or x86 Virtual Machine
* At Least 20 GB of Disk Space
* 4 GB of RAM

## Getting Started

**One of the necessary prerequisite for using this profile is having an Retail Node Installer deployed**. Please refer to Retail Node Installer project documentation for [installation](https://github.com/intel/retail-node-installer) in order to deploy it.

Out of the box, the Windows profile _will not just work_. Specific steps are required in order to use this profile other then described in the Retail Node Installer documentation. For more details please refer [prerequisites](#prerequisites).

Once all prerequisites are met then boot a client device using legacy BIOS PXE boot and the Windows profile should automatically launch after a brief waiting period. 

If you do encounter issues PXE booting, please review the steps outlined in the Retail Node Installer documentation and ensure you've followed them correctly. See the [Known Issues](https://github.com/intel/retail-node-installer) section for possible solutions.

## Prerequisites

  * WinPE ISO (Windows Pre-installation Environment)
  * Windows10 ISO

For more details on prerequisites steps. [See this](docs/01_Prerequisites.md)

