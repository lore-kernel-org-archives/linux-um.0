Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EZeuZ-0005bb-Sw for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Nov 2005 17:38:03 -0800
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EZeuY-0005Nf-Dq
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Nov 2005 17:38:04 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Test for ethernet broadcast address?
References: <200511081913.14657.rob@landley.net>
In-Reply-To: <200511081913.14657.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511090244.52916.blaisorblade@yahoo.it>
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
Date: Wed, 9 Nov 2005 02:44:52 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Rob Landley <rob@landley.net>

On Wednesday 09 November 2005 02:13, Rob Landley wrote:
> So I'm trying to play with ifenslave under UML, and my naieve attempt to go
>
> ./linux LD_ASSUME_KERNEL=2.4.1 eth0=daemon,11:11:11:11:11:11 \
> eth1=daemon,22:22:22:22:22:22 rootfstype=hostfs rw init=/bin/sh
>
> Led to unexpected results that eth0 had a mac addr of 00:00:00:00:00:00.
> Eventually, I tracked it down to this test in arch/um/drivers/net_kern.c:
> if(addr[0] & 1){
>         printk(KERN_ERR
>                "Attempt to assign a broadcast ethernet address to a "
>                "device disallowed\n");
>         return(0);
> }
>
> My question is: where's the spec for what is and isn't a broadcast address?

Don't know what Jeff means, but he and UML consistently says "first byte odd 
<-> broadcast". That's even coded above.

Don't ask me what exaclty he means. ^H^H^H^H

Ouch, I have the vice to understand things. So I went to the RFC, I spent 
enough time on them, and I understood they're not the Ethernet specification 
(the real spec is the DIX one, and later IEEE ones).

They're way too short!

But quoting from your link to ethereal's wiki:

"A destination MAC address of ff:ff:ff:ff:ff:ff indicates a Broadcast, meaning 
the packet is sent from one host to any other on that network. 

<<<<<<<<<<<<<<<<<<<<<
A destination MAC address where the low-order bit of the first byte is set
<<<<<<<<<<<<<<<<<<<<<
 indicats a Multicast, meaning the packet is sent from one host to all hosts 
on the network interested in packets sent to that MAC address. A number of 
multicast addresses have been assigned; see Ethernet numbers at the IANA, 
Michael A. Patton's list of multicast addresses, and Ethereal's list of 
Ethernet vendor codes and well-known MAC addresses, from the Ethereal source 
distribution, for assigned multicast addresses."

So. UML is not exact technically, but it's enough for our purposes. Don't know 
whether it may make sense to assign a multicast address to an iface, but I 
guess it's more complicate.

Anyway, complete references and patches (or indications about what to code) 
are always welcome.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
