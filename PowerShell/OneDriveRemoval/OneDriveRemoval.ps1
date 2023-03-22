# Remove default user-based install on new profiles

# Create PSDrive for HKU
New-PSDrive -PSProvider Registry -Name HKUDefaultHive -Root HKEY_USERS

# Load Default User Hive
Reg Load "HKU\DefaultHive" "C:\Users\Default\NTUser.dat"

# Set OneDriveSetup variable
$OneDriveSetup = Get-ItemProperty "HKUDefaultHive:\DefaultHive\Software\Microsoft\Windows\CurrentVersion\Run" | Select -ExpandProperty "OneDriveSetup"

# If variable returns True, remove the OneDriveSetup value
If ($OneDriveSetup) { Remove-ItemProperty -Path "HKUDefaultHive:\DefaultHive\Software\Microsoft\Windows\CurrentVersion\Run" -Name "OneDriveSetup" }

# Unload Hive
Reg Unload "HKU\DefaultHive\"

# Remove PSDrive HKUDefaultHive
Remove-PSDrive "HKUDefaultHive"

# Remove machine-wide OneDrive installation
$OneDriveUninstall = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\OneDriveSetup.exe").UninstallString | Invoke-Expression

# Remove user-based OneDrive installation
$OneDriveUninstall = (Get-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\OneDriveSetup.exe").UninstallString | Invoke-Expression