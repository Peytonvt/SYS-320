#clear
clear

#Get DNS Server IPs and display only the first one
(Get-DnsClientServerAddress -AddressFamily IPv4).ServerAddresses | Select-Object -First 1