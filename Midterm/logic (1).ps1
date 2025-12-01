# Challenge-1: Function to scrape IOC indicators from web page
function getIoc() {
    
    $webPage = Invoke-WebRequest -Uri "http://10.0.17.5/IOC.html" -TimeoutSec 2
    
    $tableRows = $webPage.ParsedHtml.body.GetElementsByTagName("tr")
    
    $iocData = @()
    
    for($index = 1; $index -lt $tableRows.length; $index++) {
        
        $cells = $tableRows[$index].getElementsByTagName("td")
        
        $iocEntry = [PSCustomObject]@{
            "Pattern"     = $cells[0].innerText
            "Description" = $cells[1].innerText
        }
        
        $iocData += $iocEntry
    }
    
    return $iocData 
}

function getApacheLogs() {

    $logPath = "C:\Users\champuser\SYS320-03\Midterm\access.log"
    $rawLogs = Get-Content -Path $logPath
    
    $parsedLogs = @()
    
    foreach($logEntry in $rawLogs) {

        $fields = $logEntry.Split(" ")
        
        $logRecord = [PSCustomObject]@{
            "IP"       = $fields[0]
            "Time"     = $fields[3].TrimStart('[')
            "Method"   = $fields[5].TrimStart('"')
            "Page"     = $fields[6]
            "Protocol" = $fields[7]
            "Response" = $fields[8]
            "Referrer" = $fields[10]
            "Client"   = $fields[11]
        }
        
        $parsedLogs += $logRecord
    }
    
    $filteredLogs = $parsedLogs | Where-Object { $_.IP -like "10.*" }
    
    return $filteredLogs
}

function getIndicator($logRecords, $iocPattern) {
    $matchingLogs = $logRecords | Where-Object { $_."Page" -like "*$iocPattern*" }
    
    return $matchingLogs
}
