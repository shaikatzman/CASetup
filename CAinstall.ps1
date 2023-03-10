
Write-Host "installing and configuring CA server on JBH-DC1" -ForegroundColor Yellow
Install-WindowsFeature -Name ADCS-Cert-Authority,ADCS-Web-Enrollment -IncludeManagementTools -IncludeAllSubFeature
Install-AdcsCertificationAuthority -CAType EnterpriseRootCA -CACommonName "JBH-RootCA" -Force
Install-AdcsWebEnrollment -Force
Add-DnsServerResourceRecordA -Name "crl" -ZoneName "JBH.Local" -AllowUpdateAny -IPv4Address "172.16.1.1" -TimeToLive 01:00:00
Invoke-Command -ComputerName HQ-DC1,HQ-SVR2,RTR,HQ-CL1 -ScriptBlock {gpupdate /force}
Write-Host " Success Configured CA server on JBH-DC1" -ForegroundColor Green
pause
