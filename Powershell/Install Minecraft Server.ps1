#requires -version 3
If (([Security.Principal.WindowsIdentity]::GetCurrent().Owner.IsWellKnown("BuiltInAdministratorsSid")) -eq $false) {
      Start-Process powershell.exe -Argumentlist "-File", ('"{0}"' -f $MyInvocation.MyCommand.Source) -Verb RunAs
}
[System.Console]::ForegroundColor = 'White'
$ProgressPreference = 'SilentlyContinue'
$ErrorActionPreference = 'SilentlyContinue'
Set-Location "$env:USERPROFILE\Documents"
try { Start-Transcript "Minecraft Installation.ps1.txt" }
catch { Start-Transcript ("Minecraft Installation.ps1 {0}.txt" -f ((1..999) | Get-Random)) }
try { [string]$directory = "Minecraft Server"; New-Item -Name "$directory" -ItemType Directory | Out-Null }
catch { [string]$directory = "$(Get-Date -format 'MM-dd-yyyy ss ')Minecraft Server"; New-Item -Name "$directory" -ItemType Directory | Out-Null }
Set-Location "$directory"
function Set-Choice
{
      [CmdletBinding()]
      param (
            [Parameter(Position = 0)]
            [int]$howmanychoices
      )
      $choice = $null
      while ($choice -notin (1..$howmanychoices)) {
            $choice = Read-Host "> "
            if ($choice -notin (1..$howmanychoices)) { Write-Warning "Illegal response: $choice, Please select 1 through $howmanychoices."}
      }
      return $choice
}
function Set-RAMAmount
{
      [CmdletBinding()]
      param (
            [Parameter(Position = 0)]
            [int]$AvalRAM
      )
      [int]$RAM = $null
      while ($RAM -notin (1..$AvalRAM))
      {
            Write-Host (@"
You have about {0}GB installed and available for server use.
How much would you like to dedicate to your minecraft server?
"@ -f $AvalRAM)
            $RAM = Read-Host "> "
            if ($RAM -gt $AvalRAM) { Write-Warning "Illegal response: $RAM, Please give an amount lower than your available RAM amount ($AvalRAM). (In Gbs)" }
      }
      return $RAM
}
function Install-Java
{
      [CmdletBinding()]
      param (
            [Parameter()]
            [switch]$choco
      )
      if ($choco)
      {
            $chococheck = choco
            if ($chococheck)
            {
                  [version]$chocoversion = ($(choco) -match 'Chocolatey').SubString(12,7)
                  if ($chocoversion -lt '0.10.12')
                  {
                        Write-Warning "Chocolatey Version is out of date for how I install java. Do you want to update? [Y]es [n]o"
                        $yesno = Read-Host "> "
                        switch -Wildcard ($yesno)
                        {
                              'n'
                              {
                                    Write-Host "Well then we need to install java the old fashioned way..."
                                    [bool]$oldfashioned = $true
                                    break
                              }
                              default
                              {
                                    Start-Sleep -Seconds 3
                                    Start-Process powershell.exe -ArgumentList "choco", "upgrade", "chocolatey", "-y" -Wait -Verb RunAs
                              }
                        }
                        continue
                  }
            }
            if (-not $chococheck)
            {
                  if (Get-ExecutionPolicy -notmatch "Bypass" -or "AllSigned") { Set-ExecutionPolicy Allsigned -Scope Process -Force }
                  try { [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072 }
                  catch
                  {
                        Write-Warning @"
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
            Start-Process powershell.exe -ArgumentList "choco", "upgrade", "--install-if-not-installed", "adoptopenjdk11jre", "-y" -Wait -Verb RunAs
            RefreshEnv.cmd
      }
      elseif ($choco -eq $false -or $oldfashioned -eq $true)
      {
            $javaweb = (Invoke-WebRequest -Uri "https://www.java.com/en/download/manual.jsp" -MaximumRedirection 0)
            if (($env:PROCESSOR_ARCHITECTURE).SubString(3,2) -eq 64)
            {
                  [string[]]$javadownload = $javaweb.links.href | Where-Object { $_ -match "BundleId=241536" }
            }
            else
            {
                  [string[]]$javadownload = $javaweb.links.href | Where-Object { $_ -match "BundleId=241534" }
            }
            Push-Location "$env:USERPROFILE\Downloads"
            [datetime]$a = Get-Date -Format 'MM-dd-yyyy'
            Invoke-WebRequest -Uri $javadownload[0] -MaximumRedirection 1 -OutFile ("Java Setup {0}.exe" -f $a)
            Write-Host "Please install java through the executable. I'll wait..."
            Start-Process ("Java Setup {0}.exe" -f $a) -Wait -Verb RunAs
            Pop-Location
            [System.Environment]::GetEnvironmentVariables() | Out-Null
      }
}
[string]$RAMinbytes = Get-CimInstance -ClassName Win32_ComputerSystem | Select-Object -ExpandProperty TotalPhysicalMemory
[int]$RAMinGB = [System.Math]::Round($RAMinBytes / 1GB)
[int]$AvalRAM = $RAMinGB - 4
if ($RAMinGB -le 8) { Write-Warning ("With only {0}GB of RAM, it is not recommended to run a server as it will most likely lag your system." -f $RAMinGB) }
try { Get-Command java | Out-Null }
catch {
      Write-Host @"
You do not have Java Offline installed..
Do you want to install using Chocolatey or from their website? -will default to Java Manual installation.
[1] Chocolatey
[2] Java Manual
"@
      $_input = Set-Choice 2
      switch ($_input) {
            1 { Install-Java -choco }
            default { Install-Java }
      }
}
Write-Host @"
[1] Install Latest Minecraft Server    |    [5] Install Paper 1.14.4 Server
[2] Install Minecraft 1.15.1 Server    |
[3] Install Minecraft 1.14.4 server    |
[4] Install Paper 1.15.2 Server        |
"@
$_input = Set-Choice 5
Write-Host (@"
Please give an amount for how much RAM you want to dedicate to the server. (In Gbs)
You currently have {0}GB installed RAM.
"@ -f $RAMinGB)
[int]$RAMamount = Set-RAMAmount $AvalRAM
switch ($_input)
{
      1 {
            $mcserversite = (Invoke-WebRequest -Uri 'https://www.minecraft.net/en-us/download/server' -MaximumRedirection 0)
            [version]$latestmcversion, $version = (((($mcserversite).links).innerText) -match "minecraft_server").SubString(17,6), $latestmcversion
            [string]$executable = "$latestmcversion-Server.jar"
            Invoke-WebRequest -Uri $(($mcserversite).links.href | Where-Object { $_ -like "*/server.jar" }) -MaximumRedirection 0 -OutFile "$executable"
      }
      2 {
            [version]$version = "1.15.1"
            [string]$executable = "Minecraft1.15.1Server.jar"
            Invoke-WebRequest -Uri "https://launcher.mojang.com/v1/objects/4d1826eebac84847c71a77f9349cc22afd0cf0a1/server.jar" -MaximumRedirection 0 -OutFile "$executable"
      }
      3 {
            [version]$version = "1.14.4"
            [string]$executable = "Minecraft1.14.4Server.jar"
            Invoke-WebRequest -Uri "https://launcher.mojang.com/v1/objects/3dc3d84a581f14691199cf6831b71ed1296a9fdf/server.jar" -MaximumRedirection 0 -OutFile "$executable"
      }
      4 {
            [version]$version = "1.15.2"
            [string]$executable = "Paper1.15.2Server.jar"
            Invoke-WebRequest -Uri "https://papermc.io/api/v1/paper/1.15.2/143/download" -MaximumRedirection 1 -OutFile "$executable"
      }
      5 {
            [version]$version = "1.14.4"
            [string]$executable = "Paper1.14.4Server.jar"
            Invoke-WebRequest -Uri "https://papermc.io/api/v1/paper/1.14.4/243/download" -MaximumRedirection 1 -OutFile "$executable"
      }
      default {
            Write-Warning "How did you get here."
            Stop-Transcript
            Exit
      }
}
[System.Console]::Title = "Installing Minecraft $version"
if ($env:_JAVA_OPTIONS) { Write-Warning ("You already have the '_JAVA_OPTIONS' environment variable set to {0}." -f $env:_JAVA_OPTIONS) }
elseif (-not $env:_JAVA_OPTIONS) { [System.Environment]::SetEnvironmentVariable("_JAVA_OPTIONS", ("-Xmx{0}M" -f ($RAMamount * 1KB))) }
else { Write-Error "Something went wrong associated with the environment variable '_JAVA_OPTIONS'"; Exit }

## Start Setting up files with jar

New-Item -Name "start.bat" -Value ("java -Xmx{0}M -jar {1} nogui" -f ($RAMamount * 1KB), $executable) | Out-Null
Start-Process "start.bat" -Wait -WindowStyle Hidden
[string]$b = [Regex]::Replace([System.TimeZoneInfo]::Local.StandardName, '([A-Z])\w+\s*', '$1')
Set-Content "eula.txt" -Value @"
#By changing the setting below to TRUE you are indicating your agreement to our EULA (https://account.mojang.com/documents/minecraft_eula).
#$((Get-Date -Format "ddd MMM dd HH:mm:ss {0} yyyy") -f $b)
eula=true
"@
Write-Host "Now wait for the server to finish loading then type 'stop' in the command line." -ForegroundColor White
Start-Process "start.bat" -Wait -WindowStyle Normal
Write-Host "Please set up the server properties with your desired configuration. Don't forget to save the file. I'll wait..." -ForegroundColor White
Start-Process notepad.exe -ArgumentList "server.properties" -Wait
Write-Host @"
You can now start and run your server! Don't forget to setup port forwarding; help can be found here for that 
https://www.noip.com/support/knowledgebase/general-port-forwarding-guide/
Tips: Minecraft Server Port is 25565, You need to set TCP AND UDP
"@ -ForegroundColor Green
Write-Host "Would you like to start the server now?  y / n"
[string]$choice = Read-Host "> "
switch ($choice)
{
      y  { Start-Process "start.bat"; Stop-Transcript; Exit }
      default { Exit; Stop-Transcript }
}