# Usage: ./ip_active.sh 10.0.2
[ $# -ne 1 ] && echo "Usage: $0 <Prefix>" && exit 1

# Prefix is the first input taken
prefix=$1

# Verify input length
[ ${#prefix} -lt 5 ] && \
printf "Prefix length is too short\nPrefix example: 10.0.2\n" && \
exit 1

for i in {1..254}
do
	ping -c 1 $prefix$i | grep "64 bytes" | \
	grep -oE "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"
done
