# Guide to write answer file for automated windows setup

### 1. sample answer file

If you are using Windows Enterprise 10 trial ISO then copy below content in xml configuration file i.e. unattend.xml and save it in /smbshare/iso directory.

*Before using below sample answer file, please set user account details(like Username, Password, Displayname etc.) in ***UserAccounts***  and ***AutoLogon*** sections.*


```
<?xml version="1.0" encoding="utf-8"?>
<unattend xmlns="urn:schemas-microsoft-com:unattend">
  <settings pass="windowsPE">
    <component name="Microsoft-Windows-International-Core-WinPE" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
      <SetupUILanguage>
        <UILanguage>en-US</UILanguage>
      </SetupUILanguage>
      <InputLocale>en-US</InputLocale>
      <SystemLocale>en-US</SystemLocale>
      <UILanguage>en-US</UILanguage>
      <UserLocale>en-US</UserLocale>
    </component>
    <component name="Microsoft-Windows-Setup" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">

      <DiskConfiguration>

        <Disk wcm:action="add">
          <DiskID>0</DiskID>
          <WillWipeDisk>true</WillWipeDisk>
          <CreatePartitions>
            <!-- System partition -->
            <CreatePartition wcm:action="add">
              <Order>1</Order>
              <Type>Primary</Type>
              <Size>350</Size>
            </CreatePartition>

            <!-- Windows partition -->
            <CreatePartition wcm:action="add">
              <Order>2</Order>
              <Type>Primary</Type>
              <Extend>true</Extend>
            </CreatePartition>
          </CreatePartitions>

          <ModifyPartitions>
            <!-- System partition -->
            <ModifyPartition wcm:action="add">
              <Order>1</Order>
              <PartitionID>1</PartitionID>
              <Label>System</Label>
              <Letter>S</Letter>
              <Format>NTFS</Format>
              <Active>true</Active>
            </ModifyPartition>

            <!-- Windows partition -->
            <ModifyPartition wcm:action="add">
              <Order>2</Order>
              <PartitionID>2</PartitionID>
              <Label>Windows</Label>
              <Letter>C</Letter>
              <Format>NTFS</Format>
            </ModifyPartition>
          </ModifyPartitions>
        </Disk>
        <WillShowUI>OnError</WillShowUI>
      </DiskConfiguration>

      <ImageInstall>
        <OSImage>
          <InstallTo>
            <DiskID>0</DiskID>
            <PartitionID>2</PartitionID>
          </InstallTo>
        </OSImage>
      </ImageInstall>
      <UserData>
        <AcceptEula>true</AcceptEula>
        <Organization>WC</Organization>
      </UserData>
    </component>
  </settings>
  <settings pass="oobeSystem">
    <component name="Microsoft-Windows-Shell-Setup" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
      <OOBE>
        <HideEULAPage>true</HideEULAPage>
        <HideOEMRegistrationScreen>true</HideOEMRegistrationScreen>
        <HideOnlineAccountScreens>true</HideOnlineAccountScreens>
        <HideWirelessSetupInOOBE>true</HideWirelessSetupInOOBE>
        <ProtectYourPC>1</ProtectYourPC>
      </OOBE>
      <UserAccounts>
        <LocalAccounts>
          <LocalAccount wcm:action="add">
            <Password>
              <Value>YOUR_PASSWORD</Value>
              <PlainText>true</PlainText>
            </Password>
            <DisplayName>YOUR_DISPLAYNAME</DisplayName>
            <Group>Administrators</Group>
            <Name>YOUR_USERNAME</Name>
            <Description>Primary Account</Description>
          </LocalAccount>
        </LocalAccounts>
      </UserAccounts>
      <AutoLogon>
        <Password>
          <Value>YOUR_PASSWORD</Value>
          <PlainText>true</PlainText>
        </Password>
        <Enabled>true</Enabled>
        <Username>YOUR_USERNAME</Username>
      </AutoLogon>
      <FirstLogonCommands>
        <SynchronousCommand wcm:action="add">
          <CommandLine>shutdown /s /t 0 /c "Installation Completed"</CommandLine>
          <Order>1</Order>
        </SynchronousCommand>
      </FirstLogonCommands>
    </component>
    <component name="Microsoft-Windows-International-Core" processorArchitecture="wow64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
      <InputLocale>en-US</InputLocale>
      <SystemLocale>en-US</SystemLocale>
      <UILanguage>en-US</UILanguage>
      <UserLocale>en-US</UserLocale>
    </component>
  </settings>
  <cpi:offlineImage cpi:source="wim://desktop-hmu50vv/fsources/install.wim#Windows 10 Pro" xmlns:cpi="urn:schemas-microsoft-com:cpi" />
</unattend>

```

### 2. Sample answer file for Windows 10 Enterprise ISO (full version) installation

If you are using above answer file with Windows 10 Enterprise ISO (full version) for installation then you will be prompt to choose Windows Desktop type while provisioning target device. 

In order avoid manual selection, modify **UserData** section in above answer file with below content to use installation key. 
```
<UserData>
  <ProductKey>
    <Key>VK7JG-NPHTM-C97JM-9MPGT-3V66T</Key>
  </ProductKey>
  <AcceptEula>true</AcceptEula>
  <Organization>WC</Organization>
</UserData>
```

### References

* https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/automate-windows-setup
* https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/update-windows-settings-and-scripts-create-your-own-answer-file-sxs#create-and-modify-an-answer-file
* https://www.windowscentral.com/how-create-unattended-media-do-automated-installation-windows-10
* https://www.windowsafg.com/win10x86_x64.html
* https://docs.microsoft.com/en-us/windows-hardware/customize/desktop/unattend/microsoft-windows-setup
