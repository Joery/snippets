# Start logging output to a file
Start-Transcript -Append C:\PSWindowsUpdate.txt

# Install certificate to supress confirmable security warnings for headless running
Import-Certificate -FilePath .\PSWindowsUpdate.cer -CertStoreLocation cert:\LocalMachine\TrustedPublisher

# Copy NuGet package provider files to the device
Copy-Item '.\PackageManagement\' 'C:\Program Files\PackageManagement' -Force -Recurse

# Copy PSWindowsUpdate module files to the device
Copy-Item '.\PSWindowsUpdate\' 'C:\Program Files\WindowsPowerShell\Modules\PSWindowsUpdate' -Force -Recurse

# Because the module was installed manually, we have to import the module first
Import-Module PSWindowsUpdate -Force

# Install updates
Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -IgnoreReboot -Verbose
# -MicrosoftUpdate | Install updates from the online repository
# -AcceptAll       | Approve and install all found updates
# -IgnoreReboot    | Do not reboot automatically
# -Verbose         | Log everything

# Remove installed certificate for safety reasons
Get-ChildItem Cert:\LocalMachine\TrustedPublisher | Where-Object { $_.Subject -match 'PowerClouds Michal Gajda' } | Remove-Item

# Stop logging output
Stop-Transcript