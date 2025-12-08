# Script to extract IP addresses and page names from Apache logs per page

# Apache Log Path
log_file="/var/log/apache2/access.log"

# Filter for page2
cat "$log_file" | grep "page2.html" | cut -d ' ' -f 1,7 | tr -s ' '