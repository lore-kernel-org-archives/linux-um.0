Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19yCHB-0005Gs-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 13 Sep 2003 08:25:29 -0700
Received: from mail2.sonytel.be ([195.0.45.172] helo=witte.sonytel.be)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19yCHA-0003TE-OV
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 13 Sep 2003 08:25:28 -0700
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [uml-devel] Re: pthreads? 
In-Reply-To: <200309121628.h8CGSce4002665@ccure.karaya.com>
Message-ID: <Pine.GSO.4.21.0309131710100.2634-100000@vervain.sonytel.be>
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
Date: Sat, 13 Sep 2003 17:24:31 +0200 (MEST)
To: Jeff Dike <jdike@addtoit.com>
Cc: User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>

On Fri, 12 Sep 2003, Jeff Dike wrote:
> hno@marasystems.com said:
> > What about running the X11 stuff in a helper and using mmap to map the
> > framebuffer data in both the UML and the helper process? 
> 
> I'm not going to Geert how to do this, but I would like to see everything in 
> one process.  The reason is that I have fond hopes of turning UML into a
> library, libUML.so, which can be used by any app that needs anything provided
> by the kernel.
> 
> So, if this is going to happen, libUML needs to be compatible with everything
> else out there, and this is one step in that direction.
> 
> So, my preference would be to figure out what the incompatibility between
> UML and pthreads is, and fix UML.  And I'll provide whatever help is needed
> to sort this out.

I compiled my own libpthreads, so I can easily remove code from it and see what
happens.

First step: libpthread redefines sigaction to install its own signal handler
around the signal. If I remove this, UML runs until:

| Initializing stdio console driver

and quits without any further messages. If I try to run it under gdb, gdb
crashes immediately with a segmentation fault.

I'll be doing some more digging...

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
