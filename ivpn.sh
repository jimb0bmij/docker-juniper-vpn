#!/bin/bash

# Read Host
echo -n Host:
read host
echo
# Run Command
echo $host

# Read User
echo -n Username:
read user
echo
# Run Command
echo $user

# Read Password
echo -n Password:
read -s password
echo

dvpn="junipervpn"
echo Container name $dvpn

cp tvpn.cfg cvpn.cfg
sed -i "s/1/$host/g" cvpn.cfg
sed -i "s/2/$user/g" cvpn.cfg
sed -i "s/3/$password/g" cvpn.cfg


docker run --name $dvpn --privileged=true -d -ti jimb0mbij/juniper-vpn
docker stop $dvpn

docker cp cvpn.cfg $dvpn:/root/cvpn.cfg

rm cvpn.cfg

docker start $dvpn

docker ps |grep $dvpn
sleep 10
docker exec -it $dvpn route
