Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AyFeX-0004Xy-Ch for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 02 Mar 2004 11:34:05 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AyFS3-0000ri-4s for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 02 Mar 2004 11:21:11 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] [PATCH] Removing user_syms.c altogether
References: <200402282010.41036.blaisorblade_spam@yahoo.it>
	<200402291319.53584.blaisorblade_spam@yahoo.it>
	<200403021840.i22IeBWo002559@ccure.user-mode-linux.org>
In-Reply-To: <200403021840.i22IeBWo002559@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200403022000.12906.blaisorblade_spam@yahoo.it>
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
Date: Tue, 2 Mar 2004 20:00:12 +0100
Content-Transfer-Encoding: quoted-printable
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Alle 19:40, marted=EC 2 marzo 2004, Jeff Dike ha scritto:
> blaisorblade_spam@yahoo.it said:
> > Eeehm - yes! Note however the comment about genksyms: what I say is my
> > idea,  but possibly a wrong one.
>
> Yeah, this isn't right.  The userspace symbols are from libc, and have no
> place under kernel/.

> They should be exported from os/ somehow
No problem: a file inside os-* can actually *not* be a USER_OBJS.
> , and a
> different OS might export totally different symbols.

Yes, that is true (I thought to it). However, the need to avoid code=20
duplication is still there.

So, avoid moving the symbols to ksyms.c, but change user_syms.c that way (i=
.e.=20
make it not be an USER_OBJ), so we can avoid duplicating code. That is=20
especially important because we cannot duplicate the __attribute_used__=20
macro, which is needed with newer Gcc, and which is defined differently for=
=20
different compilers *in kernel headers*.

If you need the rebuilt patch, just let me know and I'll post it next week =

(I'm going to leave for a few days).
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id438&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
