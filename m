Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19xTmq-0005G7-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 11 Sep 2003 08:55:12 -0700
Received: from mail2.sonytel.be ([195.0.45.172] helo=witte.sonytel.be)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19xTmq-0003wZ-0Q
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 11 Sep 2003 08:55:12 -0700
From: Geert Uytterhoeven <geert@linux-m68k.org>
Message-ID: <Pine.GSO.4.21.0309111733190.1879-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] pthreads?
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
Date: Thu, 11 Sep 2003 17:54:34 +0200 (MEST)
To: User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>

	Hi,

I'm working on a virtual frame buffer device for UML that displays in a GDK/GTK
window. The GDK/GTK frame buffer device works fine as a standalone application,
but when compiled into the kernel things get more challenging.

GTK needs GDK, X11, ..., and finally I need libpthread.

As soon as I link the final image with -lpthread (even if it's not
used/referenced anywhere else), the resulting image no longer boots, but hangs
very soon. This is easily reproducible by doing:

| tux$ gcc -Wl,-T,arch/um/uml.lds.s -static -Wl,--wrap,malloc -Wl,--wrap,free -Wl,--wrap,calloc -o linux arch/um/main.o vmlinux -L/usr/lib -lutil -lpthread
| tux$ ./linux
| Checking for the skas3 patch in the host...not found
| Checking for /proc/mm...not found
| capture_stack : Expected SIGSTOP, got status = 0xb7f
| tux$ ./linux debug
| Checking for the skas3 patch in the host...not found
| Checking for /proc/mm...not found
| capture_stack : Expected SIGSTOP, got status = 0xb7f
| tux$ 

Does anyone have a solution for this?

Perhaps I have to `wrap' some symbols from libpthread?
I noticed libpthread implements e.g. longjmp(), sigaction(), sigwait(), ...

Or don't link with libpthread and implement the required pthread functionality
myself in term of kernel threads and synchronization primitives? I seem to need
at least these:

    pthread_cond_init
    pthread_cond_destroy
    pthread_cond_broadcast
    pthread_cond_signal
    pthread_cond_timedwait
    pthread_cond_wait
    pthread_setspecific
    pthread_getspecific
    pthread_key_create
    pthread_mutex_init
    pthread_mutex_destroy
    pthread_mutex_lock
    pthread_mutex_trylock
    pthread_mutex_unlock
    pthread_equal

Thanks for your suggestions!

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
