Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A8cut-0001LC-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 12 Oct 2003 02:53:35 -0700
Received: from [80.88.36.193] (helo=witte.sonytel.be)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A8cus-000114-HY
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 12 Oct 2003 02:53:34 -0700
Received: from starflower.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id h9C9rMQG025446
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 12 Oct 2003 11:53:23 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: The Story Continues (was: Re: [uml-devel] Re: pthreads?)
In-Reply-To: <Pine.GSO.4.21.0310071735310.2653-100000@waterleaf.sonytel.be>
Message-ID: <Pine.GSO.4.21.0310121145120.27309-100000@starflower.sonytel.be>
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
Date: Sun, 12 Oct 2003 11:53:22 +0200 (MEST)
To: User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>

On Tue, 7 Oct 2003, Geert Uytterhoeven wrote:
> Since TT implies static linking, I started using SKAS mode only. I applied the
> SKAS patch to my host kernel (2.4.21).
> 
> Now my UML (2.6.0-test5-1) boots until initialization of my GTK/GDK frame
> buffer device. During initialization, it opens a GTK window for a fraction of a
> second, and crashes with
> 
>     Kernel panic: Segfault with no mm
> 
> when GTK calls my expose handler and I call gdk_draw_indexed_image() to update
> the window contents.

Doh, turns out this was a NULL pointer dereference in my code...

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
