Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A8FHl-0003dP-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 11 Oct 2003 01:39:37 -0700
Received: from [80.88.36.193] (helo=witte.sonytel.be)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A8FHl-0008Ed-3F
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 11 Oct 2003 01:39:37 -0700
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: The Story Continues (was: Re: [uml-devel] Re: pthreads?) 
In-Reply-To: <200310110148.h9B1mp4f006913@ccure.karaya.com>
Message-ID: <Pine.GSO.4.21.0310111038560.26752-100000@starflower.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Sat, 11 Oct 2003 10:39:28 +0200 (MEST)
To: Jeff Dike <jdike@addtoit.com>
Cc: User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>

On Fri, 10 Oct 2003, Jeff Dike wrote:
> geert@linux-m68k.org said:
> >     Kernel panic: Segfault with no mm
> > when GTK calls my expose handler and I call gdk_draw_indexed_image()
> > to update the window contents.
> >
> > If I run the image under gdb, it crashes even earlier in gtk_init()
> > with
> >
> >     Kernel panic: Kernel mode signal 5 
> 
> The mere act of running it under gdb causes this, or did you set some 
> breakpoints?

No breakpoint, just plain session under gdb.

> As an arch maintainer, I bet you're aware of this, but somehow, UML is getting
> a SIGTRAP that gdb isn't expecting.  Setting breakpoints in tricky ways can
> do this.
> 
> > Anyone with a clue how to investigate such behavior? Thx! 
> 
> You might stick an infinite loop after the panic string is printed.  Then
> attach gdb to UML then.  At least you'll get a stack trace from the panic.

Thanks! I'll try that.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
