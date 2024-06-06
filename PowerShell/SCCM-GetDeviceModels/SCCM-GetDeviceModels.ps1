[CmdletBinding(SupportsShouldProcess=$true)]
param(
    [parameter(Mandatory=$true, HelpMessage="Server where SCCM is installed")]
    [ValidateNotNullOrEmpty()]
    [ValidateScript({Test-Connection -ComputerName $_ -Count 1 -Quiet})]
    [string]$SiteServer
)
Begin {
    try {
        Write-Verbose "Get SiteCode for SCCM"
        $SiteCodeObjects = Get-WmiObject -Namespace "root\SMS" -Class SMS_ProviderLocation -ComputerName $SiteServer -ErrorAction Stop
        foreach ($SiteCodeObject in $SiteCodeObjects) {
            if ($SiteCodeObject.ProviderForLocalSite -eq $true) {
                $SiteCode = $SiteCodeObject.SiteCode
                Write-Debug "SiteCode: $($SiteCode)"
            }
        }
    }
    catch [Exception] {
        Throw "Wrong SiteCode"
    }
}
Process {
    $ModelsArrayList = New-Object -TypeName System.Collections.ArrayList
    $ComputerSystems = Get-WmiObject -Namespace "root\SMS\site_$($SiteCode)" -Class SMS_G_System_COMPUTER_SYSTEM -ComputerName $SiteServer | Select-Object -Property Model, Manufacturer
    if ($ComputerSystems -ne $null) {
        foreach ($ComputerSystem in $ComputerSystems) {
            if ($ComputerSystem.Model -notin $ModelsArrayList.Model) {
                $PSObject = [PSCustomObject]@{
                    Model = $ComputerSystem.Model
                    Manufacturer = $ComputerSystem.Manufacturer
                }
                $ModelsArrayList.Add($PSObject) | Out-Null
            }
        }
    }
    Write-Output $ModelsArrayList
}
