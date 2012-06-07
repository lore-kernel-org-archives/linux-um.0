Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <4FD0C64D.2050302@nod.at>
Date: Thu, 07 Jun 2012 17:18:37 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <1338841657-30358-1-git-send-email-richard@nod.at> <4FCF6748.6020005@panasas.com> <4FD059AC.8050808@panasas.com> <4FD06A22.6040002@nod.at> <4FD07F14.50902@panasas.com> <4FD0802A.1020203@nod.at> <20120607115227.6643d1ad@pyramind.ukuu.org.uk>
In-Reply-To: <20120607115227.6643d1ad@pyramind.ukuu.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3293C8C1F47D8C996BB4C705"
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [uml-devel] um: TTY fixes (?)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Boaz Harrosh <bharrosh@panasas.com>, user-mode-linux-devel@lists.sourceforge.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, jslaby@suse.cz, alan@linux.intel.com
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3293C8C1F47D8C996BB4C705
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Alan, Jiri!

If I omit ->hangup(), mingetty (And all other getty implementations) are =
unable to open /dev/ttyX.
open() returns -EIO.
Currently I'm testing it on FC12.
Also if I do something like "echo foo >/dev/tty1" it fails with -EIO.
And now the strange thing, opening and writing an unknown (unknown to thi=
s upstart rubbish) tty works.
E.g.: echo foo >/dev/tty10.

Any ideas what's going wrong?

Thanks,
//richard


--------------enig3293C8C1F47D8C996BB4C705
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJP0MZNAAoJEN9758yqZn9ePiwIAJ3j+EtbhVDWeCX+7CXY1aXU
3A5Jjd3cGBo/3TOrQ/6pWzsJYmrru5puFMvSYc2hv2k/+gyqJSHfs9Us4/TF4a2m
ISE0l4V0zJ9i8zv2HLMB5bl9TNUFw912Vlb1Rwq2OS7Ueadl7GlojOwSuyZg3wC6
d/6rSo7hqe1LFjZucIqmbcwI7pruuVVoTWc9bakFvrP3zH4lj+voxhhE2ZEP7JrY
2r3gt1rWVpfD4UjbCvT9aheLm90leLAmr1r9936Me/eVpmZIjXiMlY89yx7+T5o2
iVCxhr9vKn5RHjIQhyHLe2UCSCENQETiuAJk3CXPrBMGFXAGQXmJK/RB80ykT+k=
=ddzF
-----END PGP SIGNATURE-----

--------------enig3293C8C1F47D8C996BB4C705--
