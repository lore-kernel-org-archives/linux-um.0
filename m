Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D9agu-0000Q3-Ch for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Mar 2005 19:19:56 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1D9agt-0003t7-Rc
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Mar 2005 19:19:56 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Re: tun/tap network throughput problem
References: <3524bf1f05030712562d547e1c@mail.gmail.com>
	<3524bf1f050308084246dc9341@mail.gmail.com>
	<87u0nm2fow.fsf@aka.i.naked.iki.fi>
In-Reply-To: <87u0nm2fow.fsf@aka.i.naked.iki.fi>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200503101239.11072.rob@landley.net>
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
Date: Thu, 10 Mar 2005 12:39:11 -0500
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Nuutti Kotivuori <naked@iki.fi>, Young Koh <young.koh@gmail.com>

On Tuesday 08 March 2005 12:46 pm, Nuutti Kotivuori wrote:

> With UDP, the userland program has no way to throttle itself or know
> how fast the network can send UDP packets. In there, saying sendto for
> the UDP packets, might return ENOBUFS, but from the manpage of
> sendto():
>
>   ENOBUFS
>          The output queue for a network interface was full.  This  gener-
>          ally  indicates  that the interface has stopped sending, but may
>          be caused by transient congestion.   (Normally,  this  does  not
>          occur  in Linux. Packets are just silently dropped when a device
>          queue overflows.)
>
> So, UDP send performance measures with packet drop are not really
> meaningful, since it all depends on how much time the userland process
> gets time and if that is more than what the network device can dish out.
>
> -- Naked

The logical thing to return for a temporary nonblocking congestion condition 
is -EAGAIN to indicate the packet was dropped, but retransmitting it should 
work.  (Client programs are free to ignore this, and if broken clients didn't 
ignore it and it screwed up existing implementations, possibly an extra open 
flag would be necessary to trigger it.)  Putting this in UML itself wouldn't 
help, but if the host kernel did this UML (and TCP in general) could throttle 
more sanely.

However, nobody's ever bothered to fix this because UDP is not a guaranteed 
protocol over the internet or hub-based ethernet.  Now that we've got 
switched ethernet (synchronous in the case of gigabit), packets are virtually 
never dropped over a LAN and it's possible that some infrastructure to not 
drop packets without remarking on it in the kernel's own packet handling 
layers is now worth the bother...

But I'm unlikely to personally code it up any time soon. :)

Rob


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
