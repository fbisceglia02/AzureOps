#!/bin/bash

echo "assign ip and retest connectivity script started"

echo "assigning ip addresses"
echo "Logging IP address assignment for veth-red in namespace red"
ip netns exec red ip addr add 192.168.15.1/24 dev veth-red

echo "Logging IP address assignment for veth-blue in namespace blue"
ip netns exec blue ip addr add 192.168.15.2/24 dev veth-blue

echo "Logging IP address assignment for veth-orange in namespace orange"
ip netns exec orange ip addr add 192.168.15.3/24 dev veth-orange

echo "Logging IP address assignment for veth-gray in namespace gray"
ip netns exec gray ip addr add 192.168.15.4/24 dev veth-gray

echo "Turning devices up for all namespaces"
# Turn veth-red up in namespace red
ip netns exec red ip link set veth-red up && echo "Turned veth-red up in namespace red"

# Turn veth-blue up in namespace blue
ip netns exec blue ip link set veth-blue up && echo "Turned veth-blue up in namespace blue"

# Turn veth-orange up in namespace orange
ip netns exec orange ip link set veth-orange up && echo "Turned veth-orange up in namespace orange"

# Turn veth-gray up in namespace gray
ip netns exec gray ip link set veth-gray up && echo "Turned veth-gray up in namespace gray"

# adding ip address to v-net-0
echo "assigning ip address to v-net-0"
ip addr add 192.168.15.5/24 dev v-net-0

for i in {8..1}; do echo "test for connectivity between host and namespaces interfaces will start in $i seconds"; sleep 1; done
echo "Starting test for connectivity now."

# Ping from host to namespace red
echo "Pinging namespace red from the host"
ping -c 3 192.168.15.1
# Ping from host to namespace blue
echo "Pinging namespace blue from the host"
ping -c 3 192.168.15.2
# Ping from host to namespace orange
echo "Pinging namespace orange from the host"
ping -c 3 192.168.15.3
# Ping from host to namespace gray
echo "Pinging namespace gray from the host"
ping -c 3 192.168.15.4


echo "assign ip and retest connectivity script ended"
