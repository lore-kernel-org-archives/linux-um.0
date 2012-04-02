Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <slyich@gmail.com>) id 1SEm1V-0004PT-Re
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Apr 2012 18:30:37 +0000
Received: from mail-wi0-f175.google.com ([209.85.212.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SEm1U-0001P5-Vc
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Apr 2012 18:30:37 +0000
Received: by wibhn6 with SMTP id hn6so2571189wib.10
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 02 Apr 2012 11:30:30 -0700 (PDT)
Date: Mon, 2 Apr 2012 21:35:10 +0300
From: Sergei Trofimovich <slyich@gmail.com>
Message-ID: <20120402213510.39563953@sf.home>
In-Reply-To: <CAFLxGvzcSXsYWKR7Ty0wvmukM6yGUzWob5zCfariJUkw6=GcoQ@mail.gmail.com>
References: <20120402211730.19f6baaf@sf.home>
	<CAFLxGvzcSXsYWKR7Ty0wvmukM6yGUzWob5zCfariJUkw6=GcoQ@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============7109507560118723354=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] 3.4.0-rc1 is broken due to asm/system.h restructure
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: David Howells <dhowells@redhat.com>, user-mode-linux-devel@lists.sourceforge.net

--===============7109507560118723354==
Content-Type: multipart/signed; micalg=PGP-SHA1;
	boundary="Sig_/rPNnSJWF.Pm0fp2uURaQz7S";
	protocol="application/pgp-signature"

--Sig_/rPNnSJWF.Pm0fp2uURaQz7S
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Apr 2012 20:16:24 +0200
richard -rw- weinberger <richard.weinberger@gmail.com> wrote:

> On Mon, Apr 2, 2012 at 8:17 PM, Sergei Trofimovich <slyich@gmail.com> wro=
te:
> > The asm/system.h patches missed ARCH=3Dum
> > which caused build breakage [2].

> See:
> http://comments.gmane.org/gmane.linux.kernel/1274493

Oh, your patches helped! Sorry for the noise.

Thank you!

--=20

  Sergei

--Sig_/rPNnSJWF.Pm0fp2uURaQz7S
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iEYEARECAAYFAk958V8ACgkQcaHudmEf86pbYACfS79BWLSkcln4qv+1rH32aBoX
MgcAnjoZVeHikOipQMiO0nBdnWaJcudO
=WEJI
-----END PGP SIGNATURE-----

--Sig_/rPNnSJWF.Pm0fp2uURaQz7S--


--===============7109507560118723354==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
--===============7109507560118723354==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============7109507560118723354==--


