$host.ui.rawui.WindowTitle = "Checking Python Version..."
$ErrorActionPreference = 'SilentlyContinue'
$ProgressPreference = 'SilentlyContinue'

function Install-Prerequisites {
      [CmdletBinding()]
      param (
            [version]$MinimumVersion = '3.7.0'
      )
      [version]$pythonVersion = (-split $(py -3 -V))[-1]
      if (-not $pythonVersion) { [version]$pythonVersion = (-split $(python -V))[-1] }
      if (-not $pythonVersion) {
            Write-Host 'You do not have python installed, installing ...'
            $InstallPython = $true
      }
      elseif ($MinimumVersion -gt $pythonVersion) {
            Write-Host "Python $pythonVersion detected, but $MinimumVersion or above is required. Updating"
            $InstallPython = $true
      }
      [string]$chococheck = choco
      $host.ui.RawUI.WindowTitle = "Installing Prerequisites..."
      if (-not $chococheck) { Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')) }
      choco install git --params "/GitOnlyOnPath /WindowsTerminal" -y 
      if ($InstallPython -eq $false) { choco install jre8 -y }
      else { choco install jre8 python -y }
      $ErrorActionPreference = 'Stop'
}
function Set-VirtualEnvironmentDirectory {
	[CmdletBinding()]
	param ()
	$userin = $null
	while (-not $userin) {
            Write-Host @"
Now time to setup the virtual environment.
Where do you want the environment? Ex: path\to\venv
"@
		[string]$userin = Read-Host ">"
		if ($userin -eq [string]::Empty) { Write-Warning "Illegal input: $userin - Please type a directory like the example." }
      }
      return "$(Join-Path $env:USERPROFILE $userInput)\"
}
Install-Prerequisites
Write-Host "Installed Red Prerequisites!"
Start-Sleep 1
$host.ui.RawUI.WindowTitle = "Setup the Virtual Environment!"
$venv = Set-VirtualEnvironmentDirectory
Write-Host "Setting up venv now!"
python3 -m venv $venv
& "$venv\Scripts\activate.ps1"
$host.ui.RawUI.WindowTitle = "Red V3 is ready to go!"
pip install --upgrade pip >$null
redbot-setup
redbot-launcher