#!bin/bash

chmod +x modules/assign_ips_bringup_veth.sh modules/assign_ip_retest_conn.sh modules/link_veth_to_ns_bridge.sh modules/setup_additional_namespaces.sh modules/setup_namespaces_veth.sh modules/test_connectivity.sh

echo "modules/setup_namespaces_veth.sh" && bash modules/setup_namespaces_veth.sh

echo "modules/assign_ips_bringup_veth.sh" && bash modules/assign_ips_bringup_veth.sh

echo "modules/test_connectivity.sh" && bash modules/test_connectivity.sh

echo "modules/setup_additional_namespaces.sh" && bash modules/setup_additional_namespaces.sh

echo "modules/link_veth_to_ns_bridge.sh" && bash modules/link_veth_to_ns_bridge.sh

echo "modules/assign_ip_retest_conn.sh" && bash modules/assign_ip_retest_conn.sh

