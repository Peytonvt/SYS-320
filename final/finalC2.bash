#!/bin/bash

# Check arguments
if [ $# -ne 2 ]; then
    echo "Usage: $0 <logfile> <iocfile>"
    exit 1
fi

logFile="$1"
iocFile="$2"

# Validate files exist
if [ ! -f "$logFile" ]; then
    echo "Error: Log file '$logFile' not found"
    exit 1
fi

if [ ! -f "$iocFile" ]; then
    echo "Error: IOC file '$iocFile' not found"
    exit 1
fi

# Search logs and extract fields
grep -Ff "$iocFile" "$logFile" | \
    awk '{print $1, $4, $7}' > report.txt

echo "Report has been generated and saved to report.txt"
echo "Found $(wc -l < report.txt) log entries matching IOC indicators"
