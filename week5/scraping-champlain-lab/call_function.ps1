. (Join-Path $PSScriptRoot scraping_champlain_script.ps1)

$FullTable = daysTranslator($output)

# Gather Classes
$output = gatherClasses

# List all the classes of Instructor Furkin Paligu
$FullTable | Select-Object "Class Code", Instructor, Location, Days, "Time Start", "Time End" | `
Where-Object { $_."Instructor" -ilike "Furkan Paligu"}

# List all the classes of JOYCE 310 on Mondays, only display Class Code and Times
# Sort by Start Time
$FullTable | Where-Object { ( $_.Location -ilike "JOYC 310") -and ($_.Days -match "Monday") } | `
             Sort-Object "Time Start" | `
             Select-Object "Time Start", "Time End", "Class Code"

# Make a list of all the instructors that teach at least 1 course in
# SYS, SEC, NET, FOR, CSI, DAT
# sort by name, and make it unique
$ITSInstuctors = $FullTable | Where-Object { ($_."Class Code" -match "SYS*") -or `
                                             ($_."Class Code" -match "NET*") -or `
                                             ($_."Class Code" -match "SEC*") -or `
                                             ($_."Class Code" -match "FOR*") -or `
                                             ($_."Class Code" -match "CSI*") -or `
                                             ($_."Class Code" -match "DAT*") } |
                                             Select-Object "Instructor" | `
                                             Sort-Object "Instructor" -Unique
$ITSInstuctors

#Group All the Instructors by the number of classes they are teaching
$FullTable | Where-Object { $_.Instructor -in $ITSInstuctors.Instructor} | `
Group-Object "Instructor" | Select-Object Count, Name | Sort-Object Count -Descending