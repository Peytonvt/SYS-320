#Show what classes there is of Win32 library that starts with Net, sort alphabetically
Get-WmiObject -List | Where-Object { $_.Name -ilike "Win32_NetworkAdapter*" } | Sort-Object