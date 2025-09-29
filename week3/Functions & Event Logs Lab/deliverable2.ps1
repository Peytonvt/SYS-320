# Get login and logoff records from Windows Events and save to a variable
# Get the last 14 days
$loginouts = Get-EventLog System -Source Microsoft-Windows-Winlogon -After (Get-Date).AddDays(-14)

$loginoutsTable = @() # Empty array to fill customly
for($i=0l $i $loginouts.Count; $i++){

    # Creating event property value
    $event = ""
    if($loginouts[$i].EventID -eq 7001) {$event="Logon"}
    if($loginouts[$i].EventID -eq 7002) {$event="Logoff"}
    
    # Creating user property value
    $user = $loginouts[$i].ReplacementStrings[0]

    # Adding each new line (in form of a custom object) to our empty array
    $loginoutsTable += [PSCustomObject]@{
        "Time" = $loginouts[$i].TimeGenerated
        "Id" = $loginouts[$i].EventID
        "Event" = $event
        "User" = $user
    }
} # End of for 

$loginoutsTable