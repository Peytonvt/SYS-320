#!/bin/bash

url="192.168.1.20/IOC.html"

# Fetch web page
pageContent=$(curl -sL "$url")

# Parse and clean IOC indicators
echo "$pageContent" | \
    grep -o '<td>[^<]*</td>' | \
    sed 's/<td>//g' | \
    sed 's/<\/td>//g' | \
    sed 's/&#13;//g' | \
    sed '/^$/d' | \
    awk 'NR % 2 == 1' > IOC.txt

echo "IOC indicators have been saved to IOC.txt"
