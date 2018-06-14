Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pg0-x22a.google.com ([2607:f8b0:400e:c05::22a])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fTUQe-0006Tb-GY
 for linux-um@lists.infradead.org; Thu, 14 Jun 2018 15:44:54 +0000
Received: by mail-pg0-x22a.google.com with SMTP id 15-v6so3109684pge.2
 for <linux-um@lists.infradead.org>; Thu, 14 Jun 2018 08:44:41 -0700 (PDT)
Message-ID: <fb137ebf865a1160b06ac92cfb601fd68533c787.camel@researchut.com>
Subject: Re: UML fails to build on arch i386
From: Ritesh Raj Sarraf <rrs@researchut.com>
Date: Thu, 14 Jun 2018 21:29:37 +0545
In-Reply-To: <CAFLxGvw8_HJGLHuaPxT0wxr6fCa3w5GkTjfrkUyVY+ZG0NoE6g@mail.gmail.com>
References: <eabf7e000bc0227fa6a7a74a23512cc11b84206a.camel@researchut.com>
 <d5c8646bf909902b1f4a0f593ab3832ed399f9c1.camel@researchut.com>
 <CAFLxGvw8_HJGLHuaPxT0wxr6fCa3w5GkTjfrkUyVY+ZG0NoE6g@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============8042793666808815078=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: linux-um@lists.infradead.org


--===============8042793666808815078==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-prwDFjZyhqmBqjYlKOrb"


--=-prwDFjZyhqmBqjYlKOrb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2018-06-14 at 13:15 +0200, Richard Weinberger wrote:
> > This log missed the main error line:
> >=20
> >    CC      arch/um/kernel/maccess.o
> >    CC      arch/um/kernel/kmsg_dump.o
> >    CC      arch/um/kernel/skas/clone.o
> > In file included from ./arch/x86/um/shared/sysdep/ptrace.h:42:0,
> >                   from ./arch/um/include/shared/as-layout.h:38,
> >                   from arch/um/kernel/skas/clone.c:11:
> > ./arch/x86/um/shared/sysdep/ptrace_32.h:16:23: error: expected
> > identifier before numeric constant
> >   #define PTRACE_SYSEMU 31
>=20
> Hmm, can you please check how PTRACE_SYSEMU is defined in your UAPI?
>=20
> The code is pretty boring:
> #ifndef PTRACE_SYSEMU
> #define PTRACE_SYSEMU 31
> #endif
>=20
> My best guess is that PTRACE_SYSEMU is not a define but something
> else and then
> #define fails in an interesting way.

There's nothing much in here either.
=46rom file: i386-linux-gnu/sys/ptrace.h
And it is the same code on x86_64 too, where I've been able to
successfully build it.



#ifdef __x86_64__
  /* Access TLS data.  */
  PTRACE_ARCH_PRCTL =3D 30,
# define PT_ARCH_PRCTL PTRACE_ARCH_PRCTL
#endif

  /* Continue and stop at the next syscall, it will not be executed.  */
  PTRACE_SYSEMU =3D 31,
#define PT_SYSEMU PTRACE_SYSEMU

  /* Single step the process, the next syscall will not be executed.  */
  PTRACE_SYSEMU_SINGLESTEP =3D 32,
#define PT_SYSEMU_SINGLESTEP PTRACE_SYSEMU_SINGLESTEP

  /* Execute process until next taken branch.  */
  PTRACE_SINGLEBLOCK =3D 33,
#define PT_STEPBLOCK PTRACE_SINGLEBLOCK



--=20
Ritesh Raj Sarraf
RESEARCHUT - http://www.researchut.com
"Necessity is the mother of invention."
--=-prwDFjZyhqmBqjYlKOrb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQCVDstmIVAB/Yn02pjpYo/LhdWkFAlsijWUACgkQpjpYo/Lh
dWnjuw/7Buak1xwbCZtpL2NO2KZ5ZRiZAzkf3XMpvqpqZiAKcmUp8r0r2D4Hz8zU
gRjUCf/Uu3iiW0ILlRVt3zNPylRPWPAErnm6w9E0xF2xsBUHVC+hsfH9B06SFuh4
pyQ1UVihyj/3XhgG/g8jko0JsWfK21awhQ3fnvgEhb8A5gp2Uo6sGalLj7dT4cDF
CgqUogLJXNenIeJYkXhqQcYp5SSZFpnyEMgF+GgpbA5wFdymf8EptI2PKns4YCj/
HBF+tFELIv8Y5WhaeWZaM1DAlLDZyCaWflsRfVDxrWqhU6kHv71fl1Hv+NGmgkKA
RTfFsZi0qJ/4G6Jlm8MR+LKQRCa7ykVGK4nf1iH+bb+pBbWo52xu1AMZGBIHzBW7
p1kmSrzvxWtekzDJZ4T/nQiB8Ynlfv3nfRUCLpeScwNGBM/S8S+wAjJjKaaTG2qD
ljliAYfPXbE51XXnwTQSVoHcWC45bwPBgShaqlnrwRlVRctw97ZP9EJ2/dC5f/xo
S2QuQ0CDAkD/bw61i/s0yAm0eSrFlZYbSrsFrWH/lAKEkLxVNQQnOv0TYjZbf6TZ
oPdDzRFbDPkmHYVM+rIBtiwLpxuq7yQDljVYuVPHB7Yz7dgqZhnNzTeSpbakzlrD
GVnTJg7kEEZszsnzOo/kZYEj30PnOL8oVE08gJs0LZuC6IC9Ifo=
=c23u
-----END PGP SIGNATURE-----

--=-prwDFjZyhqmBqjYlKOrb--



--===============8042793666808815078==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============8042793666808815078==--



