#requires -version 3
[System.Console]::Title = 'Counting your alpha packs!'
Set-Location $((Join-Path $env:HOMEDRIVE $env:HOMEPATH) + '\Documents')
try { Set-Location "Rainbow.AlphaPacks" }
catch { New-Item -Name "Rainbow.AlphaPacks" -ItemType Directory; Set-Location "Rainbow.AlphaPacks" }
[string]$totalfile = 'total.txt'
[string]$commonfile = 'common.txt'
[string]$uncommonfile = 'uncommon.txt'
[string]$rarefile = 'rare.txt'
[string]$epicfile = 'epic.txt'
[string]$legendaryfile = 'legendary.txt'
if (Get-ChildItem *.txt) {
      try { $total = Get-Content $totalfile }
      catch { [int]$total = 200 }
      try { $common = Get-Content $commonfile }
      catch { [int]$common = 0 }
      try { $uncommon = Get-Content $uncommonfile }
      catch { [int]$uncommon = 0 }
      try { $rare = Get-Content $rarefile }
      catch { [int]$rare = 0 }
      try { $epic = Get-Content epic.txt }
      catch { [int]$epic = 0 }
      try { $legendary = Get-Content legendary.txt }
      catch { [int]$legendary = 0 }
}
else {
      New-Item -Name $totalfile -Value $total -ItemType File 
      New-Item -Name $commonfile -Value $common -ItemType File 
      New-Item -Name $uncommonfile -Value $uncommon -ItemType File 
      New-Item -Name $rarefile -Value $rare -ItemType File 
      New-Item -Name $epicfile -Value $epic -ItemType File 
      New-Item -Name $legendaryfile -Value $legendary -ItemType File 
}


[hashtable]$filenames = @{
      'total.txt'     = $(try { Get-Content 'total.txt' } catch { Write-Host "0" })
      'common.txt'    = 0
      'uncommon.txt'  = 0
      'rare.txt'      = 0
      'epic.txt'      = 0
      'legendary.txt' = 0
}
[hashtable]$stuff = Get-ChildItem -Recurse *.txt -File