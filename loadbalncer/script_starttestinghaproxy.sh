#!/bin/sh

#systemctl start haproxy;
#systemctl enable haproxy;

#echo "enter haproxy loadbalancer ip address :"
read loadbalancer

echo"hit ctl+c when done";
while true; 
do
curl $loadbalancer:80 ;
sleep 1 ;
done


#c=1
#while [ $c -le 7 ]
#do
#	curl $loadbalancer:80 ;
#	sleep 1;
#	(( c++ ))
#done
#echo "Congrats! your loadbalancer is successfully working"
