<!-- mdtocstart -->

# Table of Contents

    - [Requiriments](#requiriments)
    - [Linux Networking Concepts](#linux-networking-concepts)
    - [What is a `computer network`?](#what-is-a-computer-network)
    - [What is the `Internet`?](#what-is-the-internet)
    - [How Does The Internet Work?](#how-does-the-internet-work)
    - [This IP Thing](#this-ip-thing)
    - [Groups of IP Addresses: Network Masks](#groups-of-ip-addresses-network-masks)
    - [Machine Names and IP Addresses (DNS)](#machine-names-and-ip-addresses-dns)
    - [Different Services: Email, Web, FTP, Name Serving](#different-services-email-web-ftp-name-serving)
    - [What Packets Look Like](#what-packets-look-like)
    - [Environment Setup](#environment-setup)
    - [Network](#network)
        - [Connect to each VM and check the network and routing table settings and take notes.###](#connect-to-each-vm-and-check-the-network-and-routing-table-settings-and-take-notes)
        - [Check the network connectivity and take notes.](#check-the-network-connectivity-and-take-notes)
        - [Set the default route and take notes.](#set-the-default-route-and-take-notes)
        - [Enable router ip_forward](#enable-router-ipforward)
    - [Netfilter/Iptables](#netfilteriptables)
        - [So What's A Packet Filter?](#so-whats-a-packet-filter)
        - [Why Would I Want to Packet Filter?](#why-would-i-want-to-packet-filter)
        - [How Do I Packet Filter Under Linux?](#how-do-i-packet-filter-under-linux)
        - [How Packets Traverse The Filters](#how-packets-traverse-the-filters)
        - [Using iptables](#using-iptables)

<!-- mdtocend -->

Course Netfilter/Iptables Hands-On
===

## Requiriments

  - [Vagrant](https://www.vagrantup.com/) is a command line utility for managing the lifecycle of virtual machines.
  - [Virtualbox](https://www.virtualbox.org/)  is a general-purpose full virtualizer for x86 hardware, targeted at server, desktop and embedded use.

## Linux Networking Concepts

## What is a `computer network`?

## What is the `Internet`?

## How Does The Internet Work?

https://www.youtube.com/watch?v=7_LPdttKXPc

https://www.youtube.com/watch?v=HNQD0qJ0TC4

## This IP Thing

- The role of the IP layer is to figure out how to `route' packets to their final destination

- Router is a node with interfaces on more than one network

- The Linux Kernel's IP layer keeps a table of different `routes`, describing how to get to various groups of IP addresses


## Groups of IP Addresses: Network Masks

        Short   Full                    Maximum         Comment
        Form    Form                    #Machines

        /8      /255.0.0.0              16,777,215      Used to be called an `A-class'
        /16     /255.255.0.0            65,535          Used to be called an `B-class'
        /17     /255.255.128.0          32,767
        /18     /255.255.192.0          16,383
        /19     /255.255.224.0          8,191
        /20     /255.255.240.0          4,095
        /21     /255.255.248.0          2,047
        /22     /255.255.252.0          1,023
        /23     /255.255.254.0          511
        /24     /255.255.255.0          255             Used to be called a `C-class'
        /25     /255.255.255.128        127
        /26     /255.255.255.192        63
        /27     /255.255.255.224        31
        /28     /255.255.255.240        15
        /29     /255.255.255.248        7
        /30     /255.255.255.252        3


## Machine Names and IP Addresses (DNS)

 - [IANA - IP Addresses](https://www.iana.org/numbers) - responsible for global coordination of the Internet Protocol addressing systems, as well as the Autonomous System Numbers used for routing Internet traffic.
 - [IANA - Root Servers](https://www.iana.org/domains/root/servers) - responsible for management of the DNS root zone. This role means assigning the operators of top-level domains, such as .uk and .com, and maintaining their technical and administrative details.

## Different Services: Email, Web, FTP, Name Serving

- TCP and UDP have a concept of `ports`.
- [IANA - Protocol Registries](https://www.iana.org/protocols) - responsible for maintaining many of the codes and numbers contained in a variety of Internet protocols, enumerated below. We provide this service in coordination with the Internet Engineering Task Force (IETF).

## What Packets Look Like

- IP : https://en.wikipedia.org/wiki/IPv4#Protocol

- TCP : https://en.wikipedia.org/wiki/Transmission_Control_Protocol#TCP_segment_structure

## Environment Setup

Clone this repo and run:

```
vagrant up
```

At this point the Vagrant created 4 VMs (router, node1, node2, server).

Check the status of VMs

```
vagrant status
```

The diagram bellow represent the network conection between this VMs


![Network Diagram](https://github.com/lborguetti/netfilter-hands-on/raw/master/docs/networking-diagram.dot.png)


## Network

### Connect to each VM and check the network and routing table settings and take notes.###

```
vagrant ssh VM-NAME
```

```
ip address show
ip route show
cat /etc/resolv.conf
cat /proc/sys/net/ipv4/ip_forward
```

or

```
ifconfig -a
route -n
cat /etc/resolv.conf
cat /proc/sys/net/ipv4/ip_forward
```

### Check the network connectivity and take notes.

**router VM**

```
ping 192.168.20.10 # server vm
ping 172.16.10.10 # node1 vm
ping 172.16.10.11 # node2 vm
ping 8.8.8.8
dig @8.8.8.8 www.google.com
curl -v https://www.google.com
```

**server VM**

```
ping 192.168.20.2 # router vm
ping 172.16.10.10 # node1 vm
ping 172.16.10.11 # node2 vm
ping 8.8.8.8
dig @8.8.8.8 www.google.com
curl -v https://www.google.com
```

**node1 VM**

```
ping 172.16.10.2 # router vm
ping 172.16.10.11 # node2 vm
ping 192.168.20.10 # server vm
ping 8.8.8.8
dig @8.8.8.8 www.google.com
curl -v https://www.google.com
```

**node2 VM**

```
ping 172.16.10.2 # router vm
ping 172.16.10.10 # node1 vm
ping 192.168.20.10 # server vm
ping 8.8.8.8
dig @8.8.8.8 www.google.com
curl -v https://www.google.com
```

### Set the default route and take notes.

**server VM**

```
vagrant ssh server
```

```
ip route add default via 192.168.20.2
```

or

```
route add default gw 192.168.20.2
```

**node1 VMs**

```
vagrant ssh node1
```

```
ip route add default via 172.16.10.2
```

or

```
route add default gw 192.168.20.2
```

**node2 VMs**

```
vagrant ssh node2
```

```
ip route add default via 172.16.10.2
```

or

```
route add default gw 192.168.20.2
```

**Check the network connectivity again.**

Doubts?

### Enable router ip_forward

```
ip_forward - BOOLEAN
  0 - disabled (default)
  not 0 - enabled

    Forward Packets between interfaces.

    This variable is special, its change resets all configuration
    parameters to their default state (RFC1122 for hosts, RFC1812
    for routers)
```

https://www.kernel.org/doc/Documentation/networking/ip-sysctl.txt


```
vagrant ssh router
```

```
echo 1 > /proc/sys/net/ipv4/ip_forward
```

Enable ip_forward permanentely. Edit */etc/sysctl.conf* and add: `net.ipv4.ip_forward=1`

**Check the network connectivity again.**

Doubts?


## Netfilter/Iptables

### So What's A Packet Filter?

- A packet filter is a piece of software which looks at the header of packets as they pass through, and decides the fate of the entire packet

- It might decide to DROP the packet, ACCEPT the packet, or something more complicated (NAT)

### Why Would I Want to Packet Filter?

- Control. Security. Watchfulness

### How Do I Packet Filter Under Linux?

- [Netfilter](https://netfilter.org/) - is a set of hooks inside the Linux kernel that allows kernel modules to register callback functions with the network stack. A registered callback function is then called back for every packet that traverses the respective hook within the network stack.

- [Iptables](https://netfilter.org/projects/iptables/index.html) - is a generic table structure for the definition of rulesets. Each rule within an IP table consists of a number of classifiers (iptables matches) and one connected action (iptables target).

### How Packets Traverse The Filters

![Routing tables traversal process](http://ebtables.netfilter.org/br_fw_ia/bridge3b.png)


### Using iptables
