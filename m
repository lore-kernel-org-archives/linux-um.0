Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19zKnK-0007nu-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 16 Sep 2003 11:43:22 -0700
Received: from smtp013.mail.yahoo.com ([216.136.173.57])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 19zKnJ-0008Jq-FR
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 16 Sep 2003 11:43:21 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: pthreads?
References: <Pine.GSO.4.21.0309151127130.3302-100000@vervain.sonytel.be> <1063623075.2123.9.camel@henrik.marasystems.com>
In-Reply-To: <1063623075.2123.9.camel@henrik.marasystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200309162044.41268.blaisorblade_spam@yahoo.it>
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
Date: Tue, 16 Sep 2003 20:44:41 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 12:51, luned=EC 15 settembre 2003, Henrik Nordstrom ha scritto:
> m=E5n 2003-09-15 klockan 11.28 skrev Geert Uytterhoeven:
> > No, UML only _uses_ those symbols, libpthread redefines them in a way
> > that breaks UML.
>
> uml redefines several libc symbols which does conflict with pthreads.

> The most notable is that uml overrides malloc/free but I think there is
> also a few other overrides due to kernel library calls having the same
> name as their libc equivalent calls. If you are to link with pthreads
> each of these must be verified to be threads safe to the same level as
> their libc/pthreads counterpart. On the positive side most kernel lib
> calls most likely are threads safe due to the multithreaded nature of
> the kernel, but any lib call making use of locking or other kernel
> constructs will almost certainly fail or cause problems if ever invoked
> from a pthread.
There is(from long time) the idea to make possible turning UML into a libra=
ry.
This means that solving this issue in UML is worthwhile. I.e., let's suppos=
e=20
that the malloc's conflict. Then, Uml will use uml_malloc, which will be is=
=20
own version, and everyone will be happy. Using a -Dmalloc=3Duml_malloc woul=
d=20
make unnecessary changing the source. This is a quick idea(and details abou=
t=20
the exact names are to be tuned), but I hope it's useful.
--=20
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
