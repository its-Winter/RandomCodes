[version]$pythonVersion = (-split $(py -3 -V))[-1]
if (-not $pythonVersion) { [version]$pythonVersion = (-split $(python -V))[-1] }
if (-not $pythonVersion) {
      Write-Host "You do not have python installed."
}
elseif ($pythonVersion -lt 3.8.1) {
	Write-Host "You have Python $pythonVersion Installed."
}
elseif ($pythonVersion -eq 3.8.1) {
	Write-Host "You have the latest version of Python!
	Python $pythonVersion"
}
Pause