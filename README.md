Usage: ./check.sh [-p port] [-f ip_list.txt] | [IP PORT]

Options:
  -p PORT       Specify the port to check.
  -f FILE       Specify the file containing the list of IP addresses.
  -h            Show this help message.

Examples:
  ./check.sh -p 8080 -f ip_list.txt
  ./check.sh 192.168.1.1 8080
