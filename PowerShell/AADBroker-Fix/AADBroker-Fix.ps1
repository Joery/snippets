Function ReportResult($Result) {
  Write-Output "Reporting results to log"
  $Hostname = [System.Net.Dns]::GetHostName()
  Add-Content -Path \\some\path\to\logging.txt -Value "$Hostname | $Result"
}

$regPath      = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\NetworkIsolation"
$regName      = "DSubnetsAuthoritive"
$regValue     = "1"
$regKeyExists = Test-Path -Path $regPath

if ($regKeyExists) {
  $regNameExists = Get-ItemProperty -Path $regPath -Name $regName -ErrorAction SilentlyContinue
  if ($regNameExists) {
    $currentValue = Get-ItemProperty -Path $regPath | Select-Object -ExpandProperty $regName -ErrorAction SilentlyContinue
    if ($currentValue -eq $regValue) {
      Write-Host "DSubnetsAuthoritive exists and set to 1, action needed"
      $Path  = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\NetworkIsolation"
      $Name  = "DSubnetsAuthoritive"
      $Value = "0"
      If (-NOT (Test-Path $Path)) {
        New-Item -Path $Path -Force | Out-Null
      }
      New-ItemProperty -Path $Path -Name $Name -Value $Value -PropertyType DWORD -Force
      Write-Host "DSubnetsAuthoritive added/updated and set to 0"
      $Path  = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\NetworkIsolation"
      $Name  = "DomainSubnets"
      $Value = "10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16"
      If (-NOT (Test-Path $Path)) {
        New-Item -Path $Path -Force | Out-Null
      }
      New-ItemProperty -Path $Path -Name $Name -Value $Value -PropertyType STRING -Force
      Write-Host "DomainSubnets added/updated and set"
      ReportResult -Result "DSubnetsAuthoritive & DomainSubnets added/updated and set"
      Exit 0
    }
    else {
      Write-Host "DSubnetsAuthoritive exists but set to $currentValue, no action needed"
      ReportResult -Result "DSubnetsAuthoritive exists but set to $currentValue"
      Exit 0
    }
  }
  else {
    Write-Host "DSubnetsAuthoritive does not exist, no action needed"
    ReportResult -Result "DSubnetsAuthoritive does not exist"
    Exit 0
  }
}
else {
  Write-Host "NetworkIsolation does not exist, no action needed"
  ReportResult -Result "NetworkIsolation does not exist"
  Exit 0
}
