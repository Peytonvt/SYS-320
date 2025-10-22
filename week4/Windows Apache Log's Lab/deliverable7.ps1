# Get only logs that contain 404, save into $notfounds
$notfounds = Get-Content c:\xampp\apache\logs\access.log | Select-String ' 404 '

# Define a regex for IP addresses
$regex = [regex] "\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b"

# Get $notfounds records that match to the regex
$ipsunorganized = $regex.Matches($notfounds)

# Get ips as pscustomobject
$ips = @()
for($i=0; $i -lt $ipsunorganized.Count; $i++){
    $ips += [pscustomobject]@{ "IP" = $ipsunorganized[$i].Value; }
}
$ips | Where-object { $_.IP -ilike "10.*" }
