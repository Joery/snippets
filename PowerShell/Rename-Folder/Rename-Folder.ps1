$Folder = '$env:USERPROFILE\Work Folders'
if (Test-Path -Path $Folder) {
  "Path exists, renaming..."
  Rename-Item "$env:USERPROFILE\Work Folders" "_Work Folders"
  # Wait for a few second to ensure the operation is complete
  Start-Sleep -Seconds 10
  # Start process if needed
  Start-Process -FilePath "C:\Program Files\Microsoft OneDrive\OneDrive.exe"
}
else {
  "Path does not exist"
}
