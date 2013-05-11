Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <slyich@gmail.com>) id 1Ub9q8-0005ZT-JH
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 11 May 2013 13:27:56 +0000
Received: from mail-ee0-f47.google.com ([74.125.83.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Ub9q7-0004Nv-Te
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 11 May 2013 13:27:56 +0000
Received: by mail-ee0-f47.google.com with SMTP id t10so61463eei.6
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 11 May 2013 06:27:49 -0700 (PDT)
Date: Sat, 11 May 2013 16:26:37 +0300
From: Sergei Trofimovich <slyich@gmail.com>
Message-ID: <20130511162637.27f475df@sf>
In-Reply-To: <CAFLxGvyYRBspKZiqOe+NSW+B_02oS3TVH9WM9nXBDRiDdKjTRA@mail.gmail.com>
References: <CAFLxGvwen6WwNoh3iZ2j+dK8iQsxVkjhnvaXjdfXATF+mmwtuw@mail.gmail.com>
	<518E02FB.6040808@gmx.de>
	<CAFLxGvxM_zK11csqpFmVw9q1sPTb1nO0=L5r0AUxf9F4mtfXsg@mail.gmail.com>
	<518E14B7.3030409@gmx.de> <20130511140139.1e6ee40b@sf>
	<CAFLxGvyYRBspKZiqOe+NSW+B_02oS3TVH9WM9nXBDRiDdKjTRA@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============3861639434881832743=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] Fwd: Re: [uml-user] WARNING: at
 mm/slab_common.c:376 kmalloc_slab+0x33/0x80()
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: Toralf =?UTF-8?B?RsO2cnN0ZXI=?= <toralf.foerster@gmx.de>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, Dave Jones <davej@redhat.com>

--===============3861639434881832743==
Content-Type: multipart/signed; micalg=PGP-SHA1;
	boundary="Sig_/zJt.Nh.cP3Xc2+t3PZ9zcuU";
	protocol="application/pgp-signature"

--Sig_/zJt.Nh.cP3Xc2+t3PZ9zcuU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 11 May 2013 13:29:23 +0200
richard -rw- weinberger <richard.weinberger@gmail.com> wrote:

> On Sat, May 11, 2013 at 1:01 PM, Sergei Trofimovich <slyich@gmail.com> wr=
ote:
> >> With this change:
> >>
> >> diff --git a/fs/namespace.c b/fs/namespace.c
> >> index 7b1ca9b..289211d 100644
> >> --- a/fs/namespace.c
> >> +++ b/fs/namespace.c
> >> @@ -2236,6 +2236,8 @@ int copy_mount_string(const void __user *data, c=
har **where)
> >>                 return 0;
> >>         }
> >>
> >> +       printk(" here: size is %ul\n", (unsigned long)data);
> >
> > Be careful, it's long->int truncation. I guess you want '%lu' instead o=
f '%ul'.
>=20
> Erm, data is a character array...

Gah, sorry!

Toralf, it's better to use strnlen_user for it:

--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2230,12 +2230,16 @@ int copy_mount_options(const void __user * data, un=
signed long *where)
 int copy_mount_string(const void __user *data, char **where)
 {
        char *tmp;
+       long data_len;

        if (!data) {
                *where =3D NULL;
                return 0;
        }

+       data_len =3D strnlen_user (data, (long)(~0ul >> 1) /* LONG_MAX */);
+       printk("%s: __user * data size is %lu\n", __func__, data_len);
+
        tmp =3D strndup_user(data, PAGE_SIZE);
        if (IS_ERR(tmp))
                return PTR_ERR(tmp);

--=20

  Sergei

--Sig_/zJt.Nh.cP3Xc2+t3PZ9zcuU
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlGORxAACgkQcaHudmEf86rAGwCeIxOopyGWEkAd0EtqlNSNPgGy
YOwAn126oFGbcuv80PnszCAllkyptmjB
=ppCM
-----END PGP SIGNATURE-----

--Sig_/zJt.Nh.cP3Xc2+t3PZ9zcuU--


--===============3861639434881832743==
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
--===============3861639434881832743==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============3861639434881832743==--


