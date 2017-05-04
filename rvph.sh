#! /bin/bash
JUNIPER_DOCKER_IP="$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' junipervpn)"
if [ -z "$JUNIPER_DOCKER_IP" ]; then
	echo >&2 'error: missing JUNIPER_DOCKER_IP, is junipervpn docker running?'
	exit 1;
fi
sudo route add -net 10.0.0.0 netmask 255.0.0.0 gw $JUNIPER_DOCKER_IP

#read -p "Press any key to stop vpn... " -n1 -s


while [ "$yn" != "Yes" ]; do
 echo "Stop VPN? (Yes)"
  read yn
done

sudo route del -net 10.0.0.0 gw $JUNIPER_DOCKER_IP netmask 255.0.0.0
