Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DJG0u-0000Ph-FP for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Apr 2005 12:16:32 -0700
Received: from wavehammer.waldi.eu.org ([82.139.196.55] ident=postfix)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1DJG0s-0004fv-S3
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Apr 2005 12:16:32 -0700
From: Bastian Blank <bastian@waldi.eu.org>
Subject: Re: [uml-devel] Re: UML-patches to prepare UML/s390
Message-ID: <20050406191623.GA10085@wavehammer.waldi.eu.org>
References: <4253E3D6.2000809@fujitsu-siemens.com>
	<20050406203558.GA3307@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <20050406203558.GA3307@ccure.user-mode-linux.org>
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
Date: Wed, 6 Apr 2005 21:16:23 +0200
To: user-mode-linux-devel@lists.sourceforge.net


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 06, 2005 at 04:35:58PM -0400, Jeff Dike wrote:
> I merged these, except for the restartnointr one because I don't have
> ERESTARTNOINTR in my /usr/include, inside a #ifdef KERNEL or not.

2.6.11 shows:

| $ grep ERESTARTNOINTR -r .
| ./linux/errno.h:#define ERESTARTNOINTR  513

And it is there since 2.5.

Bastian

--=20
No one wants war.
		-- Kirk, "Errand of Mercy", stardate 3201.7

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iEYEARECAAYFAkJUNYcACgkQnw66O/MvCNEIJwCdGAoXVXbTKUmXsZZ9gUb/cL/0
+V8An0diUYPZdaD6AdE3rkKF9y4xLqa+
=Xyg5
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
