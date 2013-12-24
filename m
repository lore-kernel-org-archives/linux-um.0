Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <ben@decadent.org.uk>) id 1VvItP-0005nu-2N
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 24 Dec 2013 03:42:51 +0000
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1VvItN-00022P-2b
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 24 Dec 2013 03:42:51 +0000
Message-ID: <1387854840.2783.42.camel@deadeye.wl.decadent.org.uk>
From: Ben Hutchings <ben@decadent.org.uk>
Date: Tue, 24 Dec 2013 03:14:00 +0000
In-Reply-To: <2103356.guehJfKbl6@sandpuppy>
References: <2103356.guehJfKbl6@sandpuppy>
Mime-Version: 1.0
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3684348703528031187=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] Please add: um: add missing declaration of
 'getrlimit()' and friends
To: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net, stable@vger.kernel.org


--===============3684348703528031187==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-VJ0J3Mood98CZf0Iu3gv"


--=-VJ0J3Mood98CZf0Iu3gv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2013-12-09 at 08:33 +0100, Richard Weinberger wrote:
> Hi Greg,
>=20
> please add commit fdfa4c952844fce881df8c76de9c7180cbe913ab (um: add missi=
ng=20
> declaration of 'getrlimit()' and friends) to -stable.
> The change was introduced in 3.9 and needs backporting to all stable tree=
s.

Queued up for 3.2, thanks.

Ben.

--=20
Ben Hutchings
Unix is many things to many people,
but it's never been everything to anybody.

--=-VJ0J3Mood98CZf0Iu3gv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIVAwUAUrj7+Oe/yOyVhhEJAQpxlRAAsA/1cuNKb+sIXpukxvKX7jRI7AC5avlt
ToH24zvsaWJ/K1P4KZYWTz/i6tbDllHNg9zRnGSCYOwBsJQ8yrdDLSZsq51JgUCl
1i8ezMCSRPr9XkNDDkuNu/Q7rmbfvXXbOghBIs5U2AvVF+BS4WGksKxaIhMCzFOe
H5+1Z4TT3A9D6+wrmsA2l79gUF92k0MyVsjQcD5eO7M33FGJsdjq3MJp8sG9u954
2uc//bP2igDB5ZAOXywWlCe/taiEgymtSSQQgASj229OedELF1mdsO1qtiGwdCG+
8W2PAU1v6v2s/HjXDkvFwm5koWhM04JEFT8ykGHf1r/zrAMB972hBHvUecaMmiNo
JUqizd3h1nojbA/KfslDUyNr5/uxqsBYXBTI0P4WgGYvgCYztMBkQEvy69z9W7mP
NqD+xNHIV3NJxw6DbaQxYOe6Pq3baNMJshBNpERBQwtZUmi4EAMhHCTvlivRxdtw
wTUwz8tWxakbgCe/IBxXX7u+FPl+jLMot3D3a+uHwT7tP2Ob2CjovpYiMUytLbwd
Ns2O8tSsnx1H+M4ZiFyarYItSCmg/y9+2CnrZrTQMNxwDFX9TZHFPL1Vr3OsSI4V
qYnnFTu5paMZJNbR8Ad7Wq+5zEv6Jlw10dec419fboO96IGLOoOtZbArED+qDI5/
bcJJ7bKLQcs=
=wcQe
-----END PGP SIGNATURE-----

--=-VJ0J3Mood98CZf0Iu3gv--


--===============3684348703528031187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
--===============3684348703528031187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============3684348703528031187==--


