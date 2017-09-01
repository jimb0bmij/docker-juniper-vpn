# I forked this. What I did not like is not enough scripts and if you do it via command line your password shows up in PS -ef.

# docker-juniper-vpn

Dockerized juniper vpn connection using:

> http://www.infradead.org/openconnect/

> https://github.com/jamgocoop/juniper-vpn-py

This is only a simple implementation to skip browser connect limitations in linux.

# How to use this image

    docker run --name junipervpn -e JUNIPER_HOST=<host> -e JUNIPER_USER=<user> -e JUNIPER_PASSWORD=<password> --privileged=true -d -ti jimb0mbij/juniper-vpn

# To test jimb0bmij way

git clone https://github.com/jimb0bmij/docker-juniper-vpn

cd docker-juniper-vpn

docker build -t jimb0mbij/juniper-vpn .

./ivpn.sh (Fill in information requested)
After the connection is completed you should see your vpn server ip in the route table and you should be good.

If you wish to test more:

docker exec -it junipervpn bash
route
ping destination
exit


./rvpn.sh (This routes the container to your local machine)

In a new terminal session.
route
ping destination

When done vpn'in answer yes (to the rvpn.sh script) to stop the routing.
docker stop junipervpn

DONE

To Start again:

docker start junipervpn
./rvpn.sh


https://by-example.org/how-to-install-docker-1-8-on-ubuntu-14-04-lts-x64/
