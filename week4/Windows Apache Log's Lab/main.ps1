. (Join-Path $PSScriptRoot Apache-Logs.ps1)

$results = Get-ApacheLogIPs -LogPath "C:\xampp\apache\logs\access.log" -Webpage "index.html" -HttpCode "200" -Browser "Chrome"

$grouped = $results | Group-Object -Property IP
$output = $grouped | ForEach-Object {
    [PSCustomObject]@{
        Count = $_.Count
        IP = $_.Name
        Page = ($_.Group | Select-Object -First 1).Page
        HTTPCode = ($_.Group | Select-Object -First 1).HTTPCode
        HTTPMethod = ($_.Group | Select-Object -First 1).HTTPMethod
        Browser = ($_.Group | Select-Object -First 1).Browser
    }
}

$output | Format-Table -AutoSize
$tableRecords | Format-Table -AutoSize -Wrap 