#Clear
clear

#Get DHCP Server IP and Hide the Table Headers
Get-CimInstance Win32_NetworkAdapterConfiguration -Filter "DHCPEnabled=$true" | Select DHCPServer | Format-Table -HideTableHeaders