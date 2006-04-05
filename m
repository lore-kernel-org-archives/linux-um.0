Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FRBeW-00016H-NY for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Apr 2006 10:18:44 -0700
Received: from is1.enterasys.com ([63.160.138.52])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FRBeJ-0002mP-QD
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Apr 2006 10:18:44 -0700
Message-ID: <4433FBD7.6000404@enterasys.com>
From: "D. Bahi" <dbahi@enterasys.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] system call accessing the host os
References: <8F963598-0F1A-464A-991A-2FE95F9B418C@epfl.ch>
In-Reply-To: <8F963598-0F1A-464A-991A-2FE95F9B418C@epfl.ch>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8DC90EBEE4C65283249963FB"
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
Date: Wed, 05 Apr 2006 13:18:15 -0400
To: Olivier Crameri <olivier.crameri@epfl.ch>
Cc: user-mode-linux-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8DC90EBEE4C65283249963FB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

what about this?

http://user-mode-linux.sourceforge.net/iomem.html

Olivier Crameri wrote:
> Hi,
>
> I'm currently working on a project in which we are using UML to access
> the host os and perform some operations.
> More precisely, we would like to have a system call in UML that parses
> a file in the host os.
>
> Since the UML kernel is a host process, I naively thought that I could
> use regular C directly. Indeed, I was able to create my system call,
> and then have some other C files compiled using host os headers such
> as <stdio.h> and <stdlib.h> by putting them in the USER_OBJS list of
> the Makefile.
>
> Unfortunately, I'm having some weird issues that I can't really
> understand. I can read the file using fread, but only in a buffer that
> I allocated using um_kmalloc. If I use a buffer allocated by malloc,
> the fread fails. Then, even if I replace all  my mallocs by
> um_kmallocs, some libc functions (such as sscanf) don't seem to work
> properly. I guess I'm missing something, but I can't figure out what.
>
> If anyone of you can help me, I'd really appreciate,
>
> With best regards,
>
> Olivier
>
> P.S.: I'm using 2.6.15.6 with the latest 2.6.15 patch and the guest
> kernel runs in skas3 mode.
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by xPML, a groundbreaking scripting
> language
> that extends applications into web and mobile media. Attend the live
> webcast
> and join the prime developer group breaking into this new coding
> territory!
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D110944&bid=3D241720&dat=
=3D121642
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


--------------enig8DC90EBEE4C65283249963FB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)

iD8DBQFEM/vb3XQ4zakZ3z4RAmYSAJ42qbgVyLbgErE9G5tNpzoWVzOjVQCeMNg4
1bWLbzn5QRSCHFt5eQj+tzM=
=OjbU
-----END PGP SIGNATURE-----

--------------enig8DC90EBEE4C65283249963FB--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
