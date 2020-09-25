#!/bin/bash

cd lighttpd_container

docker build -t lighttpd .

cd ..

echo [+OK] $PWD lighttpd example docker build complete

cd ../docker

docker build -t linuxbuild -f build-env.Dockerfile .

echo [+OK] $PWD linuxbuild docker image built -\> compiles linux...

cd ..

./scripts/build-with-configs.sh nopatch configs/lupine-djw-nokml.config configs/apps/general.config

echo [+OK] $PWD built kernel ..


./scripts/image2rootfs.sh lighttpd latest ext2

echo [+OK] $PWD built rootfs ...

./scripts/firecrackerd.sh &

sleep 2

echo [+OK] $PWD Started firecracker daemon ...

./scripts/firecracker-run.sh kernelbuild/lupine-djw-nokml++general/vmlinux lighttpd.ext2 /bin/guest_init.sh

sleep 2

IP="192.168.100.1/24"
ip l set tap100 up
ip a add $IP dev tap100

echo [+OK] firecrackerd started, tap100 up with ip $IP

echo [+OK] guest spawned :\).... hoping for best
echo [INF] check console output or ping / curl 192.168.100.2 ...
echo [INF] if you are done, $ killall firecracker
