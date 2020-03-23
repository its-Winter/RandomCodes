$ErrorActionPreference = 'SilentlyContinue'
$ProgressPreference = 'SilentlyContinue'
Function Test-Port {
      [CmdletBinding()]
      param (
            [Parameter(Mandatory, Position = 0)]
            [string]$port
      )
      Write-Host ("Testing port {0}..." -f $port)
      Invoke-RestMethod -Uri ("https://ifconfig.co/port/{0}" -f $port) -MaximumRedirection 0 | Format-List
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
while (1 -eq 1)
{
      [int]$_userport = Get-Port
      Test-Port "$_userport"
}