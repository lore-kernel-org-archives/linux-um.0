Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19xmsV-0001br-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 12 Sep 2003 05:18:19 -0700
Received: from mail2.sonytel.be ([195.0.45.172] helo=witte.sonytel.be)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19xmsU-0000N5-Q6
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 12 Sep 2003 05:18:18 -0700
From: Geert Uytterhoeven <geert@linux-m68k.org>
In-Reply-To: <20030912121525.GA16925@bytesex.org>
Message-ID: <Pine.GSO.4.21.0309121412170.2490-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] Re: pthreads?
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 12 Sep 2003 14:17:41 +0200 (MEST)
To: Gerd Knorr <kraxel@bytesex.org>
Cc: User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>

On Fri, 12 Sep 2003, Gerd Knorr wrote:
> >   - The visual type (it's in fb_fix_screeninfo, so the user cannot specify it)
> >   - The frame buffer layout (it's in fb_fix_screeninfo), to e.g. debug code for
> >     bitplanes
> 
> Uh?  Can a fb driver change them without fbcon becoming greatly confused?  I think
> it is in fix for a reason ...

You cannot change them immediately, but if the changes would take effect on the
next mode change it should work just fine.

> > GdkRgb allows to easily draw 8 bpp pseudocolor or grayscale, and 24 or 32 bpp
> > RGB, and display it on whatever X server you have available.
> 
> For debugging various modes that makes sense, althrough it probably
> isn't exactly fast ...

You'd be surprised. At work I wrote an emulator for the graphics of a Set Top
Box chip, which alpha blended various layers in different modes together.
Redraw was done only if a particular region of the screen was changed. It was
very usable, unless you drew individual pixels.

For UML and fbdev user space I have to update the whole screen at regular time
intervals, so it can be a bit slower. For UML and fbdev kernel space I can
update the screen when it's redrawn, thanks to James' new drawing primitives in
2.6.0.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
