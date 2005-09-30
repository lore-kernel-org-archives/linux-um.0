Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ELMw1-000513-20	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Sep 2005 08:36:29 -0700
Received: from qproxy.gmail.com ([72.14.204.204])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1ELMw0-0006Ao-Sk
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Sep 2005 08:36:29 -0700
Received: by qproxy.gmail.com with SMTP id a33so120614qbd
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 30 Sep 2005 08:35:37 -0700 (PDT)
Message-ID: <3524bf1f0509300808scdb25acga0e2bc9f8fd9008c@mail.gmail.com>
From: Young Koh <young.koh@gmail.com>
Reply-To: Young Koh <young.koh@gmail.com>
Subject: Re: [uml-devel] a question about sigsetjmp() in copy_from/to_user()
In-Reply-To: <200509291409.28067.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
References: <3524bf1f050927070645b999bd@mail.gmail.com>
	 <20050928145009.GA11610@ccure.user-mode-linux.org>
	 <3524bf1f0509281225180173ae@mail.gmail.com>
	 <200509291409.28067.blaisorblade@yahoo.it>
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
Date: Fri, 30 Sep 2005 11:08:04 -0400
Content-Transfer-Encoding: 8bit
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

> > it seems that sigsetjmp() has
> > relatively large overhead, we could reduce some overhead by not
> > calling it.
>
> How do you measure it? I'm curious myself - I know there's the possibility to
> use gprof, but I've never used that myself.

i usually use pentium rdtsc(read time stamp counter) to measure the
timing and latency. (sometimes by instrumenting kernel or sometimes by
measuring test programs) i ran a test program and measured the
overhead of sigsetjmp() and setjmp(). it showed sigsetjmp() uses
around 1350 cycles (which is around 0.45 us in 3.0GHz machine), and
setjmp() only 21 cycles (< 0.01us). maybe while sigsetjmp() is
implemented as a system call to cope with signal blocking/unblocking,
setjmp() is not a system call? (getpid() itself takes more than 1000
cycles)

thanks,

>
> Surely the "sig" thing is heavy (some syscalls like sigprocmask() for
> blocking/unblocking signals). Or better, it's the only heavy thing - the rest
> consists only of saving a couple of registers (6, IIRC) in memory, there's no
> interest in optimizing it away (I assume).
>


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
