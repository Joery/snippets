# Replace tentant with your actual tenant name
Connect-SPOService -Url https://tenant-admin.sharepoint.com

# Add users manually
Request-SPOPersonalSite

# Add list of users
$emails = "user1@example.com", "user2@example.com"
Request-SPOPersonalSite -UserEmails $emails -NoWait

# List locations of files to be migrated
$users = 
"a",
"b",
"c"

$group1 = "FileServer1"
$group2 = "FileServer2"

$members1 = Get-ADGroupMember -Identity $group1 -Recursive | Select -ExpandProperty SamAccountName
$members2 = Get-ADGroupMember -Identity $group2 -Recursive | Select -ExpandProperty SamAccountName

ForEach ($user in $users)
{
	If ($members1 -contains $user)
	{
		Write-Host "\\path\to\FileServer1\$user\"
	}
	elseif ($members2 -contains $user)
	{
		Write-Host "\\path\to\FileServer2\$user\"
	}
	Else
	{
		Write-Host "$user is not in either group"
	}
}

# Rename special folders from English so OneDrive syncs them automatically
$folderArray =
'\\path\to\FileServer1\a\',
'\\path\to\FileServer1\b\',
'\\path\to\FileServer2\c\'

foreach ($folder in $folderArray)
{
	Rename-Item "$folder\Desktop" "Bureaublad"
	Rename-Item "$folder\Documents" "Documenten"
	Rename-Item "$folder\Pictures" "Afbeeldingen"
}
