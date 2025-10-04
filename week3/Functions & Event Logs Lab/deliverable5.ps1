function Get-StartShutdownTable {
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
Get-StartShutdownTable -Days 14