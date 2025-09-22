# Without changing dir find
# every .csv file and change their ext to .log
# Display all the files

$files=Get-ChildItem -Recurse -File -Filter *.csv
$files | Rename-Item -Newname { $_.Name -replace '.csv', '.log' } 
Get-ChildItem -Recurse -File