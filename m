Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8hmo-0005XU-Oq for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Mar 2005 08:42:22 -0800
Received: from rproxy.gmail.com ([64.233.170.206])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D8hmo-0006ot-8v for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Mar 2005 08:42:22 -0800
Received: by rproxy.gmail.com with SMTP id z35so143273rne
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 08 Mar 2005 08:42:21 -0800 (PST)
Message-ID: <3524bf1f050308084246dc9341@mail.gmail.com>
From: Young Koh <young.koh@gmail.com>
Reply-To: Young Koh <young.koh@gmail.com>
Subject: Re: [uml-devel] Re: tun/tap network throughput problem
In-Reply-To: <87psya4btv.fsf@aka.i.naked.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <3524bf1f05030712562d547e1c@mail.gmail.com>
	<87psya4btv.fsf@aka.i.naked.iki.fi>
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
Date: Tue, 8 Mar 2005 11:42:20 -0500
To: Nuutti Kotivuori <naked@iki.fi>
Cc: user-mode-linux-devel@lists.sourceforge.net

Hi,
thank you for your reply.

> Remember to check the packet drop readings from inside the UML kernel
> as well as on all interfaces on the host side.

i checked the packet drop reading from UML kernel shell, but it still
shows no packet dropping.

>   watch -n1 tc -d -s qdisc show

so, i ran tc in the host machine as you suggested, and it reported
some packets are being dropped in eth0. (even though the stat from
/sbin/ifconfig still didn't report any packet drops)

$watch -n1 tc -d -s qdisc show
qdisc pfifo_fast 0: dev eth0 [Unknown qdisc, optlen=20]
 Sent 18300080724 bytes 13121666 pkts (dropped 1328688, overlimits 0)
 
 qdisc pfifo_fast 0: dev tap0 [Unknown qdisc, optlen=20]
 Sent 7664312 bytes 17650 pkts (dropped 0, overlimits 0)
---

i saw around 50,000 packet droppings out of around 240,000 packets.
then, i tried larger txqueues in eth0. as i configured with the larger
txqueue, the less packet droppings i got.

so, when i finally i assigned 50,000 for txqueuelen in the eth0. there
was no packet dropping. and the final rates are, sending rate =
~800Mbits, and receiving rate(in another machine) = ~650Mbits

it seems to me that UML was sending too fast for eth0 to handle, so
there were packet droppings because of the rate difference between
tap0 and eth0. hrmm.. is there any flow control between tap0 and eth0?
(i guess not, from the result, though)

even in host Linux kernel, how is flow control managed between native
Linux and eth0? i mean, what happens if (host) Linux kernel sends too
many packets(or socket buffers) to eth0 device?

thank you very much,

-Young
> 
> Since you are sending large packets, I would suggest making sure that
> all involved interfaces have large enough txqueues.
> 
> You can monitor queue buildup by:
> 
>   watch -n1 tc -d -s qdisc show
> 
> There should be no places for silent drops in the packet handling
> things - go around and try to find where the packets are dropping (or
> being queued forever).
> 
> -- Naked
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
