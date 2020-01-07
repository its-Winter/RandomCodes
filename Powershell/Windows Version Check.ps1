Set-ExecutionPolicy Bypass -Scope Process -Force
$osver = Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object -ExpandProperty Caption
Write-Host "You have $osver!"
cscript //nologo "$env:WinDir\System32\slmgr.vbs" /dli | findstr "License"
pause >$null