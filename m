Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bebvp-0008Sl-Mc for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Jun 2004 08:51:01 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1Bebvp-0000rz-4r for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Jun 2004 08:51:01 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] backtrace of uml crash on mysql-server start
References: <40DDDB91.9050304@exse.net>
In-Reply-To: <40DDDB91.9050304@exse.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200406271803.50551.blaisorblade_spam@yahoo.it>
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
Date: Sun, 27 Jun 2004 18:03:50 +0200
Content-Transfer-Encoding: quoted-printable
To: Sebastian =?iso-8859-1?q?B=F6hm?= <seb@exse.net>, user-mode-linux-devel@lists.sourceforge.net

Alle 22:24, sabato 26 giugno 2004, Sebastian B=F6hm ha scritto:
> Hi,
>
> finally I was able to produce this stracktrace with 2.4.26-um1 (host
> also 2.4.26)
> It happend during a mysql-server start. (I can reproduce this quite
> constant, if you have further questions ...)

Very well, a reproducible crash is very important.

> maybe something with ipc ?


> Breakpoint 1, panic (fmt=3D0x0) at panic.c:58
> 58              machine_paniced =3D 1;
> (gdb) bt

> #10 0xa008e408 in sig_handler (sig=3D28, sc=3D
>       {gs =3D 0, __gsh =3D 0, fs =3D 0, __fsh =3D 0, es =3D 43, __esh =3D=
 0, ds =3D
> 43, __dsh =3D 0, edi =3D 0, esi =3D 1881171332, ebp =3D 2705261644, esp =
=3D
> 2705261572, ebx =3D 188117


Eeeh?

> ---Type <return> to continue, or q <return> to quit---

Aargh! Why did not you type <return> here? The backtrace still continues, a=
nd=20
the part you posted is the least significant one (though there is already=20
something strange - a panic onto a panic - but not yet enough). It's like a=
=20
joke from the fate....

Just post the *complete* backtrace and I'll be able to start to analyze the=
=20
bug.
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 -=20
digital self defense, top technical experts, no vendor pitches,=20
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
