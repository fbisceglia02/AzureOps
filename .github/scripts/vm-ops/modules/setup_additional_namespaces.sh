#!/bin/bash

echo "Setup additional namespaces script started"

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

echo "Setup additional namespaces script ended"
