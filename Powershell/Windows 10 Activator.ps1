If (([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator) -eq $false) {
      Start-Process powershell.exe -Argumentlist "-File", ('"{0}"' -f $MyInvocation.MyCommand.Source) -Verb RunAs
}
Clear-Host
[string]$osversion = Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object -ExpandProperty Caption
[string]$slmgr = "$env:WinDir\System32\slmgr.vbs"
Write-Host @"
============================================================================
#Project: Activating Microsoft software products for FREE without software
============================================================================
\\\ Version 2.2 - Powershell Edition ///
-----------Supported products-----------
Windows 10 Home
Windows 10 Home N
Windows 10 Home Single Language
Windows 10 Home Country Specific
Windows 10 Professional
Windows 10 Professional N
Windows 10 Education
Windows 10 Education N
Windows 10 Enterprise
Windows 10 Enterprise N
Windows 10 Enterprise LTSB
Windows 10 Enterprise LTSB N
============================================================================
"@
cscript //nologo $slmgr /ckms | Out-Null
cscript //nologo $slmgr /upk | Out-Null
cscript //nologo $slmgr /cpky | Out-Null
[int]$i = 1
switch -regex ($osversion) {
      enterprise {
            Write-Host "Windows Enterprise Found!"
	      cscript //nologo $slmgr /ipk NPPR9-FWDCX-D2C8J-H872K-2YT43 | Out-Null
	      cscript //nologo $slmgr /ipk DPH2V-TTNVB-4X9Q3-TJR4H-KHJW4 | Out-Null
	      cscript //nologo $slmgr /ipk WNMTR-4C88C-JK8YV-HQ7T2-76DF9 | Out-Null
	      cscript //nologo $slmgr /ipk 2F77B-TNFGY-69QQF-B8YKP-D69TJ | Out-Null
	      cscript //nologo $slmgr /ipk DCPHK-NFMTC-H88MJ-PFHPY-QJ4BJ | Out-Null
            cscript //nologo $slmgr /ipk QFFDN-GRT3P-VKWWX-X7T3R-8B639 | Out-Null
            break
      }
      home {
            Write-Host "Windows Home Found!"
	      cscript //nologo $slmgr /ipk TX9XD-98N7V-6WMQ6-BX7FG-H8Q99 | Out-Null
	      cscript //nologo $slmgr /ipk 3KHY7-WNT83-DGQKR-F7HPR-844BM | Out-Null
	      cscript //nologo $slmgr /ipk 7HNRX-D7KGG-3K4RQ-4WPJ4-YTDFH | Out-Null
            cscript //nologo $slmgr /ipk PVMJN-6DFY6-9CCP6-7BKTT-D3WVR | Out-Null
            break
      }
      education {
            Write-Host "Windows Education Found!"
	      cscript //nologo $slmgr /ipk NW6C2-QMPVW-D7KKK-3GKT6-VCFB2 | Out-Null
            cscript //nologo $slmgr /ipk 2WH4N-8QGBV-H22JP-CT43Q-MDWWJ | Out-Null
            break
      }
      pro {
            Write-Host "Windows Pro Found!"
	      cscript //nologo $slmgr /ipk W269N-WFGWX-YVC9B-4J6C9-T83GX | Out-Null
            cscript //nologo $slmgr /ipk MH37W-N47XK-V7XM9-C7227-GCQG9 | Out-Null
            break
      }
      default {
            Write-Warning "Your version: $osversion, is not supported!"
            Exit-PSSession
      }
}
function Set-KMServer {
      [CmdletBinding()]
      param (
            [int]$i,
            [string]$slmgr = "$env:WinDir\System32\slmgr.vbs"
      )
      switch ($i) {
            1 { [string]$KMServer = '193.29.63.133:1688'; break }
            2 { [string]$KMServer = '185.213.26.137:1688'; break }
      }
      cscript //nologo $slmgr /skms $KMServer | Out-Null
}
function Invoke-Activation {
      [CmdletBinding()]
      param (
            [string]$slmgr = "$env:WinDir\System32\slmgr.vbs",
            [string]$WinEdition      
      )
      cscript //nologo $slmgr /ato | findstr "successfully" | Out-Null
      switch ($?) {
            $false { 
                  Write-Warning "Activation Failed, Retrying..."
                  Set-KMServer -i 2
                  Invoke-Activation -WinEdition $WinEdition
            }
            $true {
                  Write-Host "$WinEdition Activated Successfully!"
                  Write-Host "Press any key to end script."
                  Pause >$null
                  Exit-PSSession
            }
            Default {
                  Write-Host "Contact me on Discord at its.winter#6512 for support: you really shouldn't recieve this message."
                  Exit-PSSession
            }
      }
}
Write-Host "Activating your windows..."
Set-KMServer -i 1
Write-Host "============================================================================"
Invoke-Activation -WinEdition $osversion
Exit-PSSession