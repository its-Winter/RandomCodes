Set-ExecutionPolicy Bypass -Scope Process -Force
function prompt {'> '}
$host.ui.rawui.WindowTitle = "Checking Python Version..."
$ErrorActionPreference = 'SilentlyContinue'
$pyversion = $(-split $(py --version))[-1]
if ($pyversion) {
    if ($pyversion -lt '3.7.0') { Write-Warning 'You have a version older than 3.7 and it is required to update.'; $vergood = 1 }
    elseif ($pyversion -eq '3.8.1') { Write-Output 'You have the latest version of python!'; $vergood = 0 }
    elseif ($pyversion -ge '3.8.0') { Write-Output 'You have a good enough version of python.'; $vergood = 0 }
} else { Write-Output 'You do not have python installed.'; $vergood = 1 }
$host.ui.RawUI.WindowTitle = "Installing Prerequisites..."
function prerequisites {
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    choco install git --params "/GitOnlyOnPath /WindowsTerminal" -y 
    if ($vergood = 1) { choco install jre8 python -y }
    elseif ($vergood = 0) { choco install jre8 -y }
}
prerequisites
Clear-Host
Write-Output 'Installed Red Prerequisites!'
timeout.exe 1 >$null
$host.ui.RawUI.WindowTitle = "Setup the Virtual Environment!"
$setvenv = {
    Clear-Host
    Write-Output 'Now time to setup the virtual environment.
    Where do you want the environment? Ex: path\to\venv'
    $in = Read-Host ':'
    if ($in -eq [String]::Empty) {
        Write-Output 'Nothing was entered
        '
        &$setvenv; break }
    else {
        $venv = $($env:USERPROFILE + '\' + $in + '\')
        Write-Output 'Setting up venv now!'
        python.exe -m venv "$venv"; $re = 'defined'
    }
}
if (!$re) { &$setvenv }
& "$venv\Scripts\activate.ps1"
Clear-Host; Set-Location "$env:USERPROFILE"
$host.ui.RawUI.WindowTitle = "Red V3 is ready to go!"
pip install --upgrade pip >$null
redbot-setup
redbot-launcher
