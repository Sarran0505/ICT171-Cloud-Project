#!/bin/bash

echo "List of open ports on the server:"
echo "- - - - - - - - - - - - - - - - - - - - - "
sudo netstat -tulnp
echo
echo "- - - - - - - - - - - - - - - - - - - - - "
echo "Checking for suspicious ports..."


EXPECTED_PORTS="22 80 443"
OPEN_PORTS=$(sudo netstat -tuln | grep LISTEN | awk '{print $4}' | sed 's/.*://')

echo "Expected ports: $EXPECTED_PORTS"
echo "Open ports    : $OPEN_PORTS"

echo
for port in $OPEN_PORTS; do
  if [[ "$EXPECTED_PORTS" =~ "$port" ]]; then
    echo "🎉 Port $port : OK (expected)"
  else
    echo "❌ Port $port : suspicious or unexpected!"
  fi
done

