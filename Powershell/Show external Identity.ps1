[string]$originaltitle = $host.UI.RawUI.WindowTitle
$host.ui.rawui.WindowTitle = "Finding Host Names..."
$userinfo = (Invoke-RestMethod -UseBasicParsing -Uri https://ifconfig.co -Headers @{
	Accept = 'application/json'
})
[array]$formatthings = @(
	$userinfo.ip
	$userinfo.country
	$userinfo.city
	$userinfo.user_agent.product
	$userinfo.user_agent.version
	$userinfo.user_agent.comment
)
Write-Host (@"
External IP: {0}
Country: {1}
City: {2}
-----User Agent-----
Service: {3}
Service Version: {4}
Full Service: {5}
"@ -f $formatthings)
$host.ui.RawUI.WindowTitle = $originaltitle
Pause