#!/bin/bash
# Curl Loop Script
# Access a web page 20 times via curl

# Loop (20 times)
for i in {1..20}
do 
	curl http://10.0.2.15/index.html
done