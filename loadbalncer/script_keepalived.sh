###!bin/bash
yum -y install keepalived;
yum -y update;
mv /etc/keepalived/keepalived.conf  /etc/keepalived/keepalived.conf_bac;
touch /etc/keepalived/keepalived.conf;
echo "enter your interface name";
read interface;
echo "enter priority. 101 for master loadbalancer or 100 for Backup loadbalancer";
read priority;
echo "enter the virtual IP address" ;
read virtual_ip;
cat <<END >>/etc/keepalived/keepalived.conf;
global_defs {
   notification_email {
     linuxhandbook.com
     linuxhandbook@gmail.com
   }
   notification_email_from thunderdfrost@gmail.com
   smtp_server 192.168.200.1
   smtp_connect_timeout 30
   router_id LVS_DEVEL
}

vrrp_instance VI_1 {
    state MASTER
    interface $interface   	#put your  interface name here. [to see interface name: $  ip a ]
    virtual_router_id 51
    priority $priority            # 101 for master. 100 for backup. [priority of master> priority of backup]
    advert_int 1
    authentication {
        auth_type PASS
        auth_pass 1111   #password
    }
    virtual_ipaddress {
       $virtual_ip  #192.168.100.20         	# use the virtual ip address . Any live IP inside your network. 
				Near about the range of Loadbalancer’s IP Address. Here, load 					balancer’s IP are: 192.168.100.10 & 192.168.100.30
    }
}
END

systemctl start keepalived;
systemctl enable keepalived;
echo "enter to see keepalived status"
systemctl status keepalived;



