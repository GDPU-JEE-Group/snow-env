# 设置静态ip  
vim  /etc/network/interfaces.d/eth0 
---------
auto eth0
iface lo inet loopback
allow-hotplug eth0
iface eth0 inet static
address 192.168.30.34
netmask 255.255.255.0
gateway 192.168.30.1
--------------------

# ssh 密码
systemctl restart sshd
passwd root
ssh-keygen -t rsa -C "973731820@qq.com"

# git
apt update
apt install git
git clone git@github.com:chaixiang2002/snow-env.git

# 切换 sh
chsh /usr/bin/bash

# arm-init-shell && manage-shell
scp -r 192.168.168.88:/root/out/arm-init-shell /userdata/
mkdir -p /userdata/arm-agent/bin
scp -r 192.168.168.88:/root/out/manage-shell /userdata/arm-agent/bin/

# docker
scp init-in-arm
./install_docker.sh 
 
# manage-shell
scp -r 192.168.168.88:/root/out/manage-shell ./
android_ctl.sh start 0 --images=rk3588:RK_ANDROID10-RKR14-root06071421  --mac=7c:2a:14:3b:35:ca --ip=192.168.30.35 --cpu=0 --gpu=0 --ram=0 --rom=0 --imei=863935410512281 --androidId=46af8b6feb561eda --serialNo=01MM0Q99SUN9 --wifiMac=04:6d:1c:01:12:2a --brand=Google --model=Pixel 2 --gateway=192.168.30.1 --subnet=192.168.30.0/24 --instanceId=92870289188257791
android_ctl.sh start 1 --images=rk3588:RK_ANDROID10-RKR14-root06071421  --mac=7c:2a:14:3b:35:cb --ip=192.168.30.36 --cpu=0 --gpu=0 --ram=0 --rom=0 --imei=863935410512282 --androidId=46af8b6feb561edb --serialNo=01MM0Q99SUN9 --wifiMac=04:6d:1c:01:12:2b --brand=Google --model=Pixel 2 --gateway=192.168.30.1 --subnet=192.168.30.0/24 --instanceId=92870289188257792
android_ctl.sh start 2 --images=rk3588:RK_ANDROID10-RKR14-root06071421  --mac=7c:2a:14:3b:35:cc --ip=192.168.30.37 --cpu=0 --gpu=0 --ram=0 --rom=0 --imei=863935410512283 --androidId=46af8b6feb561edc --serialNo=01MM0Q99SUN9 --wifiMac=04:6d:1c:01:12:2c --brand=Google --model=Pixel 2 --gateway=192.168.30.1 --subnet=192.168.30.0/24 --instanceId=92870289188257793
android_ctl.sh start 3 --images=rk3588:RK_ANDROID10-RKR14-root06071421  --mac=7c:2a:14:3b:35:cd --ip=192.168.30.38 --cpu=0 --gpu=0 --ram=0 --rom=0 --imei=863935410512284 --androidId=46af8b6feb561edd --serialNo=01MM0Q99SUN9 --wifiMac=04:6d:1c:01:12:2d --brand=Google --model=Pixel 2 --gateway=192.168.30.1 --subnet=192.168.30.0/24 --instanceId=92870289188257794




