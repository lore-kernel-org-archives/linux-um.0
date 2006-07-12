Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G0kCa-0006e9-Nr for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Jul 2006 12:16:52 -0700
Received: from nemesis.fprintf.net ([66.134.112.218])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1G0kCZ-0004tm-2e
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Jul 2006 12:16:52 -0700
From: Daniel Gryniewicz <dang@gentoo.org>
In-Reply-To: <200607122052.20325.blaisorblade@yahoo.it>
References: <1152493715.28826.13.camel@athena.fprintf.net>
	<200607122052.20325.blaisorblade@yahoo.it>
Date: Wed, 12 Jul 2006 15:16:08 -0400
Message-Id: <1152731768.25471.11.camel@athena.fprintf.net>
Mime-Version: 1.0
Subject: Re: [uml-devel] UML fails to build with CONFIG_MK7 set
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0695706074=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net


--===============0695706074==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-/tB+95U2p/Ween3jS7zf"


--=-/tB+95U2p/Ween3jS7zf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-07-12 at 20:52 +0200, Blaisorblade wrote:
> On Monday 10 July 2006 03:08, Daniel Gryniewicz wrote:
> > Hi, all.
> >
> > I got a bug report (http://bugs.gentoo.org/show_bug.cgi?id=3D138536) ab=
out
> > UML 2.6.16-bs2 failing to build.  I've checked it out, and it fails to
> > build because CONFIG_MK7 is set, which sets CONFIG_X86_USE_3DNOW, which
> > causes asm/arch/string.h to pull in asm/mmx.h, which doesn't exist
> > (because it's in asm/arch/mxx.h, this being UML).  The obvious solution
> > is to symlink it in, but this raises another question:
>=20
> Does it compile then? I tried at the time (it wasn't K7 but another setti=
ng=20
> giving the same error) but I recall it didn't work because it needed furt=
her=20
> work (and part of the content wasn't valid for i386).

Honestly, I didn't try to make it build with K7 at all.  The person
reporting the bug was happy to switch to i686, so it's not an issue from
a gentoo point of view.

> The best temporary solution would be to mark as working only the choices =
which=20
> actually do, and block them for UML (not for i386, and the code is shared=
 -=20
> it suffices a dependency on !UML in the appropriate Kconfig). And it's a=20
> shame I didn't do this already. I hope to work on this on the weekend but=
=20
> it's a bit difficult.

I'll give this a shot, and see if I can work up a patch.

Daniel

--=-/tB+95U2p/Ween3jS7zf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4-ecc0.1.6 (GNU/Linux)

iD8DBQBEtUp4omPajV0RnrERAphSAJ46/fS2NB/edqDyH2s7V68G2wEUMACfbX3z
qHk9IWvo0GLRfSRuWlWSCrQ=
=+yEb
-----END PGP SIGNATURE-----

--=-/tB+95U2p/Ween3jS7zf--



--===============0695706074==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

--===============0695706074==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============0695706074==--

