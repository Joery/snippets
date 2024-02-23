$NewDevice = Get-ADComputer -Filter * -SearchBase 'OU=Computers,DC=example,DC=com'

switch -Regex ($NewDevice.DistinguishedName) {
    # \d stands for a single digit, so the first rule would match ABC1234, while the second rule would match ABCD1234, etc.
    '^CN=ABC\d\d\d\d' { Move-ADObject -Identity $_ -TargetPath 'OU=Laptop,OU=Devices,DC=example,DC=com' }
    '^CN=ABCD\d\d\d\d' { Move-ADObject -Identity $_ -TargetPath 'OU=Desktop,OU=Devices,DC=example,DC=com' }
}
