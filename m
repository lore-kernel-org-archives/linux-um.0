Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fc8tu-0003vX-GM for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 May 2006 15:35:54 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fc8tu-0001LL-Hb for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 May 2006 15:35:54 -0700
Received: from [212.34.199.38] (helo=etinarcadiaego.dyndns.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Fc8ts-0006xc-0h
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 May 2006 15:35:54 -0700
From: Stefano Melchior <stefano.melchior@openlabs.it>
Subject: Re: [uml-devel] Problem on generation a locales on uml image
Message-ID: <20060505223816.GB6864@SteX>
Reply-To: stefano.melchior@openlabs.it
References: <20060505124937.GA4327@SteX> <20060505141208.GA4940@SteX>
	<20060505145248.GE23227@inferi.kami.home>
	<200605052247.29478.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rS8CxjVDS/+yyDmU"
Content-Disposition: inline
In-Reply-To: <200605052247.29478.blaisorblade@yahoo.it>
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
Date: Sat, 6 May 2006 00:38:16 +0200
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Mattia Dongili <malattia@linux.it>


--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 05, 2006 at 10:47:28PM +0200, Blaisorblade wrote:
Dear all,
> > [...]
>=20
> > AFAIU, it's an harmless warning telling that UML didn't receive the
> > timer interrupt for too long.
>=20
> Yes, more exactly it happens when the kernel didn't schedule a certain ta=
sk=20
> (watchdog/$CPUID) for execution for 10 seconds.
>=20
> The current impression is that it happens on high load, for instance on h=
igh=20
> disk load IIRC. It's harmless as long as UML keeps running.

I may understand that my public server (where I also use to play with uml
too, from remote, i.e. free time at the office) is a PIII500 with only
128MB of RAM and an old 12GB hdd: this lack of performances and the
temporary high cpu load (postfix+spamassassin+apache2+mysql) can be the=20
reason of this problems.

May it be reasonable to increase this schedule timeout? I mean moving the
limit to 15-20sec?

Thank you in advance of this support

Cheers

SteX
--=20
Stefano Melchior, GPG key =3D D52DF829 - <stefano.melchior@openlabs.it>
http://etinarcadiaego.dyndns.org    --     http://www.stex.name
Skype ID "stefanomelchior"

--rS8CxjVDS/+yyDmU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iQCVAwUBRFvT2IlnkxrVLfgpAQJcOAP/QAg2uRmLPpefU7y5ABjEtEa9Q3YFXZbc
B5A3UhQ8O3BUn9quhRqgdqbPzAFPddyg0e+xsjtcvfUU0mxIn5u0otSOmcTbYUGC
ohWmWa97rGug6kQHphpglb5yGmHSx8HduYvZ7cjFnBitUtte9t8ce55z9qxj+IqG
wJR/xCR6AWc=
=1JeZ
-----END PGP SIGNATURE-----

--rS8CxjVDS/+yyDmU--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
