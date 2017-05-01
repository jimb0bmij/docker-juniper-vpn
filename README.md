# docker-juniper-vpn

Dockerized juniper vpn connection using:

> http://www.infradead.org/openconnect/

> https://github.com/jamgocoop/juniper-vpn-py

This is only a simple implementation to skip browser connect limitations in linux.

# How to use this image

    docker run --name junipervpn -e JUNIPER_HOST=<host> -e JUNIPER_USER=<user> -e JUNIPER_PASSWORD=<password> --privileged=true -d -ti jimb0mbij/juniper-vpn


# To test

docker build -t jimb0mbij/juniper-vpn .


docker exec -it junipervpn bash

route

ping destination

exit

docker stop junipervpn

Once started you can route subnets from host via docker container:

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
    
    read -p "Press any key to stop vpn... " -n1 -s
    
    sudo route del -net 10.0.0.0 gw $JUNIPER_DOCKER_IP netmask 255.0.0.0
    

