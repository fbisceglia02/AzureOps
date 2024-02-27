#!bin/bash

echo "Script started"

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

echo "creating orange and gray namespaces"
# orange and gray namespaces operations
ip netns add orange
ip netns add gray

echo "starting switch section's operations"
sleep 2

echo "adding bridge interface (v-net-0)"
ip link add v-net-0 type bridge

echo "notice here (ip link on the host) how the v-net-0 interface is in state DOWN"
ip link
sleep 4

echo "putting it up"
ip link set dev v-net-0 up

echo "deleting previous veth cable (red veth and its blue peering)"
ip -n red link del veth-red

echo "attaching the first veth end to the -br end to be connected with the bridge interface"
ip link add veth-red type veth peer name veth-red-br
ip link add veth-blue type veth peer name veth-blue-br
ip link add veth-orange type veth peer name veth-orange-br
ip link add veth-gray type veth peer name veth-gray-br


echo "attaching the second end of the pipe to the namespace, one end of the other pipe to the master switch"
ip link set veth-red netns red && echo "veth-red moved to namespace red"
ip link set veth-blue netns blue && echo "veth-blue moved to namespace blue"
ip link set veth-orange netns orange && echo "veth-orange moved to namespace orange"
ip link set veth-gray netns gray && echo "veth-gray moved to namespace gray"
ip link set veth-red-br master v-net-0 && echo "veth-red-br attached to v-net-0 bridge"
ip link set veth-blue-br master v-net-0 && echo "veth-blue-br attached to v-net-0 bridge"
ip link set veth-orange-br master v-net-0 && echo "veth-orange-br attached to v-net-0 bridge"
ip link set veth-gray-br master v-net-0 && echo "veth-gray-br attached to v-net-0 bridge"


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