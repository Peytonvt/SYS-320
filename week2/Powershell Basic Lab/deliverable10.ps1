#clear
clear

cd $PSScriptRoot
$files= Get-ChildItem

$folderpath = "$PSScriptRoot/outfolder/"
$filePath = Join-Path $folderpath "out.csv"

#List all the files that has the extension ".ps1" and
#Save Results to out.csv file

$files | Where-Object {$_.Extension -eq ".ps1"} |
Export-Csv -Path $filepath