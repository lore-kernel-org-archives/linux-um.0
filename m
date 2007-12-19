Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J4u14-0003eA-U7 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 Dec 2007 00:10:59 -0800
Received: from monty.telenet-ops.be ([195.130.132.56])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1J4u12-0007gN-AZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 Dec 2007 00:10:57 -0800
Date: Wed, 19 Dec 2007 09:10:46 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
In-Reply-To: <200712181803.28516.rob@landley.net>
Message-ID: <Pine.LNX.4.64.0712190908500.24841@anakin>
References: <200712181245.23753.rob@landley.net>
	<20071218192911.GA7940@c2.user-mode-linux.org>
	<200712181803.28516.rob@landley.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-1463808512-102698745-1198051846=:24841"
Subject: Re: [uml-devel] Loopback mounting jffs2 under UML?
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Rob Landley <rob@landley.net>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463808512-102698745-1198051846=:24841
Content-Type: TEXT/PLAIN; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 18 Dec 2007, Rob Landley wrote:
> On Tuesday 18 December 2007 13:29:11 Jeff Dike wrote:
> > On Tue, Dec 18, 2007 at 12:45:23PM -0600, Rob Landley wrote:
> > > There's a way to make a loopback device look like a flash device, letting
> > > you loopback mount jffs2, but it involves recompiling the kerenel to add
> > > support for it, and of course I went "User Mode Linux"...  Except
> > > that UML disables  the flash menu entirely.
> > >
> > > Suggestions?
> >
> > I see this in menuconfig:
> >
> > Symbol: MTD [=n]

> Actually, in -rc4 (what I have lying around), the depends is just on HAS_IOMEM, and the include in arch/um/Kconfig is guarded by "if BROKEN".

> >   CC      drivers/mtd/chips/chipreg.o
> > In file included from drivers/mtd/chips/chipreg.c:13:
> > include/linux/mtd/map.h: In function ‘inline_map_read’:
> > include/linux/mtd/map.h:378: error: implicit declaration of function
> > ‘__raw_readb’ include/linux/mtd/map.h:380: error: implicit declaration of
> > function ‘__raw_readw’ include/linux/mtd/map.h:382: error: implicit
> > declaration of function ‘__raw_readl’ include/linux/mtd/map.h:385: error:
> > implicit declaration of function ‘__raw_readq’ include/linux/mtd/map.h:388:
> > error: implicit declaration of function ‘memcpy_fromio’
> > include/linux/mtd/map.h: In function ‘inline_map_write’:
> > include/linux/mtd/map.h:406: error: implicit declaration of function
> > ‘memcpy_toio’ make[3]: *** [drivers/mtd/chips/chipreg.o] Error 1
> > make[2]: *** [drivers/mtd/chips] Error 2
> > make[1]: *** [drivers/mtd] Error 2

Protect all static inline routines in <linux/mtd/map.h> that use readb()
and friends by #ifdef CONFIG_HAS_IOMEM?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
---1463808512-102698745-1198051846=:24841
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services
for just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
---1463808512-102698745-1198051846=:24841
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

---1463808512-102698745-1198051846=:24841--

