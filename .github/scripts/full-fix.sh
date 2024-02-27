#!/bin/bash

echo "Script started"

# Create namespaces
echo "creating first namespaces"
ip netns add red && echo "Namespace red created"
ip netns add blue && echo "Namespace blue created"
ip netns add orange && echo "Namespace orange created"
ip netns add gray && echo "Namespace gray created"

# Create veth pairs and link them to namespaces
echo "creating veth pairs and linking them to namespaces"
ip link add veth-red type veth peer name veth-red-br
ip link add veth-blue type veth peer name veth-blue-br
ip link add veth-orange type veth peer name veth-orange-br
ip link add veth-gray type veth peer name veth-gray-br

ip link set veth-red netns red
ip link set veth-blue netns blue
ip link set veth-orange netns orange
ip link set veth-gray netns gray

# Create a bridge and attach veth pairs
echo "adding bridge interface and attaching veth pairs"
ip link add v-net-0 type bridge
ip link set veth-red-br master v-net-0
ip link set veth-blue-br master v-net-0
ip link set veth-orange-br master v-net-0
ip link set veth-gray-br master v-net-0
ip link set dev v-net-0 up

# Assign IP addresses
echo "assigning IP addresses"
ip -n red addr add 192.168.15.1/24 dev veth-red
ip -n blue addr add 192.168.15.2/24 dev veth-blue
ip -n orange addr add 192.168.15.3/24 dev veth-orange
ip -n gray addr add 192.168.15.4/24 dev veth-gray
ip addr add 192.168.15.5/24 dev v-net-0

# Bring interfaces up
echo "bringing interfaces up"
ip -n red link set veth-red up
ip -n red link set lo up
ip -n blue link set veth-blue up
ip -n blue link set lo up
ip -n orange link set veth-orange up
ip -n orange link set lo up
ip -n gray link set veth-gray up
ip -n gray link set lo up
ip link set veth-red-br up
ip link set veth-blue-br up
ip link set veth-orange-br up
ip link set veth-gray-br up

# Enable IP forwarding and disable reverse path filtering
echo "enabling IP forwarding and disabling reverse path filtering"
sysctl -w net.ipv4.ip_forward=1
sysctl -w net.ipv4.conf.all.rp_filter=0
sysctl -w net.ipv4.conf.default.rp_filter=0

# Test connectivity
echo "testing connectivity"
for i in {3..1}; do echo "test for connectivity will start in $i seconds"; sleep 1; done
echo "Pinging from red to blue"
ip netns exec red ping -c 3 192.168.15.2
echo "Pinging from orange to gray"
ip netns exec orange ping -c 3 192.168.15.4

# Continuing from the last command...

# Ping from host to each namespace
echo "Pinging each namespace from the host"
ping -c 3 192.168.15.1
ping -c 3 192.168.15.2
ping -c 3 192.168.15.3
ping -c 3 192.168.15.4

echo "Script completed"
