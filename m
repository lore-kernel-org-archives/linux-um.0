Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <slyich@gmail.com>) id 1Q90k2-0001AL-01
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 10 Apr 2011 19:56:14 +0000
Received: from mail-fx0-f47.google.com ([209.85.161.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1Q90k1-0006JB-9r
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 10 Apr 2011 19:56:13 +0000
Received: by fxm19 with SMTP id 19so5338739fxm.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 10 Apr 2011 12:56:07 -0700 (PDT)
Date: Sun, 10 Apr 2011 22:58:32 +0300
From: Sergei Trofimovich <slyich@gmail.com>
Message-ID: <20110410225832.36f8c7a5@sf>
In-Reply-To: <20110410095615.47eedc83@sf>
References: <20110409170454.73aada78@sf>
	<BANLkTikjjWR2Ki0aNoTBhecodkGpW2cUzw@mail.gmail.com>
	<20110410095615.47eedc83@sf>
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
Content-Type: multipart/mixed; boundary="===============6909055831566321051=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] btrfs failure and BUG_ON behaviour
To: Sergei Trofimovich <slyich@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

--===============6909055831566321051==
Content-Type: multipart/signed; micalg=PGP-SHA1;
	boundary="Sig_/w==xHeZRu2yUghmntdYAtR+";
	protocol="application/pgp-signature"

--Sig_/w==xHeZRu2yUghmntdYAtR+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

> I'll try to send bug report to linux-btrfs mailing list first
> and return if I'll have more details.

I've bisected it down to memcpy changes
59daa706fbec745684702741b9f5373142dd9fdc and found
out btrfs piece of code passing overlapping areas to memcpy.

Sorry for the noise.

--=20

  Sergei

--Sig_/w==xHeZRu2yUghmntdYAtR+
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iEYEARECAAYFAk2iC+wACgkQcaHudmEf86pF3ACfcxnSeUPCj2+QafJJymITWIQg
oRQAn0dCGecEjR2Wrni/LUC/t/rRI46O
=6Zez
-----END PGP SIGNATURE-----

--Sig_/w==xHeZRu2yUghmntdYAtR+--


--===============6909055831566321051==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Xperia(TM) PLAY
It's a major breakthrough. An authentic gaming
smartphone on the nation's most reliable network.
And it wants your games.
http://p.sf.net/sfu/verizon-sfdev
--===============6909055831566321051==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============6909055831566321051==--


