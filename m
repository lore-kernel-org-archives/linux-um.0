Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1Vm3oJ-0001Ur-BB
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Nov 2013 15:47:23 +0000
Received: from b.ns.miles-group.at ([95.130.255.144] helo=radon.swed.at)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Vm3oH-0008E2-IC
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Nov 2013 15:47:23 +0000
From: Richard Weinberger <richard@nod.at>
Date: Thu, 28 Nov 2013 16:47:13 +0100
Message-ID: <11957281.y1PM5USAYd@sandpuppy>
In-Reply-To: <529755F0.80509@panasas.com>
References: <529755F0.80509@panasas.com>
MIME-Version: 1.0
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] x86_64 when mem > 384M loadable modules do not work
To: Boaz Harrosh <bharrosh@panasas.com>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Am Donnerstag, 28. November 2013, 16:40:48 schrieb Boaz Harrosh:
> Hi um hackers
> 
> I'm using an x86_64 deployment both host and um-guest.
> (Fedora 18)
> 
> When I load with mem=384M all is well but anything bigger will
> eventually give me problems because loadable modules will no
> longer load. The bigger mem= is, the earlier it will start.
> 
> When the Kernel tries to load the .ko driver I get these messages:
> 
> subarch: overflow in relocation type 11 val 805b1e40
> subarch: `nfsv4' likely not compiled with -mcmodel=kernel
> subarch: overflow in relocation type 11 val 806e4ca0
> subarch: `nfsv3' likely not compiled with -mcmodel=kernel
>    ...
> 
> (The first print is always around that same number
>  805b1e40 independent of the mem= (> 384M)
> )
> 
> Do you guys see the same problem? I'm using loadable modules
> because it is kind of mandatory for the kind of development I
> do.
> 
> Please help because 384M is not enough for me anymore, even
> when I define a swap device for the uml to use.

/me has a deja vu.
I've fixed that issue some time ago.

Let's see why it happens again. :)

Thanks,
//richard

------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349351&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

