#!/bin/bash

echo "Script setup_namespaces_veth started"

# Create namespaces
echo "creating first namespaces"
ip netns add red && echo "Namespace red created"
ip netns add blue && echo "Namespace blue created"

# Create veth pair
echo "creating veth pair"
ip link add veth-red type veth peer name veth-blue && echo "Veth pair created"

# Link veth interfaces to namespaces
echo "linking veth interfaces to namespaces"
ip link set veth-red netns red && echo "Veth-red linked to namespace red"
ip link set veth-blue netns blue && echo "Veth-blue linked to namespace blue"

echo "Script setup_namespaces_veth ended"