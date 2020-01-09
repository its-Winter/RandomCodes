Set-ExecutionPolicy Bypass -Scope Process -Force
function prompt {'> '}
$host.ui.RawUI.WindowTitle = 'Counting your alpha packs!'
Set-Location $($env:HOMEDRIVE + $env:HOMEPATH + '\Documents')
New-Item -Name "Text Files" -ItemType Directory >$null
Set-Location "Text Files"
$totalfile = 'total.txt'
$commonfile = 'common.txt'
$uncommonfile = 'uncommon.txt'
$rarefile = 'rare.txt'
$epicfile = 'epic.txt'
$legendaryfile = 'legendary.txt'
if (*.txt) {
    $total = Get-Content total.txt
    $common = Get-Content common.txt
    $uncommon = Get-Content uncommon.txt
    $rare = Get-Content rare.txt
    $epic = Get-Content epic.txt
    $legendary = Get-Content legendary.txt
} else {
    [int]$total = 200
    [int]$common = 0
    [int]$uncommon = 0
    [int]$rare = 0
    [int]$epic = 0
    [int]$legendary = 0
    New-Item -Name $totalfile -Value $total -ItemType File 
    New-Item -Name $commonfile -Value $common -ItemType File 
    New-Item -Name $uncommonfile -Value $uncommon -ItemType File 
    New-Item -Name $rarefile -Value $rare -ItemType File 
    New-Item -Name $epicfile -Value $epic -ItemType File 
    New-Item -Name $legendaryfile -Value $legendary -ItemType File 
}
Clear-Host
function writeout {
    Set-Item -
}