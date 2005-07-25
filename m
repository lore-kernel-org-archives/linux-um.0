Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dx6dV-0007mD-NH	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Jul 2005 10:21:05 -0700
Received: from nepa.nlc.no ([195.159.31.6] ident=qmailr)
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1Dx6dU-00055I-4B
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Jul 2005 10:21:05 -0700
Message-ID: <42036.85.166.82.153.1122312057.squirrel@85.166.82.153>
In-Reply-To: <6048.1122248129@marajade.sandelman.ottawa.on.ca>
References: <6048.1122248129@marajade.sandelman.ottawa.on.ca>
Subject: Re: [uml-devel] multicast on loopback: mcast networking at the 
     cottage
From: stian@nixia.no
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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
Date: Mon, 25 Jul 2005 19:20:57 +0200 (CEST)
To: Michael Richardson <mcr@sandelman.ottawa.on.ca>
Cc: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>, netdev@oss.sgi.com

> I suspect that for people who want to do multicast between hosts on an
> actual wire won't want to have just a route to lo, they may want a route
> for 224.0.0.0/4 on all of their interfaces.  Maybe that should be
> automatic?
>
> I think that applications that are multicast aware are supposed to
> figure out which interfaces that they want to bind to anyway, so they
> should not be confused by the multiple routes.

If I remember things right (I might be wrong here):

ipv6 does this automatically, so should ipv4 have done too if multicast is
supported on a device. Multicast aware programs should always bind to a
device, or broadcast on all devices for discovery.

This is not uml-specific, but vanilla kernel. Some distroes add
multicast-routing for ipv4 during init scripts.


Stian


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
