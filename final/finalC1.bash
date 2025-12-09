#!/bin/bash

url="10.0.17.47/IOC.html"

# Fetch web page
pageContent=$(curl -sL "$url")

# Extract table data
tableData=$(echo "$pageContent" | \
    xmlstarlet format --html --recover 2>/dev/null | \
    xmlstarlet select --template --copy-of "//table//tr")

# Parse and clean IOC indicators
echo "$tableData" | \
    sed -n 's|<td>\(.*\)</td>|\1|p' | \
    sed 's/&#13;//g' | \
    sed 's/^[[:space:]]*//' | \
    awk 'NR % 2 == 1' > IOC.txt

echo "IOC indicators have been saved to IOC.txt"
