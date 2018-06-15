Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fTiKN-0000Wu-53
 for linux-um@lists.infradead.org; Fri, 15 Jun 2018 06:35:21 +0000
Received: by mail-pf0-x244.google.com with SMTP id a11-v6so4396152pff.8
 for <linux-um@lists.infradead.org>; Thu, 14 Jun 2018 23:35:08 -0700 (PDT)
Message-ID: <503aeaef9da5dbb58f2c1fb9793eb25cb5ce0bc9.camel@researchut.com>
Subject: Re: UML fails to build on arch i386
From: Ritesh Raj Sarraf <rrs@researchut.com>
Date: Fri, 15 Jun 2018 12:20:02 +0545
In-Reply-To: <2135572.4iMtKPa2p5@blindfold>
References: <eabf7e000bc0227fa6a7a74a23512cc11b84206a.camel@researchut.com>
 <CAFLxGvw8_HJGLHuaPxT0wxr6fCa3w5GkTjfrkUyVY+ZG0NoE6g@mail.gmail.com>
 <fb137ebf865a1160b06ac92cfb601fd68533c787.camel@researchut.com>
 <2135572.4iMtKPa2p5@blindfold>
Mime-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Reply-To: rrs@researchut.com
Content-Type: multipart/mixed; boundary="===============0718592122124116224=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Richard Weinberger <richard@sigma-star.at>, linux-um@lists.infradead.org


--===============0718592122124116224==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-8ocpbnS3cf49dxGID5Rn"


--=-8ocpbnS3cf49dxGID5Rn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Richard,

On Thu, 2018-06-14 at 20:41 +0200, Richard Weinberger wrote:
> >=20
> > #ifdef __x86_64__
> >    /* Access TLS data.  */
> >    PTRACE_ARCH_PRCTL =3D 30,
> > # define PT_ARCH_PRCTL PTRACE_ARCH_PRCTL
> > #endif
> >=20
> >    /* Continue and stop at the next syscall, it will not be
> > executed.  */
> >    PTRACE_SYSEMU =3D 31,
> > #define PT_SYSEMU PTRACE_SYSEMU
>=20
> Okay, PTRACE_SYSEMU seems to be part of an enum, that's why UML's
> #ifndef does not
> not protect the #define.
>=20
> What libc is this?

This is glibc 2.27 from Debian.

rrs@priyasi:~$ dpkg -S /usr/include/x86_64-linux-gnu/sys/ptrace.h=20
libc6-dev:amd64: /usr/include/x86_64-linux-gnu/sys/ptrace.h
12:19 =E2=99=92=E2=99=92=E2=99=92   =E2=98=BA =F0=9F=98=84   =20
rrs@priyasi:~$ apt policy libc6-dev
libc6-dev:
  Installed: 2.27-3
  Candidate: 2.27-3
  Version table:
 *** 2.27-3 900
        900 http://deb.debian.org/debian testing/main amd64 Packages
        500 http://deb.debian.org/debian unstable/main amd64 Packages
        100 /var/lib/dpkg/status
12:19 =E2=99=92=E2=99=92=E2=99=92   =E2=98=BA =F0=9F=98=84   =20



>=20
> I think we can remove UML's define check and just assume that every
> system has PTRACE_SYSEMU
> properly defined.
--=20
Ritesh Raj Sarraf
RESEARCHUT - http://www.researchut.com
"Necessity is the mother of invention."
--=-8ocpbnS3cf49dxGID5Rn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQCVDstmIVAB/Yn02pjpYo/LhdWkFAlsjXhYACgkQpjpYo/Lh
dWltdw//djH+iWlNoxo1BkLwSrFbfxJ/G9B3WF5Xyhq72oPjxzZqU711mFfUjpD8
ILRM7Kkq0z8Wb2FhXlO6+4fJ8DiRtyalVf+a2LXDdIxOfBZGrPT6fB2oNgE+WPy1
mxJSqMN9Xi2vyiFZKB6x9XGYF2kt+nVAKGx2lTju5eyCBM04kPfGxBpz4PCv0HYd
9ujqCUUJI7TIWKlU/bgYg8pjthV/fpUikObKc6RZS2wGJcd80VFDWayA4LVNNb3u
QwnROUfDXKba1eyK6iEFIP6+BWxnuOc454LqzFSQ5q7wIZWCGPBmClxara7rMdjE
OKKvK7EuPgWtnRNh5blr3ZU57z/RUYBJDLtLbvN0eYHzWiwMK2ZkIsVYo5BlQLNP
77XWJUsJY8eqL/HhA6DuCL7bpFpLzrsJVYruwYIz6VNWIBAf4vtRUC6qoN+H5e2V
dtzgcVbf+3kdr/S93Yt2STOpVKHyq18APKpeZCHXwUU0G1C5CFA0iXb+S/oTa53b
xzkENMG2uju9uiDgwyuDef1WGSqI2VSWNBQNwhAuKurYQ2rTB+WO+bpUyxjY/9lN
OyhU6+QN22Kipq7bWaNFtDk4pvOGvbNEXOq+y45xMoa5YrJlD/4hvwmEeYTDAxOb
7wkjMo7Yozdq6Exz50BolMYyh2nI9WAvat+T2cnxZtRzDuefd64=
=qEM9
-----END PGP SIGNATURE-----

--=-8ocpbnS3cf49dxGID5Rn--



--===============0718592122124116224==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============0718592122124116224==--



