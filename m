Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1RtTkJ-0003qW-5k
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 04 Feb 2012 00:44:51 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RtTkI-0003Kt-D3
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 04 Feb 2012 00:44:51 +0000
Message-ID: <4F2C7F7A.1090605@nod.at>
Date: Sat, 04 Feb 2012 01:44:42 +0100
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <20120130192552.GL23916@ZenIV.linux.org.uk>
	<1328311063-17630-1-git-send-email-richard@nod.at>
	<20120204001431.GY23916@ZenIV.linux.org.uk>
In-Reply-To: <20120204001431.GY23916@ZenIV.linux.org.uk>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6580169901826881856=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH] um: Cleanup headers files
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============6580169901826881856==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC1B1077BEADEE446D1B8FFA9"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC1B1077BEADEE446D1B8FFA9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 04.02.2012 01:14, schrieb Al Viro:
> On Sat, Feb 04, 2012 at 12:17:43AM +0100, Richard Weinberger wrote:
>> Many header files can be replaced by generic variants.
>=20
> Umm...  I suspect that for auxvec.h the right thing is to simply
> remove it - it's never used on uml builds.
>=20
> FWIW, I've rebased my local queue to current and pushed it to kernel.or=
g
> again; it's on git.kernel.org/pub/scm/linux/kernel/git/viro/um-headers.=
git

So, I pulled your work and merged it into my shiny new UML tree:
git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git

Thanks,
//richard


--------------enigC1B1077BEADEE446D1B8FFA9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJPLH96AAoJEN9758yqZn9eelkH/i+o581d6cS9yymbIJolfdBk
rBNeJaVslpBOC+A1w40MfAkgaDX2XjEs5h/9pH8+CQlahEgpXYPCFeT9etmdt2Me
23jAFT9J1fscATUM1Tgd5SmNYg/wmqDmo35ks9Pbvs0KBIccVOT5d170fE3oSWjz
tgb5yCqOAQ2Hnedjdnv0+HfrXJO3oJGTnNVPo2NN5B7aOjR44BiNKi1PeMta4V0z
Da7eKbQ9xzs39Fz4MdL1g71gnMCYxu93x+eEg6qEVJGqdBIdMk+z4/+Y3UAPpXFZ
xYosGzMoEGkEUqcpH1yauuauEdvfzYXDGEhnXbVIe80Q1NwLR1oy7oxTbNpQlOI=
=Sxpv
-----END PGP SIGNATURE-----

--------------enigC1B1077BEADEE446D1B8FFA9--


--===============6580169901826881856==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Try before you buy = See our experts in action!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-dev2
--===============6580169901826881856==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============6580169901826881856==--


