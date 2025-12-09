#!/bin/bash

# URL to scrape (my home server)
URL="http://192.168.1.20/Assignment.html"

# Fetch the webpage content
webpage=$(curl -s "$URL")

# Extract Temperature values
temperature=$(echo "$webpage" | awk '/<h2>The Temprature Read:<\/h2>/,/<h2>The Pressure Read:<\/h2>/' | grep -oP '(?<=<td>)[^<]+(?=</td>)' | awk 'NR % 2 == 1')

# Extract Pressure values
pressure=$(echo "$webpage" | awk '/<h2>The Pressure Read:<\/h2>/,/<\/body>/' | grep -oP '(?<=<td>)[^<]+(?=</td>)' | awk 'NR % 2 == 1')

# Extract Date and Time values from first table
datetime=$(echo "$webpage" | awk '/<h2>The Temprature Read:<\/h2>/,/<h2>The Pressure Read:<\/h2>/' | grep -oP '(?<=<td>)[^<]+(?=</td>)' | awk 'NR % 2 == 0')

# Count number of lines
num_lines=$(echo "$pressure" | wc -l)

# Loop through and print merged data
for i in $(seq 1 $num_lines); do
    press=$(echo "$pressure" | head -n $i | tail -n 1)
    temp=$(echo "$temperature" | head -n $i | tail -n 1)
    date=$(echo "$datetime" | head -n $i | tail -n 1)
    echo "$press $temp $date"
done
