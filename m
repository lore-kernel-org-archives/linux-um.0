Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19ypW2-0000Kw-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 02:19:26 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19ypW1-00048I-Hb
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 15 Sep 2003 02:19:25 -0700
From: Henrik Nordstrom <hno@marasystems.com>
Subject: Re: [uml-devel] Re: pthreads? 
In-Reply-To: <Pine.GSO.4.21.0309150853020.3191-100000@vervain.sonytel.be>
Message-ID: <Pine.LNX.4.44.0309151033390.15749-100000@filer.marasystems.com>
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
Date: Mon, 15 Sep 2003 11:19:11 +0200 (CEST)
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jeff Dike <jdike@addtoit.com>, User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>

On Mon, 15 Sep 2003, Geert Uytterhoeven wrote:

> On Sat, 13 Sep 2003, Jeff Dike wrote:
> > geert@linux-m68k.org said:
> > > First step: libpthread redefines sigaction to install its own signal
> > > handler around the signal.
> > 
> > Gawd, that's unpleasant.  What does its signal handler do?
> 
> For reference, here's the code (from Debian glibc_2.3.1-16):

The interesting part is what the signal handler does, not how it is
installed.  According to the code you quoted the signal handler is
__pthread_signhandler or __pthread_sighandler_rt depending on the
sigaction type.

From my understanding of ptherads but without reading the code this signal
handler is supposed to route the signal to the correct threads. Linux
kernel signal management in cloned processes differs significantly from
POSIX Threads signal specification and this signal routing tries to make
Linux look more like the POSIX Threads specification.

> I removed all libpthread overridings of symbols that are used by UML
> (intersection of 'U' symbols of vmlinux and 'T' and 'W' symbols of libpthread),
> and now UML boots. I'll try to find out which one is the bad guy...

In this case I would say UML is one of the bad guys due to it's symbols
which overrides libc or pthreads. Any application which needs to override
libc primitives to work is a bad guy and pthreads is technically part of
libc when using threaded applications.

Hoever, if UML uses clone() or other libc calls (yes, clone() is a libc
call, direcly matched by a kernel syscall) in a manner which should not
confuse other users of the same calls then pthreads may be a bad guy as
well, not dealing properly with the situation.

Regards
Henrik



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
