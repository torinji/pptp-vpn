#!/bin/bash
aws_comp=$1
if [ -n "$aws_comp" ] ; then
docker-machine create \
--driver amazonec2 \
--amazonec2-region us-east-2 \
--amazonec2-zone a \
--amazonec2-vpc-id vpc-4fb7cd26 \
--amazonec2-subnet-id subnet-2f481d46 \
--amazonec2-access-key AKIAIR*** \
--amazonec2-secret-key imZ***\
--amazonec2-open-port 1723 \
--amazonec2-userdata userdata.sh \
$aws_comp 
else echo "Введите название машины"
fi
docker-machine scp -r ./etc $aws_comp:/tmp
docker-machine ssh $aws_comp 'sudo apt-get -yqq update && sudo apt-get install -yqq pptpd && sudo cp -r /tmp/etc / && sudo service pptpd restart'
docker-machine ip $aws_comp
