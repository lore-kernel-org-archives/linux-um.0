Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19ypf7-0001le-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 02:28:49 -0700
Received: from mail2.sonytel.be ([195.0.45.172] helo=witte.sonytel.be)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19ypf6-00018O-Ll
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 15 Sep 2003 02:28:48 -0700
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [uml-devel] Re: pthreads? 
In-Reply-To: <Pine.LNX.4.44.0309151033390.15749-100000@filer.marasystems.com>
Message-ID: <Pine.GSO.4.21.0309151127130.3302-100000@vervain.sonytel.be>
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
Date: Mon, 15 Sep 2003 11:28:44 +0200 (MEST)
To: Henrik Nordstrom <hno@marasystems.com>
Cc: Jeff Dike <jdike@addtoit.com>, User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>

On Mon, 15 Sep 2003, Henrik Nordstrom wrote:
> On Mon, 15 Sep 2003, Geert Uytterhoeven wrote:
> > I removed all libpthread overridings of symbols that are used by UML
> > (intersection of 'U' symbols of vmlinux and 'T' and 'W' symbols of libpthread),
> > and now UML boots. I'll try to find out which one is the bad guy...
> 
> In this case I would say UML is one of the bad guys due to it's symbols
> which overrides libc or pthreads. Any application which needs to override
> libc primitives to work is a bad guy and pthreads is technically part of
> libc when using threaded applications.

No, UML only _uses_ those symbols, libpthread redefines them in a way that
breaks UML.

> Hoever, if UML uses clone() or other libc calls (yes, clone() is a libc
> call, direcly matched by a kernel syscall) in a manner which should not
> confuse other users of the same calls then pthreads may be a bad guy as
> well, not dealing properly with the situation.

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
