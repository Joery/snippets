# return 1 if the key is there
# return 0 if the key is not there

$regKey = "HKLM:\SOFTWARE\..."
$regName = "Name"
$regValue = "Some Value"
$regKeyExists = Test-Path -Path $regKey
if ($regKeyExists) {
   $regNameExists = Get-ItemProperty -Path $regKey -Name $regName -ErrorAction SilentlyContinue
   if ($regNameExists) {
    $currentValue = Get-ItemProperty -Path $regKey | Select-Object -ExpandProperty $regName -ErrorAction SilentlyContinue
    if ($currentValue -eq $regValue) {
            return 1;
        } else {
            return 0;
        }
    } 
    else {
        return 0;
    }
} 
else {
    return 0;
}
