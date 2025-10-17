# Join path with functions to be called.
. (Join-Path $PSScriptRoot deliverable4.ps1)

# Clear the page
clear

# Get Login and Logoffs from the last 15 days. 
 $StartShutdownTable = LoginLogoffTable 15
 $StartShutdownTable

# Get Starts and Stops from the last 25 days. 
$StartStopTable = StartStopTable 25
$StartStopTable
