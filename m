Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-list2-b.sourceforge.net ([10.3.1.8]
	helo=sc8-sf-list2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BxsZT-0005Vf-S7 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 19 Aug 2004 12:27:35 -0700
Message-ID: <4124FF1D.2040503@americasm01.nt.com>
From: "Randy Macleod" <macleodr@nortelnetworks.com>
MIME-Version: 1.0
References: <4123ACEA.6080600@ericsson.com>
In-Reply-To: <4123ACEA.6080600@ericsson.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: [tipc-discussion] tipc in networked UML
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
Date: Thu, 19 Aug 2004 15:27:25 -0400
To: user-mode-linux-devel@lists.sourceforge.net, tipc-discussion@lists.sourceforge.net

   Hi,

   Comments and more info below.

// Randy

Jon Maloy wrote:
> See below
> /jon
> 
> Randy Macleod wrote:
> 
>  >
>  > Hello,
>  >
>  >    I'm simulating a small cluster of processors using
>  > UML (user-mode-linux.sourceforge.net)
>  > and TIPC (tipc.sf.net).
>  > Has anyone else tried this?
>  >
>  > The network is simulated using tun devices, i.e.
>  >
>  > cpu0 with eth0 in a UML is connected to pce.0.0.0
>  > cpu1 with eth0 in a UML is connected to pce.0.1.0
>  >
>  > A bridge device connects these pce(s) and forwards
>  > ethernet frames based on mac addrs. Packet delivery
>  > is communicated to the UML receiver by a signal according
>  > to Jeff Dike (the UML guy)
>  >
>  > Below is some output of /sbin/ifconfig -a on the desktop...
>  >
>  > Now when these UML's load, a tipc kernel module gets insmod'ed
>  > and things work to first order as expected.
>  > BUT...
>  > Several problems occur:
>  >
>  > 1. Connectionless communication is very unreliable.
>  >   (see my previous post for tfsend/tfrecv))
>  >   Only 100's of messages can be exchanged before getting
>  >   a sequence error.
> 
> At least this should make it easier to reproduce and track down the
> problem you identified in your previous mail...

   Yes. I've turned on the tipc logging and I'm coming up to
speed on tipc (and kernel) internals.

>  >
>  > 2. Resetting 1 node causes confusion of the tipc name table
>  > of other nodes.
>  >
>  > If I have 3 UML's (A,B,C),
>  >  - publish a tipcname on A,
>  >  - reset node C
>  >  - then node A get stuck periodically withdrawing the published name.

   I should have said:
     node A continually sends out periodic withdraw messages.

I repeated this test and saw different behaviour...

After node C was reset, things look pretty normal - the link to C gets
torn down, but
name publication seems to be broken (the name distribution
seems to work at the packet level but node B always reports
that the name of interest has been published even if I kill
the process that owns the name. I waited for quiet a while
for the timeout... This sounds like it could be the fixed bug
that you mention below. I'll see if that helps.

BTW, about a month ago, I extended the link tolerance
from 1500 (ms ?) to 15000. This helped avoid false
link down messages at a time when I didn't care about detecting
node failures. Now I do care about node failure and
I've added tolerance and maxinterval as insmod options.
I'm testing with tolerance=1600, maxinterval=400.


> 
> Do you mean node A hangs ? (Btw, are you running the latest version
> tipc-1.3.14 ?,

No, I'm stuck in linux-2.4 land running tipc-1.2.05.
I'm going either try umlinux-2.6 and the latest tipc or
backport tipc to (um)linux 2.4. I'll keep posting.

> I fixed a quite nasty bug in one of the later versions, where equal
> publications
> from different nodes got the same publication key, with the result that
> the wrong
> publication was removed sometimes)
> 
>  >
>  >
>  >
>  > 3. On a lightly loaded system with 10s of processes per UML,
>  >    there are frequently very long (> 5 seconds) tipc packet latencies
>  >    whereas the normal latency is 0.3 seconds. The desktop load
>  >    is always very low. If I ping each node every 0.1 seconds
>  >    the high latencies mostly go away. Seem's like the signal
>  >    is missed...
> 
>  >
>  >
>  > So, does TIPC assume real-time behaviour
>  > of packets on the network. i.e. by the time N packets have been
>  > sent, the other kernels have received the packets and will send
>  > flow control messages?
> 
> To work really well we assume that there is real parallelism, but TIPC
> should never fail because of long latency times. 
> I think I have a seen similar effect on VmWare.

And did you ever get a tipc network to behave properly
using vmware?

> 
>  >
>  >
>  > If this is the case then I think a minimal modification to UML
>  > to do a sched_yield() every N packets (in or out) would
>  > help matters. Furthermore, it may be a good idea to co-operatively
>  > schedule all the UML's so that their clocks are all in sync and
>  > no node can send or receive too many packets at one time.
>  >
>  > Comments?
>  >
>  > // Randy
>  >
>  >
>  >
>  >
>  > cpbr.0    Link encap:Ethernet  HWaddr 00:FF:3A:1A:CB:69
>  >           inet addr:10.0.254.1  Bcast:10.255.255.255  Mask:255.255.0.0
>  >           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>  >           RX packets:52 errors:0 dropped:0 overruns:0 frame:0
>  >           TX packets:10 errors:0 dropped:0 overruns:0 carrier:0
>  >           collisions:0 txqueuelen:0
>  >           RX bytes:1624 (1.5 Kb)  TX bytes:704 (704.0 b)
>  >
>  > pce.0.0.0 Link encap:Ethernet  HWaddr 00:FF:E2:5D:50:B0
>  >           UP BROADCAST RUNNING PROMISC MULTICAST  MTU:1500  Metric:1
>  >           RX packets:3262 errors:0 dropped:0 overruns:0 frame:0
>  >           TX packets:2562 errors:0 dropped:149 overruns:0 carrier:0
>  >           collisions:0 txqueuelen:1024
>  >           RX bytes:452010 (441.4 Kb)  TX bytes:519063 (506.8 Kb)
>  >
>  > pce.0.1.0 Link encap:Ethernet  HWaddr 00:FF:3A:1A:CB:69
>  >           UP BROADCAST RUNNING PROMISC MULTICAST  MTU:1500  Metric:1
>  >           RX packets:6 errors:0 dropped:0 overruns:0 frame:0
>  >           TX packets:1333 errors:0 dropped:1079 overruns:0 carrier:0
>  >           collisions:0 txqueuelen:1024
>  >           RX bytes:228 (228.0 b)  TX bytes:302530 (295.4 Kb)
>  >
>  >
>  >
>  >
>  >
>  > -------------------------------------------------------
>  > SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
>  > 100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
>  > Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
>  > http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
>  > _______________________________________________
>  > tipc-discussion mailing list
>  > tipc-discussion@lists.sourceforge.net
>  > https://lists.sourceforge.net/lists/listinfo/tipc-discussion
> 
> 


-- 
// Randy MacLeod


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
