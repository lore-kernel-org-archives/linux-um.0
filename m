Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ebkab-0003CI-IK for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Nov 2005 12:06:05 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EbkaZ-0003Se-RI
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Nov 2005 12:06:05 -0800
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [uml-devel] Making UML Single Threader
In-Reply-To: <87veyvuhi0.fsf@amaterasu.srvr.nix>
Message-ID: <Pine.LNX.4.62.0511142103170.15023@numbat.sonytel.be>
References: <200511061723.32848.rob@landley.net>
	<20051108154618.GB4131@ccure.user-mode-linux.org>
	<87lkzrwcs3.fsf@amaterasu.srvr.nix>
	<200511142037.56022.blaisorblade@yahoo.it>
	<87veyvuhi0.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Mon, 14 Nov 2005 21:05:44 +0100 (CET)
To: Nix <nix@esperi.org.uk>
Cc: Blaisorblade <blaisorblade@yahoo.it>, User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>, Jeff Dike <jdike@addtoit.com>, Rob Landley <rob@landley.net>, Can Sar <csar@stanford.edu>

On Mon, 14 Nov 2005, Nix wrote:
> On Mon, 14 Nov 2005, blaisorblade@yahoo.it moaned:
> > On Monday 14 November 2005 14:59, Nix wrote:
> >> I've long wanted to do the same sort of thing,
> >> the kernel keeps 
> >> processing network packets and firewalling and bridging them perfectly
> >> well, but attackers now have *real* trouble changing the configuration.
> > 
> > _BLINK_ _BLINK_
> 
> That's what I thought when I first heard of it :)
> 
> > Is this a _documented_ feature 8-() ?
> 
> Not that I know of, but it's been true for a long, long time: before my
> firewall ran UML it used to rely on it, and it's the only feature that
> old firewall had that I'd still like to have back.
> 
> It's been true for longer than I've used Linux: Rogier Wolff describes
> it in
> <http://www.redhat.com/archives/linux-security/1997-April/msg00019.html>.
> The top of that thread has someone calling it a problem, and Alan Cox
> promptly follows up and calls it a feature. If Alan says that a feature
> of networking of that vintage is intentional I guess it counts as sort
> of documented. )

Yep, as long as interrupts are alife, networking keeps on working.

That's also the reason why sometimes you can still ping crashed boxes: as long
as interrupts are working, ping will work.

IIRC I read about the above scenario as an actually recommendation for a
safe firewall a long time ago...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
