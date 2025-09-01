# Clear
clear

# Get IPv4 PrefixLength from Ethernet0 Interface
(Get-NetIPAddress -AddressFamily IPv4 | Where-Object {
$_.InterfaceAlias -ilike "Ethernet" }).PrefixLength