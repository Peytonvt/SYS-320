#clear
clear

#Choose a dir where you have some .ps1 files
cd C:\Users\champuser\SYS-320\week2

#List files based on the file name
$files=(Get-ChildItem)

for ($j=0; $j -le $files.count; $j++){

    if ($files[$j].name -ilike "*ps1"){
        Write-Host $files[$j].name;
    }
}