[string]$pyversion = (-split $(py -3 -V))[-1]
if (!$pyversion) { [string]$pyversion = (-split $(py -V))[-1] }
switch -Wildcard ($pyversion) {
    3.7.0 { Write-Warning 'You have a version older than 3.7 and it is required to update.' }
    3.8.[0-9] { Write-Output 'You have the latest version of python!' }
    default { Write-Output 'You do not have python installed.' }
}
Pause