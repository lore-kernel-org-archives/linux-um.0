Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C3dqu-0001gy-FM for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 04 Sep 2004 09:57:24 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1C3dqp-00016b-TM for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 04 Sep 2004 09:57:21 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Problems compiling any 2.6.x UML
References: <20040903180244.42898.qmail@web54004.mail.yahoo.com>
	<1094299889.7716.36.camel@localhost>
In-Reply-To: <1094299889.7716.36.camel@localhost>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_5EeOB6Nyae7jDKV"
Message-Id: <200409041737.29495.blaisorblade_spam@yahoo.it>
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
Date: Sat, 4 Sep 2004 17:37:29 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Dominik =?iso-8859-15?q?J=FCrgens?= <dcdom@gmx.de>, Matt Zimmerman <mdz@debian.org>


--Boundary-00=_5EeOB6Nyae7jDKV
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Alle 14:11, sabato 4 settembre 2004, Dominik J=FCrgens ha scritto:
> Thank you very very much, that really fixed the problem!
>
> But why does anyone use the /bin/sh in any script, when he wants to use
> the bash? That is in my opinion a very bad fault!!
>
> My /bin/sh was linked to the /bin/dash, not because I linked it, but
> anything else! It does not seem to be very failure tolerant to suppose
> that /bin/sh is the bash...

1) Someone else got a similar problem, because he used a Debian, too, and h=
e=20
had /bin/sh -> /bin/dash. Why and when does Debian do this?

2) Well, I'm attaching the patch to fix this.
=2D-=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

--Boundary-00=_5EeOB6Nyae7jDKV
Content-Type: text/x-diff; charset="iso-8859-1"; name="uml-force-bash.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="uml-force-bash.patch"



Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 uml-linux-2.6.8.1-paolo/arch/um/Makefile |    2 ++
 1 files changed, 2 insertions(+)

diff -puN arch/um/Makefile~uml-force-bash arch/um/Makefile
--- uml-linux-2.6.8.1/arch/um/Makefile~uml-force-bash	2004-09-04 17:35:39.200314560 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/Makefile	2004-09-04 17:36:46.871027048 +0200
@@ -5,6 +5,8 @@
 
 ARCH_DIR = arch/um
 OS := $(shell uname -s)
+#We require it or things break.
+SHELL := /bin/bash
 
 filechk_gen_header = $<
 
_

--Boundary-00=_5EeOB6Nyae7jDKV--


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
