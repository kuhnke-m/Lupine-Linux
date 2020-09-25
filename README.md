# Lupine: Linux in Unikernel Clothes

**[Original project repository](https://github.com/hckuo/Lupine-Linux)**

## Purpose

Dockerfile -> unikernel.


Transform a custom lighttpd docker container into a fully functional unikernel-like kernel and rootfs using
the minimal Lupine-Linux kernel.

The purpose is to help you get started with Lupine-Linux in as short time as possible.
It is essentially the same repo as the original, with an added general configuration and an example.

It is designed so you can understand the necessary steps by reading the prepare.sh script. It currently
compiles the Lupine-djw-nokml kernel and generates an ext2 rootfs.

The example uses the network 192.168.100.1/24 (192.168.100.2 is the unikernel).


## Setup
Clone project:
`git clone https://github.com/kuhnke-m/Lupine-Linux`

Update submodule (takes time):
`git submodule update --init`

Dockerfile ->  
`cd example && ./prepare.sh`

Test server with:
`curl 192.168.100.2`

Enjoy :)


## Added Files
```
configs/apps/general.config (Union of all app configuration options)
example/
|-- prepare.sh (do everything to get from Dockerfile to running firecracker guest)
`--lighttpd_container
   |-- Dockerfile (instruction to build container)
   |-- guest_init.sh (calls guest_dev.sh and guest_net.sh which are copied into rootfs later)
   `-- index.html (a message)
```


## Requirements

KVM enabled.
 modprobe kvm_{amd,intel}

Installed and running docker.

Tested on AMD x86_64 system.
