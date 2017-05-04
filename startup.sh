#!/bin/sh
set -e
set -x

cd /root/juniper-vpn-py
./juniper-vpn.py --config ~/cvpn.cfg &
iptables -t nat -A POSTROUTING -o tun0 -j MASQUERADE
iptables -A FORWARD -i eth0 -j ACCEPT
