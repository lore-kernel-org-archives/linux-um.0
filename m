Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8inU-00015f-Re for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Mar 2005 09:47:08 -0800
Received: from gw02.mail.saunalahti.fi ([195.197.172.116])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D8inU-0006S0-0n for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Mar 2005 09:47:08 -0800
Subject: Re: [uml-devel] Re: tun/tap network throughput problem
References: <3524bf1f05030712562d547e1c@mail.gmail.com>
	<87psya4btv.fsf@aka.i.naked.iki.fi>
	<3524bf1f050308084246dc9341@mail.gmail.com>
From: Nuutti Kotivuori <naked@iki.fi>
Message-ID: <87u0nm2fow.fsf@aka.i.naked.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: Tue, 08 Mar 2005 19:46:55 +0200
To: Young Koh <young.koh@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Young Koh wrote:
> it seems to me that UML was sending too fast for eth0 to handle, so
> there were packet droppings because of the rate difference between
> tap0 and eth0. hrmm.. is there any flow control between tap0 and
> eth0?  (i guess not, from the result, though)

Yes, that seems to be the correct assumption - eth0 is dropping the
packets. However, there is no 'rate difference' between tap0 and
eth0. Packets are queued from inside the UML kernel, to the internal
eth0 interface there (there's a packet queue there). Then they pop up
from tap0 on the host side and are synchronously queued to eth0
queue. From there on, they are queued onwards by eth0 hard_start_xmit,
which gets triggered from the interrupts. So there are two queues at
work here, the inside the UML kernel eth0 queue, and the host kernel
eth0 queue - of which the queue inside the UML kernel is faster and
apparently never drops packets.

And you are correct - there's nothing to limit the speed of packets
queued from inside the UML kernel to the speed that host side eth0
might accept them.

> even in host Linux kernel, how is flow control managed between
> native Linux and eth0? i mean, what happens if (host) Linux kernel
> sends too many packets(or socket buffers) to eth0 device?

All sent packets are added to eth0 queue. Eth0 queue is depleted by
hard_start_xmits triggered by interrupts (or other things, depending
on the driver). If too many packets are enqueued to eth0 queue, the
packets are being dropped.

If Linux tc is involved in limiting the queue speed at eth0, it merely
throttles the speed of packets received by the network card - all
packets are still queued at the same speed to eth0 queue.

In general, there's nothing to limit how many packets get queued to
the interface queue - if something sends a million packets, that is
how many packets are queued to the interface. However, for TCP, there
are two things at work. First of all is ofcourse the fact that TCP
will automatically throttle itself to the network speed. This one
works with UML as well. Second issue is that the kernel will throttle
TCP queues if they start taking too much memory, even before any
network device queues are filled. This will only work if the TCP
connection originates from the host machine - eg. not with UML.

With UDP, the userland program has no way to throttle itself or know
how fast the network can send UDP packets. In there, saying sendto for
the UDP packets, might return ENOBUFS, but from the manpage of
sendto():

  ENOBUFS
         The output queue for a network interface was full.  This  gener-
         ally  indicates  that the interface has stopped sending, but may
         be caused by transient congestion.   (Normally,  this  does  not
         occur  in Linux. Packets are just silently dropped when a device
         queue overflows.)

So, UDP send performance measures with packet drop are not really
meaningful, since it all depends on how much time the userland process
gets time and if that is more than what the network device can dish out.

-- Naked


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
