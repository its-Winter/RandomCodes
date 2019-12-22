function prompt {'> '}
Set-ExecutionPolicy Bypass -Scope Process -Force
$host.ui.rawui.WindowTitle = "Checking Python Version..."
$pyversion = $(-split $(python -V))[-1]
if ($pyversion -lt '3.7.0') { Write-Output 'You have a version older than 3.7 and it is required to update.'; $vergood = 1 }
elseif ($pyversion -ge '3.8.0') { Write-Output 'You have the latest version of python!'; $vergood = 0 }

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
        python.exe -m venv "$venv"
    }
}
&$setvenv
"$venv\Scripts\activate.ps1"
Clear-Host; Set-Location "$env:USERPROFILE"
$host.ui.RawUI.WindowTitle = "Red V3 is ready to go!"
pip install --upgrade pip >$null
redbot-setup
redbot-launcher
