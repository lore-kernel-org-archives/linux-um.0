Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ahwaq-0000jt-JI for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Jan 2004 11:58:52 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1Ahwaq-0005PM-1d for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Jan 2004 11:58:52 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] cannot compile 2.6.1 uml-kernel, NPTL?
References: <bua04l$6uo$1@sea.gmane.org>
In-Reply-To: <bua04l$6uo$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200401172100.36754.blaisorblade_spam@yahoo.it>
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
Date: Sat, 17 Jan 2004 21:00:36 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Sven =?iso-8859-1?q?K=F6hler?= <skoehler@upb.de>

Alle 01:38, sabato 17 gennaio 2004, Sven K=F6hler ha scritto:
> hi,
>
> i'm trying to compile kernel 2.6.1 with the UML-patch that Jeff Dike
> supplied. Well, i get that error:

> arch/um/kernel/tt/unmap_fin.o(.text+0x358d0):strpbrk: first defined here
> /usr/lib/gcc-lib/i686-pc-linux-gnu/3.2.3/../../../../i686-pc-linux-gnu/bi=
n/
>ld: Warning: size of symbol `strpbrk' changed from 179 in
> arch/um/kernel/tt/unmap_fin.o to 64 in vmlinux

It must be linker error.

> /usr/lib/gcc-lib/i686-pc-linux-gnu/3.2.3/../../../../i686-pc-linux-gnu/bi=
n/

>ld: BFD 2.14.90.0.6 20030820 assertion fail elf.c:3458

assertion failed means a bug. Would you retest with another binutils versio=
n?=20
On my system ld --version gives:

GNU ld version 2.13.90.0.18 20030121

So probably you have a binutils bug. *Maybe* there is also something strang=
e=20
in UML that triggers the bug, but an assertion failed is anyway a linker bu=
g.

Bye
--=20
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.23/2.6.0 on an i686; Linux registered user n. 292729
EOSIGN



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
