#!/bin/bash

# Usage: ./checkport.sh -p port -f ip_list.txt
#        ./checkport.sh IP PORT

show_help() {
  echo "Usage: $0 [-p port] [-f ip_list.txt] | [IP PORT]"
  echo
  echo "Options:"
  echo "  -p PORT       Specify the port to check."
  echo "  -f FILE       Specify the file containing the list of IP addresses."
  echo "  -h            Show this help message."
  echo
  echo "Examples:"
  echo "  $0 -p 8080 -f ip_list.txt"
  echo "  $0 192.168.1.1 8080"
}

check_port() {
  local IP=$1
  local PORT=$2
  OUTPUT=$(echo quit | timeout 5 telnet $IP $PORT 2>&1)
  if [[ $OUTPUT == *"Connected"* ]]; then
    echo "$IP:$PORT 端口开放"
  else
    echo "$IP:$PORT 端口关闭"
  fi
}

if [[ $1 == "-h" ]]; then
  show_help
  exit 0
fi

if [[ $# -eq 2 ]]; then
  check_port $1 $2
  exit 0
fi

while getopts "p:f:h" opt; do
  case $opt in
    p) PORT=$OPTARG ;;
    f) FILE=$OPTARG ;;
    h) show_help; exit 0 ;;
    *) show_help; exit 1 ;;
  esac
done

if [ -z "$PORT" ] || [ -z "$FILE" ]; then
  show_help
  exit 1
fi

while IFS= read -r IP; do
  check_port $IP $PORT
done < "$FILE"
