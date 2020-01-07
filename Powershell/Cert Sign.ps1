#requires -runasadministrator
Write-Output "Setting function 'New-CertSigniture'"
function New-CertSigniture {
    [CmdletBinding()]
    <#
.SYNOPSIS
    This Function will create a certificate and sign a script or file with the certificate created.

.PARAMETER password
    The parameter password is used with a string that you want the certificate password to be.

.PARAMETER name
    The parameter name is used with a string that you want to name the certificate.

.EXAMPLE
    This shows a basic usage of the function to create a certificate and assign it to 'myscript.ps1'
    PS C:\> New-CertSign myscript.ps1 -password "my super secret password" -name "pro certificate"

.NOTES
    Author: its.winter
    Last Edit: 12-30-2019

#>
    param (
        [Parameter(Mandatory=$true)]
        [string]$password = "password",
        [string]$name = "Signing Certificate"
    )
    ConvertTo-SecureString -String "$password" -Force -AsPlainText
    $certpath = "$env:userprofile\Desktop\$($name + ".pfx")"
    New-SelfSignedCertificate -subject ("$name" + ".pfx") -Type CodeSigningCert -FriendlyName SelfSignedCert | Export-PfxCertificate -FilePath $certpath -password $pass
    Write-Output "Type in the password you used to originally run the function."
    $certcontent = Get-PfxCertificate -FilePath "$certpath"
    Set-AuthenticodeSignature -PSPath $args[0] -Certificate $certcontent
}
Write-Host "Type the password for the certificate you want to use"