function Get-ApacheLogIPs {
    param(
        [Parameter(Mandatory=$true)]
        [string]$LogPath,
        
        [Parameter(Mandatory=$true)]
        [string]$Webpage,
        
        [Parameter(Mandatory=$true)]
        [string]$HttpCode,
        
        [Parameter(Mandatory=$true)]
        [string]$Browser
    )
    
    $results = @()
    
    Get-Content $LogPath | ForEach-Object {
        $line = $_
        
        if ($line -match '^(\S+)\s+\S+\s+\S+\s+\[.*?\]\s+"(GET|POST|HEAD|PUT|DELETE|OPTIONS|PATCH)\s+([^\s]+)\s+HTTP/\d\.\d"\s+(\d+)\s+.*?"([^"]*)"$') {
            $ip = $matches[1]
            $httpMethod = $matches[2]
            $requestedPage = $matches[3]
            $statusCode = $matches[4]
            $userAgent = $matches[5]
            
            $pageMatch = $requestedPage -like "*$Webpage*"
            $codeMatch = $statusCode -eq $HttpCode
            $browserMatch = $userAgent -like "*$Browser*"
            
            if ($pageMatch -and $codeMatch -and $browserMatch) {
                $results += [PSCustomObject]@{
                    IP = $ip
                    Page = $requestedPage
                    HTTPCode = $statusCode
                    HTTPMethod = $httpMethod
                    Browser = $userAgent
                }
            }
        }
    }
    
    return $results
}