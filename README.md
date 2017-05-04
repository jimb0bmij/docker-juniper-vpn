# docker-juniper-vpn

Dockerized juniper vpn connection using:

> http://www.infradead.org/openconnect/

> https://github.com/jamgocoop/juniper-vpn-py

This is only a simple implementation to skip browser connect limitations in linux.

# How to use this image

    docker run --name junipervpn -e JUNIPER_HOST=<host> -e JUNIPER_USER=<user> -e JUNIPER_PASSWORD=<password> --privileged=true -d -ti jimb0mbij/juniper-vpn


# To test

git clone https://github.com/jimb0bmij/docker-juniper-vpn

cd docker-juniper-vpn

docker build -t jimb0mbij/juniper-vpn .

./ivpn.sh (Fill in information requested)
If you see your vpn ip in the route table should be good.

If you wish to test more:

docker exec -it junipervpn bash
route
ping destination
exit


Once container is started you can route subnets from host via docker container:

    #! /bin/bash
    JUNIPER_DOCKER_IP="$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' junipervpn)"
    if [ -z "$JUNIPER_DOCKER_IP" ]; then
    	echo >&2 'error: missing JUNIPER_DOCKER_IP, is junipervpn docker running?'
    	exit 1;
    fi
    sudo route add -net 10.0.0.0 netmask 255.0.0.0 gw $JUNIPER_DOCKER_IP
    #sudo route add -net a.b.c.0 netmask 255.255.255.0 gw $JUNIPER_DOCKER_IP
    #sudo route add -net x.y.z.0 netmask 255.255.255.0 gw $JUNIPER_DOCKER_IP
    
    # when done
    
    while [ "$yn" != "Yes" ]; do
    echo "Stop VPN? (Yes)"
    read yn
    done
   
    sudo route del -net 10.0.0.0 gw $JUNIPER_DOCKER_IP netmask 255.0.0.0
    

docker stop junipervpn

docker start junipervpn

