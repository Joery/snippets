# Kill Teams
Stop-Process -Name "Teams" -Force

# Kill AADWAM
Stop-Process -Name "Microsoft.AAD.BrokerPlugin" -Force

Start-Sleep -Seconds 2

# Update registry keys
Set-ItemProperty -Path HKCU:\Software\Microsoft\Office\16.0\Common\Identity -Name EnableADAL -Value 0 -Force
Set-ItemProperty -Path HKCU:\Software\Microsoft\Office\16.0\Common\Identity -Name DisableAADWAM -Value 0 -Force
Set-ItemProperty -Path HKCU:\Software\Microsoft\Office\16.0\Common\Identity -Name DisableADALatopWAMOverride -Value 0 -Force

# Rename SystemApps folder
Rename-Item "C:\Windows\SystemApps\Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy" -NewName Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy_old

# Clean Teams roaming appdata folder
Remove-Item ($ENV:USERPROFILE + '\AppData\Roaming\Microsoft\Teams\') -Recurse

Start-Sleep -Seconds 5

# Start Teams
Start-Process -File "$($env:USERProfile)\AppData\Local\Microsoft\Teams\Update.exe" -ArgumentList '--processStart "Teams.exe"'
