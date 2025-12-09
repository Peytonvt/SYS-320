#!/bin/bash

report="report.txt"
path="/var/www/html/report.html"

echo "<html>" >> "$path"
echo "<head><title> HTML page for report.txt</title></head>" >> "$path"
echo "<body>" >> "$path"
echo "<table border= '1'>" >> "$path"
echo "<tr><th>IP Address</th><th>Date</th><th>IOC Flag</th></tr>" >> "$path"

while IFS= read -r line; do 
	ip=$(echo "$line" | awk '{print $1}')
	date=$(echo "$line" | awk '{print $2}' | tr -d '[]')
	flag=$(echo "$line" | cut -d' ' -f3-)

	echo "<tr><td>$ip</td><td>$date</td><td>$flag</td></tr>" >> "$path"
done < "$report"

echo "</table>" >> "$path"
echo "</body>" >> "$path"
echo "</html>" >> "$path"


