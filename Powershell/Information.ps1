$ErrorActionPreference = 'Stop'
function Get-Choice {
    [CmdletBinding()]
    param ()
    $choice = $null
    while ($choice -notin (1..3)) {
        $choice = Read-Host
        if ($choice -notin (1..3)) { Write-Warning "Illegal input: $choice - select a number between 1 and 3" }
    }
    $choice
}
function Get-BasicInfo {
    [CmdletBinding()]
    param (
        [Parameter(mandatory=$true, Position = 0)]
        $ComputerInfo
    )
    $ComputerInfo | Format-List -Property CsUserName, TimeZone, CsName, OsName, OsVersion, OsSerialNumber
}
function Get-AdvancedInfo {
    [CmdletBinding()]
    param (
        [Parameter(mandatory=$true, Position = 0)]
        $ComputerInfo
    )
    $ComputerInfo | Format-List -Property WindowsProductName, WindowsProductId, WindowsInstallDateFromRegistry, OsLastBootUpTime, OsArchitecture
}
$allinfo = (Get-ComputerInfo)
Write-Output @"
Whatcha need?
[1] Basic Information
[2] Advanced Information
[3] Exit Script
-----------------------------------
"@
:main while ($true) {
    $choice = Get-Choice
    switch ($choice) {
        1 { Get-BasicInfo -ComputerInfo $allinfo }
        2 { Get-AdvancedInfo -ComputerInfo $allinfo }
        default {
            Write-Host -BackgroundColor Black "Thanks for using my script!"
            break main
        }
    }
}