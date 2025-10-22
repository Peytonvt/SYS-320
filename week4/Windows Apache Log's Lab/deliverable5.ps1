# Display only logs that do NOT contain 200 (OK)
Get-Content C:\xampp\apache\logs\access.log | Select-String ' 200 ' -NotMatch