#!/bin/bash

inputReport="report.txt"
outputHTML="/var/www/html/report.html"

# Check if report exists
if [ ! -f "$inputReport" ]; then
    echo "Error: $inputReport not found"
    exit 1
fi

# Create local copy if can't write to web directory
if [ ! -w "/var/www/html" ] 2>/dev/null; then
    outputHTML="report.html"
fi

# HTML header
echo "<html>" > "$outputHTML"
echo "<head>" >> "$outputHTML"
echo "    <title>Access Logs with IOC Indicators</title>" >> "$outputHTML"
echo "</head>" >> "$outputHTML"
echo "<body>" >> "$outputHTML"
echo "    <h1>Access logs with IOC indicators:</h1>" >> "$outputHTML"
echo "    <table border='1'>" >> "$outputHTML"

# Table header
echo "        <tr>" >> "$outputHTML"
echo "            <th>IP Address</th>" >> "$outputHTML"
echo "            <th>Date</th>" >> "$outputHTML"
echo "            <th>IOC Flag</th>" >> "$outputHTML"
echo "        </tr>" >> "$outputHTML"

# Process each log entry
while IFS= read -r line; do
    ipAddr=$(echo "$line" | awk '{print $1}')
    dateTime=$(echo "$line" | awk '{print $2}' | tr -d '[]')
    iocFlag=$(echo "$line" | cut -d' ' -f3-)
    
    echo "        <tr>" >> "$outputHTML"
    echo "            <td>$ipAddr</td>" >> "$outputHTML"
    echo "            <td>$dateTime</td>" >> "$outputHTML"
    echo "            <td>$iocFlag</td>" >> "$outputHTML"
    echo "        </tr>" >> "$outputHTML"
done < "$inputReport"

# HTML footer
echo "    </table>" >> "$outputHTML"
echo "</body>" >> "$outputHTML"
echo "</html>" >> "$outputHTML"

# Try to move to web directory
if [ "$outputHTML" = "report.html" ]; then
    sudo mv report.html /var/www/html/report.html 2>/dev/null
    if [ $? -eq 0 ]; then
        echo "HTML report created at /var/www/html/report.html"
    else
        echo "HTML report created as report.html"
    fi
else
    echo "HTML report created at $outputHTML"
fi
