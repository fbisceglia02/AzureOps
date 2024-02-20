#!/bin/bash

echo "script assign_ips_bringup_veth started"

# Assign IP to veth-red in namespace red
echo "assigning IP to veth-red in namespace red"
ip netns exec red ip addr add 192.168.15.1/24 dev veth-red && echo "IP assigned to veth-red in namespace red"

# Assign IP to veth-blue in namespace blue
echo "assigning IP to veth-blue in namespace blue"
ip netns exec blue ip addr add 192.168.15.2/24 dev veth-blue && echo "IP assigned to veth-blue in namespace blue"

# Bring up veth-red in namespace red
echo "bringing up veth-red in namespace red"
ip netns exec red ip link set veth-red up && echo "veth-red brought up in namespace red"

# Bring up veth-blue in namespace blue
echo "bringing up veth-blue in namespace blue"
ip netns exec blue ip link set veth-blue up && echo "veth-blue brought up in namespace blue"

# Optionally, bring up loopback interfaces in namespaces
echo "bringing up loopback interfaces in namespaces"
ip netns exec red ip link set lo up && echo "Loopback interface brought up in namespace red"
ip netns exec blue ip link set lo up && echo "Loopback interface brought up in namespace blue"

echo "script assign_ips_bringup_veth ended"
