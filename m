Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ByGab-0005PF-59 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Aug 2004 14:06:21 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1ByGaZ-0007GL-G7 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Aug 2004 14:06:21 -0700
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [uml-devel] Re: [ann] kraxel's 2.6.8 uml patch kit
In-Reply-To: <200408201901.i7KJ1eIF003843@ccure.user-mode-linux.org>
Message-ID: <Pine.GSO.4.58.0408202303460.16715@waterleaf.sonytel.be>
References: <20040820122445.GA21790@bytesex>
	<200408201901.i7KJ1eIF003843@ccure.user-mode-linux.org>
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
Date: Fri, 20 Aug 2004 23:05:56 +0200 (MEST)
To: Jeff Dike <jdike@addtoit.com>
Cc: Gerd Knorr <kraxel@bytesex.org>, uml devel <user-mode-linux-devel@lists.sourceforge.net>

On Fri, 20 Aug 2004, Jeff Dike wrote:
> kraxel@bytesex.org said:
> > uml-terminal-cleanup
> > 	tty / console handling cleanups.  The patchfile itself has a long
> > 	description.
>
> I like this one, but it's big and I'm going to have to take a good look at it.
> I'm somewhat unhappy about the command line change, where you need to specify
> a console or UML doesn't boot.  That'll break everyone's scripts.  Is it
> possible to provide a default console if there isn't one on the command line?

IIRC, the default console is the one that gets registered first. So by
reordering the code (in source files) and/or objects (in Makefiles) you can
make sure the correct one is the default.

BTW, what do you think of putting the stderr console in its own source file
with its own CONFIG_* option?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
