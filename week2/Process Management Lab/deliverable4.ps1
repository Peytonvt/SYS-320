$chromePID = Get-Process -Name "chrome" -ErrorAction SilentlyContinue
if ($null -eq $chromePID) {
    Start-Process "chrome.exe" "http://www.champlain.edu"
} else {
    Stop-Process
}