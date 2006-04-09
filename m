Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FSZLt-0007mi-RP for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Apr 2006 05:49:13 -0700
Received: from [212.34.199.38] (helo=etinarcadiaego.dyndns.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FSZLq-0008Vr-91
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Apr 2006 05:49:14 -0700
From: Stefano Melchior <stefano.melchior@openlabs.it>
Subject: Re: [uml-devel] [RFC][PATCH] include /usr/lib/uml in PATH
Message-ID: <20060409125221.GB7503@SteX>
Reply-To: stefano.melchior@openlabs.it
References: <20060402173445.GB5108@inferi.kami.home>
	<200604040239.45495.blaisorblade@yahoo.it>
	<20060405211153.GE8583@inferi.kami.home>
	<200604070845.39534.blaisorblade@yahoo.it>
	<20060407165205.GE23715@inferi.kami.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TakKZr9L6Hm6aLOc"
Content-Disposition: inline
In-Reply-To: <20060407165205.GE23715@inferi.kami.home>
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
Date: Sun, 9 Apr 2006 14:52:21 +0200
To: Mattia Dongili <malattia@linux.it>
Cc: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net, Geert Uytterhoeven <geert@linux-m68k.org>, Jeff Dike <jdike@addtoit.com>


--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 07, 2006 at 06:52:05PM +0200, Mattia Dongili wrote:
Dear all,
> > > > #define UML_LIB_PATH ":/usr/lib/uml"
> >=20
> > > what about a config option instead? CONFIG_UML_NET_PATH
> >=20
> > Don't think so, that's not supposed to be changed according to any conf=
ig=20
> > option or I can't see that. Unless on 64-bit system that's /usr/lib64/u=
ml,=20
> > and in that case it makes sense to have CONFIG_XXX =3D=20
> > "/usr/lib/uml" (without :, add them only in the source, i.e. insulate d=
etails=20
> > away).
>=20
> Yes, that was what I meant. However it's probably not worth the effort
> yet.
>=20
> > > > 19 -> strlen(UML_LIB_PATH)
> > > > in snprintf, "PATH=3D%s:/usr/lib/uml" -> "PATH=3D%s" UML_LIB_PATH
> > > >
> > > > (using string literal concatenation)
> >=20
> > > here's an updated patch, I added a check for current PATH=3D=3D"" to =
avoid
> > > touching the PATH variable when empty (again, kind of keeping the same
> > > behaviour of a clean execvp, I mean it makes no sense to append
> > > /usr/lib/uml and not /bin:/usr/bin too).
> >=20
> > In that case, you should append both IMHO - empty PATH and no PATH shou=
ld be=20
> > treated the same way, I think.
>=20
> updated patch attached, I hope you like the if-statement .
>=20
> Description:
> append /usr/lib/uml to the existing PATH environment variable to let
> execvp search uml_net in FHS compliant locations.
at this point, is it the case to have also this patch for the
uml-utilities in order to install uml-net directly on the FHS complaint
path (uml-net):

--- uml_net/Makefile   2003-02-08 05:04:55.000000000 +0100
+++ uml_net/Makefile   2006-04-09 12:48:27.000000000 +0200
@@ -3,7 +3,7 @@
 BIN =3D uml_net
 CFLAGS =3D -g -Wall $(TUNTAP)
=20
-BIN_DIR ?=3D /usr/bin
+BIN_DIR ?=3D /usr/lib/uml
=20
 OBJS =3D ethertap.o host.o output.o slip.o uml_net.o

What do you think?

Cheers

SteX
--=20
Stefano Melchior, GPG key =3D D52DF829 - <stefano.melchior@openlabs.it>
http://etinarcadiaego.dyndns.org    --     http://www.stex.name
Skype ID "stefanomelchior"

--TakKZr9L6Hm6aLOc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iQCUAwUBRDkDhYlnkxrVLfgpAQI5AAP4xs3mOS3XvMC9FxxUkfvPx59FQ7ao3WFO
SfjFpr/YZq6TO3iSZhzRDt93d8vWf918iyMFqEevMztQ+k2C68a6Sk8nqMStfQ/e
tn/t7ylBnGcp27Y3eCdj0Osnw0CSFmHcL+sUg4tKGGp04N5/na0ss+IapmAAHv4E
Ng8NJpfEKA==
=T3A/
-----END PGP SIGNATURE-----

--TakKZr9L6Hm6aLOc--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
