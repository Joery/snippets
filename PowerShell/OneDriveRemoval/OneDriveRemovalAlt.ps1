# Start Logging
Start-Transcript -Append C:\Windows\CCM\Logs\RemoveOneDrive.txt

function KillProcesses
{
	# Kill OneDrive
	Get-Process OneDrive -ErrorAction SilentlyContinue | Stop-Process -PassThru

	# Kill Explorer
	Get-Process explorer -ErrorAction SilentlyContinue | Stop-Process -PassThru
}

function RemoveDefault
{
	# Create PSDrive for HKU
	New-PSDrive -PSProvider Registry -Name HKUDefaultHive -Root HKEY_USERS

	# Load Default User Hive
	Reg Load "HKU\DefaultHive" "C:\Users\Default\NTUser.dat"

	# Set OneDriveSetup Variable
	$OneDriveSetup = Get-ItemProperty "HKUDefaultHive:\DefaultHive\Software\Microsoft\Windows\CurrentVersion\Run" | Select -ExpandProperty "OneDriveSetup"

	# If Variable returns True, remove the OneDriveSetup Value
	If ($OneDriveSetup) { Remove-ItemProperty -Path "HKUDefaultHive:\DefaultHive\Software\Microsoft\Windows\CurrentVersion\Run" -Name "OneDriveSetup" }

	# Unload Hive
	Reg Unload "HKU\DefaultHive\"

	# Remove PSDrive HKUDefaultHive
	Remove-PSDrive "HKUDefaultHive"
}

function RemoveSystemInstall
{
	If (Test-Path "$env:systemroot\System32\OneDriveSetup.exe")
	{
		& "$env:systemroot\System32\OneDriveSetup.exe" /uninstall /allusers
		& "$env:systemroot\System32\OneDriveSetup.exe" /uninstall
	}
	If (Test-Path "$env:systemroot\SysWOW64\OneDriveSetup.exe")
	{
		& "$env:systemroot\SysWOW64\OneDriveSetup.exe" /uninstall /allusers
		& "$env:systemroot\SysWOW64\OneDriveSetup.exe" /uninstall
	}
}

function RemoveMachineInstall
{
	$Test = Test-Path -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\OneDriveSetup.exe"

	# Check if the machine-based installation regkey exists
	If ($Test)
	{
		Write-Host "Machine-based installation regkey exists, removing..."
		$Remove = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\OneDriveSetup.exe").UninstallString
		$Remove
		Write-Host "Machine-based OneDrive was successfully removed"
	}

	If (-not ($Test))
	{
		Write-Host "Machine-based installer does not exist"
	}
}

function RemoveUserInstall
{
	$Test = Test-Path -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\OneDriveSetup.exe"

	# Check if the user-based installation regkey exists
	If ($Test)
	{
		Write-Host "User-based installation regkey exists, removing..."
		$Remove = (Get-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\OneDriveSetup.exe").UninstallString
		$Remove
		Write-Host "User-based OneDrive was successfully removed"
	}

	If (-not ($Test))
	{
		Write-Host "User-based installer does not exist"
	}
}

function RemoveFiles
{
	If (Test-Path "C:\Program Files\Microsoft OneDrive")
	{
		Write-Host "C:\Program Files\Microsoft OneDrive exists, removing..."
		Remove-Item "C:\Program Files\Microsoft OneDrive" -Force -Recurse -ErrorAction SilentlyContinue
	}
	Else
	{
		Write-Host "C:\Program Files (x86)\Microsoft OneDrive does not exist"
	}

	If (Test-Path "C:\Program Files (x86)\Microsoft OneDrive")
	{
		Write-Host "C:\Program Files (x86)\Microsoft OneDrive exists, removing..."
		Remove-Item "C:\Program Files (x86)\Microsoft OneDrive" -Force -Recurse -ErrorAction SilentlyContinue
	}
	Else
	{
		Write-Host "C:\Program Files (x86)\Microsoft OneDrive does not exist"
	}

	If (Test-Path "%LOCALAPPDATA%\Microsoft\OneDrive")
	{
		Write-Host "%LOCALAPPDATA%\Microsoft\OneDrive exists, removing..."
		Remove-Item "%LOCALAPPDATA%\Microsoft\OneDrive" -Force -Recurse -ErrorAction SilentlyContinue
	}
	Else
	{
		Write-Host "%LOCALAPPDATA%\Microsoft\OneDrive does not exist"
	}

	If (Test-Path "%LOCALAPPDATA%\OneDrive")
	{
		Write-Host "%LOCALAPPDATA%\OneDrive exists, removing..."
		Remove-Item "%LOCALAPPDATA%\OneDrive" -Force -Recurse -ErrorAction SilentlyContinue
	}
	Else
	{
		Write-Host "%LOCALAPPDATA%\OneDrive does not exist"
	}

	If (Test-Path "C:\OneDriveTemp")
	{
		Write-Host "C:\OneDriveTemp exists, removing..."
		Remove-Item "C:\OneDriveTemp" -Force -Recurse -ErrorAction SilentlyContinue
	}
	Else
	{
		Write-Host "C:\OneDriveTemp does not exist"
	}
}

# Start Chain
KillProcesses
RemoveDefault
RemoveSystemInstall
RemoveMachineInstall
RemoveUserInstall

# Start Windows Explorer
Start-Process explorer

# Stop Logging
Stop-Transcript
