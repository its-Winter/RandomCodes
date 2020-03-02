$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'
function Get-Choice
{
      [CmdletBinding()]
      param ()
      $choice = $null
      while ($choice -notin (1..4))
      {
            $choice = Read-Host
            if ($choice -notin (1..4)) { Write-Warning "Illegal input: $choice - select a number between 1 and 3" }
      }
      return $choice
}
function Get-BasicInfo
{
      [CmdletBinding()]
      param (
            [Parameter(Mandatory = $true, Position = 0)]
            $ComputerInfo
      )
      return $ComputerInfo | Format-List -Property CsUserName, TimeZone, CsName, OsName, OsVersion, OsSerialNumber
}
function Get-AdvancedInfo
{
      [CmdletBinding()]
      param (
            [Parameter(Mandatory = $true, Position = 0)]
            $ComputerInfo
      )
      return $ComputerInfo | Format-List -Property WindowsProductName, WindowsProductId, WindowsInstallDateFromRegistry, OsLastBootUpTime, OsArchitecture
      return Get-CimInstance -ClassName Win32_VideoController | Format-List -Property Name
}
function Get-VideoDetails
{
      [CmdletBinding()]
      param (
            [Parameter(Mandatory = $true, Position = 0)]
            $ComputerInfo
      )
      $videoinfo = (Get-CimInstance -Class Win32_VideoController | Format-List -Property VideoProcessor, VideoModeDescription, DriverDate, DriverVersion, CurrentRefreshRate, MaxRefreshRate)
      return $videoinfo
}
$allinfo = (Get-ComputerInfo)
:main while ($true)
{
      $choice = $null
      Write-Host @"
Whatcha need?
[1] Basic Information
[2] Advanced Information
[3] Video Controller Information
[4] Exit Script
-----------------------------------
"@
      $choice = Get-Choice
      switch ($choice) {
            1 { Get-BasicInfo $allinfo }
            2 { Get-AdvancedInfo $allinfo }
            3 { Get-VideoDetails $allinfo }
            default {
                  Write-Host -BackgroundColor Black "Thanks for using my script!"
                  break main
            }
      }
}