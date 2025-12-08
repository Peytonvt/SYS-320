#!/bin/bash

# Function to count curl requests from different IP's
function curlCount() {
	# Path to logs
	log_file="/var/log/apache2/access.log"

	# Filter for curl agent, extract IP's, sort, and count unique IP's
	sudo cat "$log_file" | grep "curl" | cut -d ' ' -f 1 | sort | uniq -c | sort -rn
}

# Call Function
curlCount