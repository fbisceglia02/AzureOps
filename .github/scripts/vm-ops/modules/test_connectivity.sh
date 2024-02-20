#!/bin/bash

echo "test_connectivity script started"

# Verify IP address in namespace red
ip netns exec red ip addr show veth-red

# Verify IP address in namespace blue
ip netns exec blue ip addr show veth-blue

for i in {8..1}; do echo "test for connectivity will start in $i seconds"; sleep 1; done
echo "Starting test for connectivity now."

# Ping from red to blue
ip netns exec red ping -c 3 192.168.15.2

# Ping from blue to red
ip netns exec blue ping -c 3 192.168.15.1

echo "test_connectivity script ended"
