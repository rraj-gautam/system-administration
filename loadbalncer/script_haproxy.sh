#!/bin/sh
#sudo su
cd ~ ;
echo "enter the ip address of webserver1: "
read webserver1
echo "enter the ip address of webserver2: "
read webserver2

yum -y install haproxy;
cd ~/etc/haproxy;
cp haproxy.cfg haproxy.cfg_bac;
#cat > ~/haproxyconfigfile.txt <<'endmsg'
cat <<EOT >> haproxy.cfg

global
   log /dev/log local0
   log /dev/log local1 notice
   chroot /var/lib/haproxy
   stats timeout 30s
   user haproxy
   group haproxy
   daemon

defaults
   log global
   mode http
   option httplog
   option dontlognull
   timeout connect 5000
   timeout client 50000
   timeout server 50000

frontend http_front
   bind *:80
   stats uri /haproxy?stats
   default_backend http_back

backend http_back
   balance roundrobin
   server webserver1 $webserver1:80 check
   server webserver2 $webserver2:80 check
                                              
EOT
#other script lines here
#endmsg


#sed -i 's/webserver1_ip_address/$webserver1/g' /etc/haproxy/haproxy.conf
#sed -i 's/webserver1_ip_address/$webserver1/g' /etc/haproxy/haproxy.conf

systemctl enable haproxy;
systemctl start haproxy;
echo "enter to see haproxy status: ";
systemctl status haproxy;
