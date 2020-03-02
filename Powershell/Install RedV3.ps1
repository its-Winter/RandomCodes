#requires -version 3
If (([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator) -eq $false) {
      Start-Process powershell.exe -Argumentlist "-File", ("{0}" -f $MyInvocation.MyCommand.Source) -Verb RunAs
}
$ErrorActionPreference = 'SilentlyContinue'
$ProgressPreference = 'SilentlyContinue'
function Install-Prerequisites {
      [CmdletBinding()]
      param ()
      $chococheck = choco
      if ($chococheck)
      {
            [version]$chocoversion = ($(choco) -match 'Chocolatey').SubString(12,7)
            if ($chocoversion -lt '0.10.12')
            {
                  Write-Warning "Chocolatey Version is out of date for how I upgrade packages. Will update."
                  choco upgrade chocolatey --yes
            }
      }
      $host.ui.RawUI.WindowTitle = "Installing Prerequisites for Red V3.3 ..."
      if (-not $chococheck)
      {
            [string]$exepolicy = (Get-ExecutionPolicy)
            if ($exepolicy -notmatch "Bypass" -or "AllSigned")
            {
                  Set-ExecutionPolicy Allsigned -Scope Process -Force
            }
            try {
                  [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
            }
            catch
            {
                  Write-Output @"
Unable to set PowerShell to use TLS 1.2. This is required for contacting Chocolatey as of 03 FEB 2020. https://chocolatey.org/blog/remove-support-for-old-tls-versions.
If you see underlying connection closed or trust errors, you may need to do one or more of the following:
(1) upgrade to .NET Framework 4.5+ and PowerShell v3+
(2) Call [System.Net.ServicePointManager]::SecurityProtocol = 3072; in PowerShell prior to attempting installation
(3) specify internal Chocolatey package location (set $env:chocolateyDownloadUrl prior to install or host the package internally)
(4) use the Download + PowerShell method of install. See https://chocolatey.org/docs/installation for all install options.
"@
            }
            Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
      }
      choco upgrade --install-if-not-installed git --params "/GitOnlyOnPath /WindowsTerminal" -y
      choco upgrade --install-if-not-installed visualstudio2019-workload-vctools adoptopenjdk11jre -y
      choco upgrade --install-if-not-installed python3 -y
}
function Set-VirtualEnvironmentDirectory {
	[CmdletBinding()]
	param ()
      [string]$userin = $null
      [bool]$continue = $true
      while ($continue)
      {
            Write-Host @"
Now time to setup the virtual environment.
Where do you want the environment? Ex: path\to\venv
Or leave blank to use default path: $env:USERPROFILE\redenv\
"@
		[string]$userin = Read-Host "> "
            if ($userin -eq [string]::Empty -or $null)
            {
                  Write-Host "Are you sure you want to use the default path for the environment? y/n "
                  [string]$yesno = Read-Host "> "
                  switch ($yesno)
                  {
                        y {
                              if (Test-Path ("{0}\redenv" -f $env:USERPROFILE))
                              {
                                    Write-Warning ("{0}\redenv is already used." -f $env:USERPROFILE)
                              }
                              else {
                                    return "$(Join-Path -Path $env:USERPROFILE -ChildPath '\redenv')\"
                                    $continue = $false
                              }
                        }
                        n {
                              continue
                        }
                        default {
                              Write-Warning "You didn't specify a valid response: $yesno. please give 'y' or 'n' next time."
                              continue
                        }
                  }
                  # End Switch
            }
            # End IF
            elseif ($userin)
            {
                  if (Test-Path "$(Join-Path $env:USERPROFILE -ChildPath $userin)")
                  {
                        Write-Warning ("{0} already exists and will not be overwritten." -f "$(Join-Path $env:USERPROFILE -ChildPath $userin)")
                  }
                  Write-Host ("Are you sure you want to use {0} as your venv path?" -f $userin)
                  [string]$yesno = Read-Host "> "
                  switch ($yesno)
                  {
                        y {
                              return "$(Join-Path $env:USERPROFILE $userin)\"
                              $continue = $false
                        }
                        n { continue }
                        default {
                              Write-Error -Category InvalidArgument -TargetObject $yesno -Message "You failed to give me a valid response.. Aborting.."
                              continue
                        }
                  }
            }
      }
}
Install-Prerequisites
if ($(python -V) -notmatch '3.8.[1-9]')
{
      [string]$newpath = ("{0}\python38\scripts\;{0}\python38\;{1}" -f $env:HOMEDRIVE, [System.Environment]::GetEnvironmentVariable("Path"))
      [System.Environment]::SetEnvironmentVariable("Path", "$newpath", "User")
      if (Test-Path ("{0}\AppData\Local\Programs\Python\Python38-32\" -f $env:USERPROFILE))
      {
            [string]$pypath = ("{0}\AppData\Local\Programs\Python\Python38-32\;{1}" -f $env:USERPROFILE, $env:Path)
            [System.Environment]::SetEnvironmentVariable("Path", "$pypath")
      }
      RefreshEnv.cmd
}
Write-Host "Installed Red Prerequisites!"
Start-Sleep 1
$host.ui.RawUI.WindowTitle = "Setup the Virtual Environment!"
[string]$venv = Set-VirtualEnvironmentDirectory
Write-Host "Setting up venv now!"
[string]$pyexe = ((Get-Command python -All | Where-Object -Property Version -Like 3.8.*).Source)
& "$pyexe" -m venv "$venv"
& "$venv\Scripts\activate.ps1"
python -m pip install -U pip setuptools wheel
python -m pip install -U Red-DiscordBot
pip install --upgrade pip >$null
try
{ 
      redbot -help | Out-Null
      Write-Output "Red V3 is ready to go!"
}
catch
{
      Write-Warning "Something went wrong attempting to use red."
      Write-Host -ForegroundColor Red $_
      Pause
      Exit
}
Start-Sleep 5
redbot-setup
redbot -help
redbot --list-instances
powershell.exe -NoLogo -NoExit