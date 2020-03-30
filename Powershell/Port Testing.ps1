$ErrorActionPreference = 'SilentlyContinue'
$ProgressPreference = 'SilentlyContinue'
Function Test-Port {
      [CmdletBinding()]
      param (
            [Parameter(Mandatory, Position = 0)]
            [string]$port
      )
      Invoke-RestMethod -Uri ("https://ifconfig.co/port/{0}" -f $port) -MaximumRedirection 0
}
Function Get-Port {
      [CmdletBinding()]
      param ()
      while ($portchoice -notin (1..47808))
      {
            [int]$portchoice = $null
            Write-Host "What port would you like to test?"
            [int]$portchoice = Read-Host ">"
            if ($portchoice -notin (1..47808)) { Write-Warning ("Illegal Response: {0}. Please give a valid port number." -f $_userport) }
      }
      return $portchoice
}
while ($true)
{
      [int]$_userport = Get-Port
      $portresults = Test-Port "$_userport"
      if ($portresults.reachable -eq $false) { Write-Host ("Could not reach port {0}." -f $_userport) -ForegroundColor Red }
      else { $portresults | Format-List }
}