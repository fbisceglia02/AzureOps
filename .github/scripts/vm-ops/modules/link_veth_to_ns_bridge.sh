#!/bin/bash

echo "Link veth to namespaces and bridge script started"

echo "attaching the second end of the pipe to the namespace, one end of the other pipe to the master switch"
ip link set veth-red netns red && echo "veth-red moved to namespace red"
ip link set veth-blue netns blue && echo "veth-blue moved to namespace blue"
ip link set veth-orange netns orange && echo "veth-orange moved to namespace orange"
ip link set veth-gray netns gray && echo "veth-gray moved to namespace gray"
ip link set veth-red-br master v-net-0 && echo "veth-red-br attached to v-net-0 bridge"
ip link set veth-blue-br master v-net-0 && echo "veth-blue-br attached to v-net-0 bridge"
ip link set veth-orange-br master v-net-0 && echo "veth-orange-br attached to v-net-0 bridge"
ip link set veth-gray-br master v-net-0 && echo "veth-gray-br attached to v-net-0 bridge"

echo "Link veth to namespaces and bridge script ended"
