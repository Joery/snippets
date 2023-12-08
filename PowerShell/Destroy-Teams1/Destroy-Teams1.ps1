# Try to kill Teams
try {
  Stop-Process -Name "Teams" -ErrorAction SilentlyContinue -Force
}
catch {
  "Unable to stop Teams" 
}

# Try to uninstall AppData Teams
try {
  Start-Process -FilePath "$env:LOCALAPPDATA\Microsoft\Teams\Update.exe" -ArgumentList "--uninstall -s" -Wait
}
catch {
  "Unable to uninstall Teams from AppData" 
}

# Try to uninstall ProgramData Teams
try {
  Start-Process -FilePath "$env:PROGRAMDATA\$env:USERNAME\Microsoft\Teams\Update.exe" -ArgumentList "--uninstall -s" -Wait
}
catch {
  "Unable to uninstall Teams from ProgramData" 
}

# Try to uninstall machine wide Teams
try {
  $MachineWide = Get-WmiObject -Class Win32_Product | Where-Object{$_.Name -eq "Teams Machine-Wide Installer"}
  $MachineWide.Uninstall()
}
catch {
  "Unable to uninstall machine-wide installer" 
}

# Install Teams 2.0
.\teamsbootstrapper.exe -p
Start-Sleep -Seconds 2

# Start Teams 2.0
explorer.exe shell:AppsFolder\MSTeams_8wekyb3d8bbwe!MSTeams
