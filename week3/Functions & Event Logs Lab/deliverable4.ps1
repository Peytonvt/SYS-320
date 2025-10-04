function Get-LoginLogoffTable {
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
Get-LoginLogoffTable -Days 14