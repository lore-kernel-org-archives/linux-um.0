Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BzGw0-0003z7-94 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 23 Aug 2004 08:40:36 -0700
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34) id 1BzGvz-0004j8-IM
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 23 Aug 2004 08:40:36 -0700
Subject: Re: [uml-devel] gdkfb
References: <Pine.LNX.4.58.0408021210420.23627@anakin>
From: Gerd Knorr <kraxel@bytesex.org>
In-Reply-To: <Pine.LNX.4.58.0408021210420.23627@anakin>
Message-ID: <87isb9yjfj.fsf@bytesex.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: 23 Aug 2004 17:15:44 +0200
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>


  Hi,

My framebuffer experiments reached a usable state now as well.  The
patch should show up shortly at:

        http://www.suse.de/~kraxel/uml/patches/

The terminal cleanup patch is updated as well, see comments below.

Geert Uytterhoeven <geert@linux-m68k.org> writes:
> Attached is a patch to implement a very preliminary frame buffer device
> on top of GTK/GDK, as some of you may have seen at OLS.

Mine runs directly on libX11, without any GUI toolkit involved (and
stealing ENTER keys ;)

>   - Resolution is fixed to 640x480, 256 colors.

Size is configurable at boot time.  Runs on TrueColor displays only.
Screen parameters are passed through, i.e. if your X11 display is
16bpp the fb device inside the uml machine will have 16bpp as well, so
I don't have to convert any data ;)

>   - It uses 2 threads: one for handling widget events, and another one to
>     update the screen every second.  Calling the update routines from
>     gdkfb_kern.c when the screen contents are changed using
>     fillrect/copyarea/imgblt didn't work.

One thread for the communication with the X-Server, any events (fb
updates, data on the X11 socket) will wake up that thread to handle
it.  Screen updates can happen much more often than once per second.
Only changed screen areas will be updated.

>   - Console and penguin logo (special UML logo) works.

Same here (no special logo through).

>   - Userspace access to the frame buffer doesn't work yet.

Same here.  Havn't even looked at that yet.  The memory block for the
framebuffer is either simply malloced or a shared memory segment,
depending on whenever sharing memory with the X-Server works or not
(MIT-SHM Extention).

Q1: Can I map that into the address space of a uml process?
Q2: Any chance to track the changes (using page faults maybe?),
    so I can do more clever screen updates than simply blitting
    the whole screen now and then?

>   - It works (usually ;-) on my Mobile Pentium III laptop (both 2.4.24+SKAS and
>     2.6.7+SKAS hosts, custom config). I get a window where I can enter
>     commands. Pressing some keys may make it crash.

I've tested it on one machine only.

>         ./linux ubd0=/home/geert/uml/root_fs init=/bin/bash console=stderr \
> 	    console=tty0  gdkfb

linux console=tty0 x11=800x600

>   - It needs SKAS, since TT creates a statically linked image (libX11 needs
>     libpthread when statically linked, and UML crashes when just linked with
>     libpthread)

Same here ;)

>   - The patch includes Gerd Knorr's (a pity I didn't manage to find you at
>     OLS!) clean up of the console/terminal code, with some modifications:
>       o I modified the stdio console (which you don't need for gdkfb) not to
>         panic if it cannot register its console, since it conflicts with the
> 	normal CONFIG_VT console subsystem.

The updated patch does that as well now.  There seems to be no way to
switch at runtime between the stdio console and the vt subsystem, if
vt is enabled it is registered for /dev/tty<n> unconditionally, even
without any console driver being activated (no dummy console, no
fbcon).

>       o I moved the stderr console to a separate file with its own config
>         option CONFIG_STDERR_CONSOLE, so you can use it even if
> 	CONFIG_STDIO_CONSOLE is disabled.

Updated the terminal patch to do that as well.  I've also swapped
ssl.o and stdio_console.o in the Makefile to fixup the link order,
thus the stdio console is registered first and becomes the default
console as long as the users don't enable the new config options.

If CONFIG_STDERR_CONSOLE is enabled it will allways be the default
console through as it registeres _very_ early.  CONFIG_VT will
conflict with the stdio_console as well (see above).  Note that you
have to enable CONFIG_EMBEDDED if you want to disable CONFIG_VT.

Jeff, is that good enougth for backward compatibility?

Not sure how to handle that best in the long run.  IMHO we should
simply drop the stdio_console.

  Gerd

-- 
return -ENOSIG;


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
