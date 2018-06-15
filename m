Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf0-x229.google.com ([2607:f8b0:400e:c00::229])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fTnNn-0000ey-70
 for linux-um@lists.infradead.org; Fri, 15 Jun 2018 11:59:20 +0000
Received: by mail-pf0-x229.google.com with SMTP id a63-v6so4789197pfl.1
 for <linux-um@lists.infradead.org>; Fri, 15 Jun 2018 04:59:00 -0700 (PDT)
Message-ID: <cfa706bc44986339492f32b63adad36257b43f93.camel@researchut.com>
Subject: Re: UML fails to build on arch i386
From: Ritesh Raj Sarraf <rrs@researchut.com>
Date: Fri, 15 Jun 2018 17:43:55 +0545
In-Reply-To: <2534439.LyGaCr9OWm@blindfold>
References: <eabf7e000bc0227fa6a7a74a23512cc11b84206a.camel@researchut.com>
 <2135572.4iMtKPa2p5@blindfold>
 <503aeaef9da5dbb58f2c1fb9793eb25cb5ce0bc9.camel@researchut.com>
 <2534439.LyGaCr9OWm@blindfold>
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
Content-Type: multipart/mixed; boundary="===============6602410206268147459=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Richard Weinberger <richard@sigma-star.at>
Cc: linux-um@lists.infradead.org


--===============6602410206268147459==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-CySwRPXddhIYzDkB9HNw"


--=-CySwRPXddhIYzDkB9HNw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-06-15 at 08:43 +0200, Richard Weinberger wrote:
> Okay, as expected, the ptrace SYSEMU request code is now an enum.
> Changed by in glibc:
> commit c48831d0eebf876d986919baf2d9240a79192837
> Author: Dmitry V. Levin <ldv@altlinux.org>
> Date:   Wed Dec 27 00:54:38 2017 +0000
>=20
>     linux/x86: sync sys/ptrace.h with Linux 4.14 [BZ #22433]
>    =20
>     Clone generic linux/sys/ptrace.h, add the following x86-specific
>     __ptrace_request constants: PTRACE_GET_THREAD_AREA,
>     PTRACE_SET_THREAD_AREA, PTRACE_ARCH_PRCTL, PTRACE_SYSEMU,
>     PTRACE_SYSEMU_SINGLESTEP, and PTRACE_SINGLEBLOCK.
>    =20
>     [BZ #22433]
>     * sysdeps/unix/sysv/linux/x86/sys/ptrace.h: New file.
>=20
> Does this change make UML build on your host?
>=20
> diff --git a/arch/x86/um/shared/sysdep/ptrace_32.h
> b/arch/x86/um/shared/sysdep/ptrace_32.h
> index b94a108de1dc..ae00d22bce02 100644
> --- a/arch/x86/um/shared/sysdep/ptrace_32.h
> +++ b/arch/x86/um/shared/sysdep/ptrace_32.h
> @@ -10,20 +10,10 @@
> =20
>  static inline void update_debugregs(int seq) {}
> =20
> -/* syscall emulation path in ptrace */
> -
> -#ifndef PTRACE_SYSEMU
> -#define PTRACE_SYSEMU 31
> -#endif
> -
>  void set_using_sysemu(int value);
>  int get_using_sysemu(void);
>  extern int sysemu_supported;
> =20
> -#ifndef PTRACE_SYSEMU_SINGLESTEP
> -#define PTRACE_SYSEMU_SINGLESTEP 32
> -#endif
> -
>  #define UPT_SYSCALL_ARG1(r) UPT_BX(r)
>  #define UPT_SYSCALL_ARG2(r) UPT_CX(r)
>  #define UPT_SYSCALL_ARG3(r) UPT_DX(r)
>=20

Thank you Richard.

That does fix the build. I built and verified it on i386 and amd64.

Thanks,
Ritesh

--=20
Ritesh Raj Sarraf
RESEARCHUT - http://www.researchut.com
"Necessity is the mother of invention."
--=-CySwRPXddhIYzDkB9HNw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQCVDstmIVAB/Yn02pjpYo/LhdWkFAlsjqf8ACgkQpjpYo/Lh
dWnMlQ//Y0QL+3WWAiSBRPmG7ZECHSlRw82M4Ut8iMQ/4CWINvBu59UYFK0x9j8x
ggIVEMn0TLwRIGrBUT5HP++2BkTB2BOsjoFr54mjETcXAZ48FhccapmTvgdMZ8sN
O/t6wScaly0Uba92t2OO9+aGry1q9Kl8KCpICZUMuvsFYMgIMJgL6Wl7vFbV8PNU
bMYdnuQ8h6EX97KSwh39ik4NTuN2fhx+INkVWVDhR0xdH2jlgRBjXDg+v1qN/jJS
bfceSUQ8Fub6hQOZxFQ35qHaI+AtwS06Qv1tDsVcE+6B7DAS79534TYutoGKSI7U
ZyNM9IbPkFWKOoMqvVugvrsZsh1QNaqmfGNrt9Ixg3g/gJUJHI3TilbFOtn6oTs6
reIgMpF2cAPJ+KIWPgieUP9YktgE1+lFoEOqcsihEg0KMmzEiiZM7YXajX9qC9Rx
9++gKJRfy/F7/yOZwEnDYMonGXT0iFnaCI4c3YEEg6+CYWaZuupjVNNFcsflhUnD
H05pf807UqUeEjAZhJvnp2MuXdw0cS+kG4PJPDV/hOZFxYEcS1fAcYlMZkkoNTn4
AuEd3Vy6Xe6YqGQ/rf3ep9ovSg8z9L5/fpsWBIS8Dxi+Hejqf4KmnpImmV4tgtTj
aDnRpl1vlp0xs90Ov0/JnhyEsjYkBPVCa9Kln0gzUK/zdEsDMt4=
=u0vo
-----END PGP SIGNATURE-----

--=-CySwRPXddhIYzDkB9HNw--



--===============6602410206268147459==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============6602410206268147459==--



