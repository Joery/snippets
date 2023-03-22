Dism /Get-ImageInfo /ImageFile:D:\install.wim
Dism /Mount-Image /ImageFile:D:\install.wim /MountDir:D:\Temp /Index:3
Get-AppXProvisionedPackage -Path D:\Temp | Select DisplayName, PackageName
Dism /Unmount-Image /MountDir:D:\Temp /Discard