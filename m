Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A53sn-0000uj-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 02 Oct 2003 06:52:41 -0700
Received: from cimice4.lam.cz ([212.71.168.94] helo=vagabond.light.src)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A53sl-0004GI-VS
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 02 Oct 2003 06:52:40 -0700
From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [uml-devel] Re: pthreads?
Message-ID: <20031002135220.GB5026@vagabond>
References: <20031002093128.GB3512@vagabond> <Pine.GSO.4.21.0310021146500.8567-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0310021146500.8567-100000@vervain.sonytel.be>
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
Date: Thu, 2 Oct 2003 15:52:20 +0200
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Gerd Knorr <kraxel@bytesex.org>, User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>

On Thu, Oct 02, 2003 at 12:03:10 +0200, Geert Uytterhoeven wrote:
> Hence _your_ simple application doesn't need libpthread.

Hence NEITHER OF GTK, GDK, GLIB, GMODULE, GOBJECT, PANGO, ATK, X11 NEED
libpthread!

> | gcc -Wl,-T,arch/um/uml.lds.s -static -Wl,--wrap,malloc -Wl,--wrap,free -Wl, --wrap,calloc  -o linux arch/um/main.o vmlinux -L/usr/lib -lutil -L/usr/X11R6/li b -lgtk -lgdk -lX11 -lXi -lXext -lglib -lgmodule -ldl -lm -lgthread

However if you link with gthread, you need pthread.
So: a) Please don't blame it on X11.
    b) Don't link against gthread unless you need them.
    b.1) If you only call Gtk stuff in one thread, you don't need them.
    b.2) If you call Gtk stuff from more than one thread, you can still
	 provide gthread library with custom locking and get rid of
	 pthread.

-------------------------------------------------------------------------------
						 Jan 'Bulb' Hudec <bulb@ucw.cz>


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
