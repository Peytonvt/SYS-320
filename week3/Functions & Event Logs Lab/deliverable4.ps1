function LoginLogoffTable {
    param(
        [int]$Days
    )
    
    # Get login and logoff records from Windows Events and save to a variable
    $loginouts = Get-EventLog System -source Microsoft-Windows-Winlogon -After (Get-Date).AddDays(-$Days)
    
    $loginoutsTable = @() # Empty array to fill customly
    for($i=0; $i -lt $loginouts.Count; $i++){
        # Creating event property value
        $event = ""
        if($loginouts[$i].InstanceId -eq 7001) {$event="Logon"}
        if($loginouts[$i].InstanceId -eq 7002) {$event="Logoff"}
        
        # Creating user property value - Translate SID to Username
        $sid = New-Object System.Security.Principal.SecurityIdentifier($loginouts[$i].ReplacementStrings[1])
        $user = $sid.Translate([System.Security.Principal.NTAccount]).Value
        
        # Adding each new line (in form of a custom object) to our empty array
        $loginoutsTable += [pscustomobject]@{"Time" = $loginouts[$i].TimeGenerated;
                                             "Id" = $loginouts[$i].EventID;
                                             "Event" = $event;
                                             "User" = $user;
                                            }
    } # End for loop
    
    return $loginoutsTable
}

# Call the function with 14 days parameter and display results
LoginLogoffTable -Days 14

function StartStopTable {
    param(
        [int]$Days
    )
    
    # Get start and shutdown records from Windows Events
    # EventId 6005 = System Start, EventId 6006 = System Shutdown
    $systemEvents = Get-EventLog System -After (Get-Date).AddDays(-$Days) | Where-Object {$_.EventID -eq 6005 -or $_.EventID -eq 6006}
    
    $systemEventsTable = @() # Empty array to fill customly
    for($i=0; $i -lt $systemEvents.Count; $i++){
        # Creating event property value
        $event = ""
        if($systemEvents[$i].EventID -eq 6005) {$event="Start"}
        if($systemEvents[$i].EventID -eq 6006) {$event="Shutdown"}
        
        # User is always System for these events
        $user = "System"
        
        # Adding each new line (in form of a custom object) to our empty array
        $systemEventsTable += [pscustomobject]@{"Time" = $systemEvents[$i].TimeGenerated;
                                                 "Id" = $systemEvents[$i].EventID;
                                                 "Event" = $event;
                                                 "User" = $user;
                                                }
    } # End for loop
    
    return $systemEventsTable
}

# Call the function with 14 days parameter and display results
StartStopTable -Days 14