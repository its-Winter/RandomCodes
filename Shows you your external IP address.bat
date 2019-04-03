@echo off
echo This is your external IPv4 address
curl -4 "ifconfig.co"
echo ___________________________________
echo.
echo This is your external IPv6 address only if full duplex is enabled on your network else this will not resolve host
curl -6 "ifconfig.co"
pause >nul
