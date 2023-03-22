# Add drivers to Windows
Dism /Get-ImageInfo /ImageFile:D:\install.wim # Confirm the correct index number for the next step
Dism /Mount-Image /ImageFile:D:\install.wim /MountDir:D:\Temp /Index:3
Dism /Image:D:\Temp /Add-Driver /Driver:D:\Driver /Recurse
Dism /Unmount-Image /MountDir:D:\Temp /Commit

# Add drivers to WinPE
Dism /Get-ImageInfo /ImageFile:D:\boot.wim # Confirm the correct index number for the next step
Dism /Mount-Image /ImageFile:D:\boot.wim /MountDir:D:\Temp /Index:1
Dism /Image:D:\Temp /Add-Driver /Driver:D:\Driver /Recurse
Dism /Unmount-Image /MountDir:D:\Temp /Commit