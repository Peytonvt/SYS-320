#!/bin/bash

IOC="IOC.txt"
LOG="access.log"

grep -Ff "$IOC" "$LOG" | \
	awk '{print $1, $4, $7}' > report.txt


