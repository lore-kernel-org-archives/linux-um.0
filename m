Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-ID: <BED61B4631F1D51189C300A0C9E95976085B93A5@delg001a>
From: Amit Mathur <Mathur.Amit@sisl.co.in>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: [uml-devel] multicast problem in UML
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Mon, 21 Mar 2005 14:32:32 +0530
To: User-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net


==User-mode-linux-user@lists.sourceforge.net
==user-mode-linux-devel@lists.sourceforge.net

I am not able to exchange multicast packets between two UMLs using tuntap
transport type but it works for uml_switch daemon. 
The steps followed are:

[host]#./linux umid=uml1 ubd0=Debian-3.0r0.ext2 init=/sh
eth0=tuntap,,,132.186.0.253  con=port:9977 con0=fd:0,fd:1

[host]#./linux umid=uml2 ubd0=Debian2-3.0r0.ext2 init=/sh
eth0=tuntap,,,132.186.0.254  con=port:9988 con0=fd:0,fd:1

Then bringing up the loopback and eth0
uml 1#ifconfig eth0 132.186.0.99  up
uml 1#ifconfig lo 127.0.0.1 up

uml 2#ifconfig eth0 132.186.0.100 up
uml 2#ifconfig lo 127.0.0.1 up

setting the route in uml1 and uml2 by
uml#route add -net 224.0.0.0 netmask 240.0.0.0 dev eth0

The two UMLs can exchange unicast packets but are not able to exchange
multicast packets.In the host, packets are reaching tap0 but are not going
to tap1. So it appears  something needs to be done at the host.

The route at host shows the following entries.

Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use
Iface
132.186.0.100   *               255.255.255.255 UH    0      0        0 tap1
132.186.0.99    *               255.255.255.255 UH    0      0        0 tap0
132.186.113.128 *               255.255.255.128 U     0      0        0 eth0
127.0.0.0       *               255.0.0.0       U     0      0        0 lo
default         132.186.113.129 0.0.0.0         UG    0      0        0 eth0


Can anyone please guide me what should be done ?



Regards,
Amit 





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
