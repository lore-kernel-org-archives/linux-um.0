Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A4zhr-00064a-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 02 Oct 2003 02:25:07 -0700
Received: from mail2.sonytel.be ([195.0.45.172] helo=witte.sonytel.be)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A4zhq-0007X7-Ps
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 02 Oct 2003 02:25:06 -0700
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [uml-devel] Re: pthreads?
In-Reply-To: <20031002090834.GS24534@vagabond>
Message-ID: <Pine.GSO.4.21.0310021112020.8567-100000@vervain.sonytel.be>
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
Date: Thu, 2 Oct 2003 11:24:11 +0200 (MEST)
To: Jan Hudec <bulb@ucw.cz>
Cc: Gerd Knorr <kraxel@bytesex.org>, User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>

On Thu, 2 Oct 2003, Jan Hudec wrote:
> On Fri, Sep 12, 2003 at 11:07:54 +0200, Geert Uytterhoeven wrote:
> > BTW, it's libX11 that needs libpthread...
> 
> bulb@vagabond:~$ ldd /usr/X11R6/lib/libX11.so.6.2 
> 	libdl.so.2 => /lib/libdl.so.2 (0x400d5000)
> 	libc.so.6 => /lib/libc.so.6 (0x400d8000)
> 	/lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0x80000000)
> 
> Not see libpthread anywhere around!
> 
> However, I just checked gmodule and glib and neither seems to report
> libpthread either!

ldd instead doesn't show it, but nm does:

| tux$ nm -g /usr/X11R6/lib/libX11.a | grep pthre
|          U pthread_equal
|          U pthread_cond_broadcast
|          U pthread_cond_destroy
|          U pthread_cond_init
|          U pthread_cond_signal
|          U pthread_cond_wait
|          U pthread_equal
|          U pthread_mutex_destroy
|          U pthread_mutex_init
|          U pthread_mutex_lock
|          U pthread_mutex_unlock
|          U pthread_self
| tux$ 

as does strings:

| tux$ strings /usr/X11R6/lib/libX11.so | grep pthr
| pthread_equal
| pthread_self
| pthread_mutex_lock
| pthread_mutex_unlock
| pthread_mutex_init
| pthread_mutex_destroy
| pthread_cond_init
| pthread_cond_destroy
| pthread_cond_wait
| pthread_cond_signal
| pthread_cond_broadcast
| tux$ 

| tux$ dpkg -l | grep xlibs
| ii  xlibs          4.1.0-16woody1 X Window System client libraries
| ii  xlibs-dev      4.1.0-16woody1 X Window System client library development f

BTW, during my investigation I found out that between glibc 2.3.1 and 2.3.2 the
mechanism to override sigaction and some syscalls in libpthread was modified.

In 2.3.1 libpthread just overrides the libc symbol (e.g. sigaction, open).
In 2.3.2 libpthread defines e.g. __pthread_sigaction, and libc uses the weak
symbol __pthread_sigaction to find out whether it has to use its internal
implementation __libc_sigaction, or call libpthread's __pthread_sigaction.

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
