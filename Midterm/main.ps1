. (Join-Path $PSScriptRoot logic.ps1)

#$fullTable = getIoc
#$fullTable | Select-Object "Pattern", "Description" | Format-Table

# Challenge-2: Parse Apache access logs
#$tableRecords = getApacheLogs
#$tableRecords | Format-Table -AutoSize -Wrap

# Challenge-3: Search logs for specific IOC indicator
#$indicator = getIndicator $tableRecords "cmd="
#$indicator | Format-Table -Autosize -Wrap
