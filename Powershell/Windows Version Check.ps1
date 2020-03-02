Set-ExecutionPolicy Bypass -Scope Process -Force
$osver = Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object -ExpandProperty Caption
Write-Host ("You have {0}!" -f $osver)
cscript //nologo ("{0}\System32\slmgr.vbs" -f $env:WinDir) /dli | findstr "License"
Pause