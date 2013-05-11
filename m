Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <slyich@gmail.com>) id 1Ub7Zw-0006MC-FN
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 11 May 2013 11:03:04 +0000
Received: from mail-ea0-f170.google.com ([209.85.215.170])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Ub7Zv-0002SN-Gm
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 11 May 2013 11:03:04 +0000
Received: by mail-ea0-f170.google.com with SMTP id f15so1233228eak.29
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 11 May 2013 04:02:57 -0700 (PDT)
Date: Sat, 11 May 2013 14:01:39 +0300
From: Sergei Trofimovich <slyich@gmail.com>
Message-ID: <20130511140139.1e6ee40b@sf>
In-Reply-To: <518E14B7.3030409@gmx.de>
References: <CAFLxGvwen6WwNoh3iZ2j+dK8iQsxVkjhnvaXjdfXATF+mmwtuw@mail.gmail.com>
	<518E02FB.6040808@gmx.de>
	<CAFLxGvxM_zK11csqpFmVw9q1sPTb1nO0=L5r0AUxf9F4mtfXsg@mail.gmail.com>
	<518E14B7.3030409@gmx.de>
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
Content-Type: multipart/mixed; boundary="===============3365594797169193277=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] Fwd: Re: [uml-user] WARNING: at
 mm/slab_common.c:376 kmalloc_slab+0x33/0x80()
To: Toralf =?UTF-8?B?RsO2cnN0ZXI=?= <toralf.foerster@gmx.de>
Cc: Dave Jones <davej@redhat.com>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

--===============3365594797169193277==
Content-Type: multipart/signed; micalg=PGP-SHA1;
	boundary="Sig_/AtuoH24OvSGpmVtWZVX2QNc";
	protocol="application/pgp-signature"

--Sig_/AtuoH24OvSGpmVtWZVX2QNc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

> With this change:
>=20
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 7b1ca9b..289211d 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2236,6 +2236,8 @@ int copy_mount_string(const void __user *data, char=
 **where)
>                 return 0;
>         }
>=20
> +       printk(" here: size is %ul\n", (unsigned long)data);

Be careful, it's long->int truncation. I guess you want '%lu' instead of '%=
ul'.

> 2013-05-11T11:51:00.551+02:00 trinity kernel: here: size is 134565664l
> 2013-05-11T11:51:00.551+02:00 trinity kernel: here: size is 134565632l
> 2013-05-11T11:51:00.551+02:00 trinity kernel: here: size is 134564296l
> 2013-05-11T11:51:00.551+02:00 trinity kernel: here: size is 134564312l

--=20

  Sergei

--Sig_/AtuoH24OvSGpmVtWZVX2QNc
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlGOJRsACgkQcaHudmEf86oVNgCfQCgQ9LVWAk5swlM+c63xxB6z
JgIAn0UvfKR+kzKeyoxf8y5JXtOYwvtS
=3bK5
-----END PGP SIGNATURE-----

--Sig_/AtuoH24OvSGpmVtWZVX2QNc--


--===============3365594797169193277==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and 
their applications. This 200-page book is written by three acclaimed 
leaders in the field. The early access version is available now. 
Download your free book today! http://p.sf.net/sfu/neotech_d2d_may
--===============3365594797169193277==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============3365594797169193277==--


