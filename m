Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-list2-b.sourceforge.net ([10.3.1.8]
	helo=sc8-sf-list2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BxVIC-0005tE-Di for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Aug 2004 11:36:12 -0700
Message-ID: <4123A17A.9070200@americasm01.nt.com>
From: "Randy Macleod" <macleodr@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] tipc in networked UML
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
Date: Wed, 18 Aug 2004 14:35:38 -0400
Cc: user-mode-linux-devel@lists.sourceforge.net, tipc-discussion@lists.sourceforge.net


Hello,

    I'm simulating a small cluster of processors using
UML (user-mode-linux.sourceforge.net)
and TIPC (tipc.sf.net).
Has anyone else tried this?

The network is simulated using tun devices, i.e.

cpu0 with eth0 in a UML is connected to pce.0.0.0
cpu1 with eth0 in a UML is connected to pce.0.1.0

A bridge device connects these pce(s) and forwards
ethernet frames based on mac addrs. Packet delivery
is communicated to the UML receiver by a signal according
to Jeff Dike (the UML guy)

Below is some output of /sbin/ifconfig -a on the desktop...

Now when these UML's load, a tipc kernel module gets insmod'ed
and things work to first order as expected.
BUT...
Several problems occur:

1. Connectionless communication is very unreliable.
   (see my previous post for tfsend/tfrecv))
   Only 100's of messages can be exchanged before getting
   a sequence error.

2. Resetting 1 node causes confusion of the tipc name table
of other nodes.

If I have 3 UML's (A,B,C),
  - publish a tipcname on A,
  - reset node C
  - then node A get stuck periodically withdrawing the published name.


3. On a lightly loaded system with 10s of processes per UML,
    there are frequently very long (> 5 seconds) tipc packet latencies
    whereas the normal latency is 0.3 seconds. The desktop load
    is always very low. If I ping each node every 0.1 seconds
    the high latencies mostly go away. Seem's like the signal
    is missed...

So, does TIPC assume real-time behaviour
of packets on the network. i.e. by the time N packets have been
sent, the other kernels have received the packets and will send
flow control messages?

If this is the case then I think a minimal modification to UML
to do a sched_yield() every N packets (in or out) would
help matters. Furthermore, it may be a good idea to co-operatively
schedule all the UML's so that their clocks are all in sync and
no node can send or receive too many packets at one time.

Comments?

// Randy




cpbr.0    Link encap:Ethernet  HWaddr 00:FF:3A:1A:CB:69
           inet addr:10.0.254.1  Bcast:10.255.255.255  Mask:255.255.0.0
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:52 errors:0 dropped:0 overruns:0 frame:0
           TX packets:10 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:0
           RX bytes:1624 (1.5 Kb)  TX bytes:704 (704.0 b)

pce.0.0.0 Link encap:Ethernet  HWaddr 00:FF:E2:5D:50:B0
           UP BROADCAST RUNNING PROMISC MULTICAST  MTU:1500  Metric:1
           RX packets:3262 errors:0 dropped:0 overruns:0 frame:0
           TX packets:2562 errors:0 dropped:149 overruns:0 carrier:0
           collisions:0 txqueuelen:1024
           RX bytes:452010 (441.4 Kb)  TX bytes:519063 (506.8 Kb)

pce.0.1.0 Link encap:Ethernet  HWaddr 00:FF:3A:1A:CB:69
           UP BROADCAST RUNNING PROMISC MULTICAST  MTU:1500  Metric:1
           RX packets:6 errors:0 dropped:0 overruns:0 frame:0
           TX packets:1333 errors:0 dropped:1079 overruns:0 carrier:0
           collisions:0 txqueuelen:1024
           RX bytes:228 (228.0 b)  TX bytes:302530 (295.4 Kb)





-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
