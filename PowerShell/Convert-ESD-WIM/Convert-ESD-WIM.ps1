# Confirming the correct index number for the image we want to convert
Dism /Get-ImageInfo /ImageFile:D:\install.wim

# Convert image
Dism /Export-Image /SourceImageFile:D:\install.esd /SourceIndex:3 /DestinationImageFile:D:\install.wim /Compress:max /CheckIntegrity