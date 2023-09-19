$User = Read-Host -Prompt 'Gebruikersnaam'

# Kill Teams & AADWAM
Stop-Process -Name "Teams" -ErrorAction SilentlyContinue -Force
Write-Host "Teams process killed"
Stop-Process -Name "Microsoft.AAD.BrokerPlugin" -ErrorAction SilentlyContinue -Force
Write-Host "AAD.BrokerPlugin process killed"

# Wait
Start-Sleep -Seconds 2

# Rename SystemApps folder
$Folder = "C:\Windows\SystemApps\Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy"
if (Test-Path -Path $Folder)
{
	# Rename SystemApps folder
	Rename-Item "C:\Windows\SystemApps\Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy" -NewName Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy_old
}
else
{
	# Do nothing
}
Write-Host "AAD.BrokerPlugin folder renamed"

# Clean Teams roaming appdata folder
$Folder = ("C:\Users\" + $User + "\AppData\Roaming\Microsoft\Teams\")
if (Test-Path -Path $Folder)
{
	# Clean Teams roaming appdata folder
	Remove-Item $Folder -ErrorAction SilentlyContinue -Recurse
}
else
{
	# Do nothing
}
Write-Host "Teams folder cleared"

Write-Host "Starting Teams..."

# Wait
Start-Sleep -Seconds 5

# Start Teams
Start-Process -File ("C:\Users\" + $User + "\AppData\Local\Microsoft\Teams\Update.exe") -ArgumentList '--processStart "Teams.exe"'
