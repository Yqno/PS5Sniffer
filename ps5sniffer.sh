#!/bin/bash

LAN="enp1s0f0" # your LAN Interface here
WAN="wlan0" # your Wifi Interface Here

ip addr replace 192.168.50.1/24 dev $LAN
ip link set $LAN up

sysctl -w net.ipv4.ip_forward=1

iptables -t nat -A POSTROUTING -o $WAN -j MASQUERADE
iptables -A FORWARD -i $LAN -o $WAN -j ACCEPT
iptables -A FORWARD -i $WAN -o $LAN -m state --state RELATED,ESTABLISHED -j ACCEPT

systemctl restart dnsmasq
