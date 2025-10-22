# Display only log that contain 404 (Not Found) or 400 (Bad Request)
Get-Content C:\xampp\apache\logs\access.log | Select-String '404','400'
