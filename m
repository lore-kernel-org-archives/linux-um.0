Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1By9Ez-0004hp-Fz for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Aug 2004 06:15:33 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1By9Ey-0000xo-3s for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Aug 2004 06:15:32 -0700
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [uml-devel] [ann] kraxel's 2.6.8 uml patch kit
In-Reply-To: <20040820122445.GA21790@bytesex>
Message-ID: <Pine.GSO.4.58.0408201512300.6741@waterleaf.sonytel.be>
References: <20040820122445.GA21790@bytesex>
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
Date: Fri, 20 Aug 2004 15:14:55 +0200 (MEST)
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Jeff Dike <jdike@addtoit.com>, uml devel <user-mode-linux-devel@lists.sourceforge.net>

On Fri, 20 Aug 2004, Gerd Knorr wrote:
> What is the status if the umlfb/x11/pthread issue, i.e. uml
> kernel crashing as soon as one tries to link against libpthread
> (which is needed for libX11)?  Any progress here?

Use SKAS mode, not TT, so UML is dynamically linked and libpthread is not
needed. But no further progress since my last mail on August 2 (which you may
have missed due to being abroad, check the archives).

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
