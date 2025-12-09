#!/bin/bash

# Define the log file path
log_file="/home/champuser/Desktop/SYS-320/week12/fileaccesslog.txt"
email_log="/home/champuser/Desktop/SYS-320/week12/email_sent.txt"ffffffffffff

# Get current timestamp
timestamp=$(date "+%a %b %d %H-%M-%S %p %Z %Y")

# Log the access event
echo "File was accessed $timestamp" >> "$log_file"

mail -s "Access" peyton.pajak-leavy@mymail.champlain.edu < "$log_file" 2>&1 >> "$email_log"
