Get-Content "C:\Temp\devicelist.txt" | foreach { Add-CMDeviceCollectionDirectMembershipRule -CollectionName "Device List" -ResourceID (Get-CMDevice -Name $_).ResourceID }
