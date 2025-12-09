#!/bin/bash

# This script gets the IP from the <ip addr> output

ip addr | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | grep -v '127.0.0.1' | head -n 1
