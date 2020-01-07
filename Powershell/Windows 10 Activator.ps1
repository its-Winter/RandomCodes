#requires -runasadministrator
[string]$osversion = Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object -ExpandProperty Caption
[string]$slmgr = "$env:WinDir\System32\slmgr.vbs"
Write-Host @"
============================================================================
#Project: Activating Microsoft software products for FREE without software
============================================================================
\\\\\\ Version 2.1 //////
--Supported products--
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
Activating your Windows...
"@
cscript //nologo $slmgr /ckms >$null
cscript //nologo $slmgr /upk >$null
cscript //nologo $slmgr /cpky >$null
[int]$script:i = 1
switch -regex ($osversion) {
      enterprise {
            Write-Host "Windows Enterprise Found!"
	      cscript //nologo $slmgr /ipk NPPR9-FWDCX-D2C8J-H872K-2YT43 >$null
	      cscript //nologo $slmgr /ipk DPH2V-TTNVB-4X9Q3-TJR4H-KHJW4 >$null
	      cscript //nologo $slmgr /ipk WNMTR-4C88C-JK8YV-HQ7T2-76DF9 >$null
	      cscript //nologo $slmgr /ipk 2F77B-TNFGY-69QQF-B8YKP-D69TJ >$null
	      cscript //nologo $slmgr /ipk DCPHK-NFMTC-H88MJ-PFHPY-QJ4BJ >$null
            cscript //nologo $slmgr /ipk QFFDN-GRT3P-VKWWX-X7T3R-8B639 >$null
            break
      }
      home {
            Write-Host "Windows Home Found!"
	      cscript //nologo $slmgr /ipk TX9XD-98N7V-6WMQ6-BX7FG-H8Q99 >$null
	      cscript //nologo $slmgr /ipk 3KHY7-WNT83-DGQKR-F7HPR-844BM >$null
	      cscript //nologo $slmgr /ipk 7HNRX-D7KGG-3K4RQ-4WPJ4-YTDFH >$null
            cscript //nologo $slmgr /ipk PVMJN-6DFY6-9CCP6-7BKTT-D3WVR >$null
            break
      }
      education {
            Write-Host "Windows Education Found!"
	      cscript //nologo $slmgr /ipk NW6C2-QMPVW-D7KKK-3GKT6-VCFB2 >$null
            cscript //nologo $slmgr /ipk 2WH4N-8QGBV-H22JP-CT43Q-MDWWJ >$null
            break
      }
      pro {
            Write-Host "Windows Pro Found!"
	      cscript //nologo $slmgr /ipk W269N-WFGWX-YVC9B-4J6C9-T83GX >$null
            cscript //nologo $slmgr /ipk MH37W-N47XK-V7XM9-C7227-GCQG9 >$null
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
            [int]$i = 1,
            [string]$slmgr = "$env:WinDir\System32\slmgr.vbs"
      )
      switch ($i) {
            1 { [string]$KMServer = '193.29.63.133:1688'; break }
            2 { [string]$KMServer = '185.213.26.137:1688'; break }
      }
      cscript //nologo $slmgr /skms $KMServer >$null
}
Set-KMServer
Write-Host "============================================================================"
Invoke-Activation
function Invoke-Activation {
      [CmdletBinding()]
      param ([string]$slmgr = "$env:WinDir\System32\slmgr.vbs")
      cscript //nologo $slmgr /ato | findstr "successfully" >$null
      if ($? -eq $false) { 
            $i++
            Write-Warning "Activation Failed, Retrying..."
            Set-KMServer -i $i
            Invoke-Activation
      }
}