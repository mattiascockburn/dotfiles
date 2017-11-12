#!/bin/bash

iface="${1:-br1}"
ip="${2:-10.10.10.1/24}"

ip link add dev "$iface" type bridge
ip a a dev "$iface" "$ip"
ip link set "$iface" up

