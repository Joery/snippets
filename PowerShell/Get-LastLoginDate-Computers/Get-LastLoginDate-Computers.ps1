Get-ADComputer -Filter * -SearchBase "OU=Computers,DC=example,DC=com" -Properties * | Sort LastLogon | Select Name, LastLogonDate,@{Name='LastLogon';Expression={[DateTime]::FromFileTime($_.LastLogon)}} | Export-Csv C:\Temp\last-logon.csv -NoTypeInformation

# Only enabled computers
Get-ADComputer -Filter {Enabled -eq $true} -SearchBase "OU=Computers,DC=example,DC=com" -Properties * | Sort LastLogon | Select Name, LastLogonDate,@{Name='LastLogon';Expression={[DateTime]::FromFileTime($_.LastLogon)}} | Export-Csv C:\Temp\last-logon-enabled.csv -NoTypeInformation
