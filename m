Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DJGjy-00037b-Bl for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Apr 2005 13:03:06 -0700
Received: from wavehammer.waldi.eu.org ([82.139.196.55] ident=postfix)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1DJGjw-0000sK-Lv
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Apr 2005 13:03:06 -0700
From: Bastian Blank <bastian@waldi.eu.org>
Subject: Re: [uml-devel] Re: UML-patches to prepare UML/s390
Message-ID: <20050406200257.GB24438@wavehammer.waldi.eu.org>
References: <4253E3D6.2000809@fujitsu-siemens.com>
	<20050406203558.GA3307@ccure.user-mode-linux.org>
	<20050406191623.GA10085@wavehammer.waldi.eu.org>
	<425439A4.2030006@fujitsu-siemens.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
Content-Disposition: inline
In-Reply-To: <425439A4.2030006@fujitsu-siemens.com>
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
Date: Wed, 6 Apr 2005 22:02:57 +0200
To: user-mode-linux-devel@lists.sourceforge.net


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 06, 2005 at 09:33:56PM +0200, Bodo Stroesser wrote:
> Bastian Blank wrote:
| Mail-Followup-To: user-mode-linux-devel@lists.sourceforge.net=20

Please fix your MUA.

> TX for the info, but sorry, I guess you missunderstood. We were not talki=
ng
> about kernel's include/linux/errno.h, but about host's=20
> /usr/include/linux/errno.h,
> included in a user-obj in UML. Even kernel 2.4 defines ERESTARTNOINTR,
> but there seem to be some distros, that don't have it in=20
> /usr/include/linux/errno.h.
> And I really wanted to have host's ERESTARTNOINTR!

Since when does glibc support building itself against anything else than
the Linux headers? But anyway, this errno is internal.  So there exists
no "host's ERESTARTNOINTR".

Bastian

--=20
Insufficient facts always invite danger.
		-- Spock, "Space Seed", stardate 3141.9

--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iEYEARECAAYFAkJUQHEACgkQnw66O/MvCNF3jgCfW0uhcWWoFOlEfqPfeRr2or2s
EJUAmwYc17/VriBY3QRbCm1/VN7sGBpw
=Nm9R
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
