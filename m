Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AYoD6-0001DS-RS
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 23 Dec 2003 07:12:36 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AYoD6-0003WJ-BA
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 23 Dec 2003 07:12:36 -0800
Received: from waterleaf.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id hBNFCWQG010837
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 23 Dec 2003 16:12:32 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Message-ID: <Pine.GSO.4.58.0312231524380.1139@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] early setup
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 23 Dec 2003 16:12:33 +0100 (MET)
To: User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>


From time to time I continue my work on gdkfb, a frame buffer device for UML
using GTK/X11...

It appears that just calling the GTK initialization routine gtk_init_check()
during kernel init causes UML to crash later, while user space is already
running. A reliable way to crash it is reading anything in /proc:

| (none):~# cat /proc/mounts
| Kernel panic: Kernel mode fault at addr 0x890856a3, ip 0x400d9304

Which is inside libgtk:

| tux$ ldd linux
|         libutil.so.1 => /lib/libutil.so.1 (0x40018000)
|         libgtk-1.2.so.0 => /usr/lib/libgtk-1.2.so.0 (0x4002a000)
|         libgdk-1.2.so.0 => /usr/lib/libgdk-1.2.so.0 (0x40148000)
|         libX11.so.6 => /usr/X11R6/lib/libX11.so.6 (0x4017c000)
|         libXi.so.6 => /usr/X11R6/lib/libXi.so.6 (0x40243000)
|         libXext.so.6 => /usr/X11R6/lib/libXext.so.6 (0x4024b000)
|         libglib-1.2.so.0 => /usr/lib/libglib-1.2.so.0 (0x40259000)
|         libgmodule-1.2.so.0 => /usr/lib/libgmodule-1.2.so.0 (0x4027a000)
|         libdl.so.2 => /lib/libdl.so.2 (0x4027d000)
|         libm.so.6 => /lib/libm.so.6 (0x40281000)
|         libc.so.6 => /lib/libc.so.6 (0x402a3000)
|         /lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0x40000000)
| tux$

Running UML in gdb doesn't help much, UML just quits and setting a break point
doesn't work (can I single-step automatically until the PC is at 0x400d9304 so
I can get a backtrace?).

On the other hand, if I call gtk_init_check() really early (from a
__uml_setup() routine), UML works fine!

Any good reason why?  I'm using SKAS mode, since TT gave me even more headaches
(cfr. the libpthread problem from a few months ago).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
