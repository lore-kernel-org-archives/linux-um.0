Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A88pn-0005xt-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 10 Oct 2003 18:46:19 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A88pm-0001Pw-EJ
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 10 Oct 2003 18:46:18 -0700
Received: from ccure.karaya.com (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id h9B1Zkj24405
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 10 Oct 2003 21:35:47 -0400
Message-Id: <200310110148.h9B1mp4f006913@ccure.karaya.com>
Subject: Re: The Story Continues (was: Re: [uml-devel] Re: pthreads?) 
In-Reply-To: Your message of "Tue, 07 Oct 2003 17:51:20 +0200."
             <Pine.GSO.4.21.0310071735310.2653-100000@waterleaf.sonytel.be> 
References: <Pine.GSO.4.21.0310071735310.2653-100000@waterleaf.sonytel.be> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Fri, 10 Oct 2003 21:48:51 -0400
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>

geert@linux-m68k.org said:
>     Kernel panic: Segfault with no mm
> when GTK calls my expose handler and I call gdk_draw_indexed_image()
> to update the window contents.
>
> If I run the image under gdb, it crashes even earlier in gtk_init()
> with
>
>     Kernel panic: Kernel mode signal 5 

The mere act of running it under gdb causes this, or did you set some 
breakpoints?

As an arch maintainer, I bet you're aware of this, but somehow, UML is getting
a SIGTRAP that gdb isn't expecting.  Setting breakpoints in tricky ways can
do this.

> Anyone with a clue how to investigate such behavior? Thx! 

You might stick an infinite loop after the panic string is printed.  Then
attach gdb to UML then.  At least you'll get a stack trace from the panic.

				Jeff



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
