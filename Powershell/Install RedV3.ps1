$ErrorActionPreference = 'SilentlyContinue'
$ProgressPreference = 'SilentlyContinue'
function Get-RedChoice {
      [CmdletBinding()]
      param ()
      [int]$Redchoice = $null
      while ($Redchoice -notin (1..2))
      {
            [int]$Redchoice = Read-Host
            if ($Redchoice -notin (1..2))
            {
                  Write-Warning "Illegal Input: $Redchoice - Please give a number 1 or 2."
            }
      }
      return $Redchoice
}
function Install-Prerequisitesold {
      [CmdletBinding()]
      param (
            [version]$MinimumVersion = '3.7.0'
      )
      $host.ui.rawui.WindowTitle = "Checking Python Version..."
      [version]$pythonVersion = (-split $(py -3 -V))[-1]
      if (-not $pythonVersion) { [version]$pythonVersion = (-split $(python -V))[-1] }
      if (-not $pythonVersion)
      {
            Write-Host 'You do not have python installed, installing ...'
            $InstallPython = $true
      }
      elseif ($MinimumVersion -gt $pythonVersion)
      {
            Write-Host "Python $pythonVersion detected, but $MinimumVersion or above is required. Updating"
            $InstallPython = $true
      }
      $chococheck = choco
      $host.ui.RawUI.WindowTitle = "Installing Prerequisites for Red V3.2 ..."
      if (-not $chococheck) { Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')) }
      choco install git --params "/GitOnlyOnPath /WindowsTerminal" -y 
      if ($InstallPython -eq $false) { choco install jre8 -y }
      else { choco install jre8 python -y }
      $ErrorActionPreference = 'Stop'
}
function Install-Prerequisitesnew {
      [CmdletBinding()]
      param (
            [version]$MinimumVersion = '3.8.1'
      )
      $host.ui.rawui.WindowTitle = "Checking Python Version..."
      [version]$pythonVersion = (-split $(py -3 -V))[-1]
      if (-not $pythonVersion) { [version]$pythonVersion = (-split $(python -V))[-1] }
      if (-not $pythonVersion)
      {
            Write-Host "You do not have python installed, installing ..."
            $InstallPython = $true
      }
      elseif ($MinimumVersion -gt $pythonVersion)
      {
            Write-Host "Python $pythonVersion detected, but $MinimumVersion or above is required. Updating"
            $InstallPython = $true
      }
      $chococheck = choco
      $host.ui.RawUI.WindowTitle = "Installing Prerequisites for Red V3.3 ..."
      choco install visualstudio2019-workload-vctools adoptopenjdk11jre -y
      if ($InstallPython)
      {
            choco install python3 -y
      }
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
		[string]$userin = Read-Host "> "
		if ($userin -eq [string]::Empty) { Write-Warning "Illegal input: $userin - Please type a directory like the example." }
      }
      return "$(Join-Path $env:USERPROFILE $userInput)\"
}
Write-Host @"
Please select a version of Red to install.
1) Red V3.3 (latest)
2) Red V3.2.3
"@
[int]$Redchoice = Get-RedChoice
switch ($Redchoice)
{
      1 { Install-Prerequisitesnew }
      2 { Install-Prerequisitesold }
}
if ((python -V) -notmatch '3.8.1')
{
      [string]$newpath = "$env:HOMEDRIVE\python38\scripts\;$env:HOMEDRIVE\python38\;$env:Path"
      [System.Environment]::SetEnvironmentVariable("Path", "$newpath", "User")
      if (Test-Path "$env:USERPROFILE\AppData\Local\Programs\Python\Python38-32\")
      {
            [string]$pypath = "$env:USERPROFILE\AppData\Local\Programs\Python\Python38-32\;$env:Path"
            [System.Environment]::SetEnvironmentVariable("Path", "$pypath")
      }
}
Write-Host "Installed Red Prerequisites!"
Start-Sleep 1
$host.ui.RawUI.WindowTitle = "Setup the Virtual Environment!"
$venv = Set-VirtualEnvironmentDirectory
Write-Host "Setting up venv now!"
$pyexe = ($env:USERPROFILE + "\AppData\Local\Programs\Python\Python38-32\python.exe")
& "$pyexe" -m venv "$venv"
& "$venv\Scripts\activate.ps1"
python -m pip install -U pip setuptools wheel
python -m pip install -U Red-DiscordBot
pip install --upgrade pip >$null
Write-Output "Red V3 is ready to go!"
Start-Sleep 5
redbot-setup
redbot -help
redbot --list-instances
powershell.exe -NoLogo -NoExit