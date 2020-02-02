$originaltitle = $host.UI.RawUI.WindowTitle
$host.ui.rawui.WindowTitle = "Finding Host Names..."
$userinfo = (Invoke-RestMethod -UseBasicParsing -Uri https://ifconfig.co -Headers @{
	Accept = 'application/json'
})
Write-Host @"
External IP: $($userinfo.ip)
Country: $($userinfo.country)
City: $($userinfo.city)
-----User Agent-----
Service: $($userinfo.user_agent.product)
Service Version: $($userinfo.user_agent.version)
Full Service: $($userinfo.user_agent.comment)
"@
$host.ui.RawUI.WindowTitle = $originaltitle
Pause