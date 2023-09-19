# Usernames
Get-ADGroupMember -Identity GroupName -Recursive | sort name | select SamAccountName | Export-Csv -Path C:\Temp\export.csv -NoTypeInformation

# Emails
Get-ADGroupMember -Identity GroupName -Recursive | Get-ADUser -Properties Mail | Select-Object Mail | Export-Csv -Path C:\Temp\export.csv -NoTypeInformation
