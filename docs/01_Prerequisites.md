# Prerequisites

  * WinPE ISO (Windows Pre-installation Environment)
  * Windows10 ISO

## 1) WinPE ISO

[Windows PE](https://en.wikipedia.org/wiki/Windows_Preinstallation_Environment) (WinPE) for Windows 10 is a small operating system which is used to install, deploy and repair Windows 10 for desktop editions.

### Create WinPE ISO (on Windows Machine)

##### 1.  Install WinADK

https://docs.microsoft.com/en-us/windows-hardware/get-started/adk-install


##### 2. Open Deployment and Imaging Tools Environment as Admin
```
copype amd64 c:\WinPE_amd64 #for 64 bit operating systems
Dism /Mount-Image /ImageFile:"c:\WinPE_amd64\media\sources\boot.wim" /index:1 /MountDir:"c:\WinPE_amd64\mount"
```

##### 3. Edit startnet.cmd to connect to network file share
```
notepad c:\WinPE_amd64\mount\Windows\System32\startnet.cmd
```
```
wpeinit
ipconfig /renew
ipconfig /renew
ipconfig /renew
net use z: \\<RNI_IP>\install /user:<username> <password>
@ECHO Mapping ISO File
z:\setup.exe /unattend:z:unattend.xml
```
**NOTE**: If you are working behind corporate domain network then add domain name as well in **"net use"** command as shown below
```
wpeinit
ipconfig /renew
ipconfig /renew
ipconfig /renew
net use z: \\<RNI_IP>\install /user:<domainname>\<username> <password>
@ECHO Mapping ISO File
z:\setup.exe /unattend:z:unattend.xml
```
##### 4. Delete c:\WinPE_amd64\media\boot\bootfix.bin to remove key-press to boot option

##### 5. Unmount Image
```
Dism /Unmount-Image /MountDir:"c:\WinPE_amd64\mount" /commit
```
##### 6. Make ISO File
```
MakeWinPEMedia /ISO c:\WinPE_amd64 c:\winpe_10.iso
```
- *Copy winpe_10.iso to **/path/to/retail-node-installer/data/srv/tftp/images/{win_profile_name}** and give executable permissions to iso*

## 2) Windows10 ISO

##### Download windows 10 trial ISO from [here](https://www.microsoft.com/en-us/evalcenter/evaluate-windows-10-enterprise)

##### 1. Mount Windows 10 ISO (on machine where RNI is installed)
```
mkdir /mnt/win10
mount -o loop /path/to/win10/iso /mnt/win10
```
##### 2. Copy Windows 10 ISO content to */path/to/retail-node-installer/data/srv/tftp/images/iso* directory
```
cp -R /mnt/win10/* /path/to/retail-node-installer/data/srv/tftp/images/iso
```

##### 3. Add *unattend.xml* file in */path/to/retail-node-installer/data/srv/tftp/images/iso* directory for automated windows setup and give executable permission to it. 

For guide on how to write unattend.xml. [See this](02_Miscellaneous.md)

