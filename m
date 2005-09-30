Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ELN4K-0005Ui-8a	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Sep 2005 08:45:04 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1ELN4D-0000wB-C0
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Sep 2005 08:45:04 -0700
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [uml-devel] a question about sigsetjmp() in copy_from/to_user()
In-Reply-To: <3524bf1f0509300808scdb25acga0e2bc9f8fd9008c@mail.gmail.com>
Message-ID: <Pine.LNX.4.62.0509301744080.9170@numbat.sonytel.be>
References: <3524bf1f050927070645b999bd@mail.gmail.com> 
	<3524bf1f0509281225180173ae@mail.gmail.com>
	<3524bf1f0509300808scdb25acga0e2bc9f8fd9008c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Fri, 30 Sep 2005 17:44:36 +0200 (CEST)
To: Young Koh <young.koh@gmail.com>
Cc: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

On Fri, 30 Sep 2005, Young Koh wrote:
> > > it seems that sigsetjmp() has
> > > relatively large overhead, we could reduce some overhead by not
> > > calling it.
> >
> > How do you measure it? I'm curious myself - I know there's the possibility to
> > use gprof, but I've never used that myself.
> 
> i usually use pentium rdtsc(read time stamp counter) to measure the
> timing and latency. (sometimes by instrumenting kernel or sometimes by
> measuring test programs) i ran a test program and measured the
> overhead of sigsetjmp() and setjmp(). it showed sigsetjmp() uses
> around 1350 cycles (which is around 0.45 us in 3.0GHz machine), and
> setjmp() only 21 cycles (< 0.01us). maybe while sigsetjmp() is
> implemented as a system call to cope with signal blocking/unblocking,
> setjmp() is not a system call? (getpid() itself takes more than 1000
> cycles)

Indeed, setjmp() is not a system call. It just saves the registers to the
passed env structure.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
