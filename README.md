Course Netfilter/Iptables
===

# Environment

## Import VM images

## Network setup

# Linux Networking Concepts

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

## Different Services: Email, Web, FTP, Name Serving

- TCP and UDP have a concept of `ports`.

## What Packets Look Like

- IP : https://en.wikipedia.org/wiki/IPv4#Protocol

- TCP : https://en.wikipedia.org/wiki/Transmission_Control_Protocol#TCP_segment_structure


## Netfilter/Iptables

### So What's A Packet Filter?

- A packet filter is a piece of software which looks at the header of packets as they pass through, and decides the fate of the entire packet

- It might decide to DROP the packet, ACCEPT the packet, or something more complicated (NAT)

### Why Would I Want to Packet Filter?

- Control. Security. Watchfulness

### How Do I Packet Filter Under Linux?

- Netfilter

- Iptables

### How Packets Traverse The Filters

![Routing tables traversal process](http://ebtables.netfilter.org/br_fw_ia/bridge3b.png)


## Using iptables
