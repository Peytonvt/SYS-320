#!/bin/bash

# Function will count page access within Apache Logs
function pageCount() {
	# Path to Logs
	log_file="/var/log/apache2/access.log"
	
	# Extract page names, sort, and count
	sudo cat "$log_file" | cut -d ' ' -f 7 | sort | uniq -c | sort -rn
}

# Call Function
pageCount