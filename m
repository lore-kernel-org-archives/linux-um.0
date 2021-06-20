Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1luwDG-000wzZ-F3
 for linux-um@lists.infradead.org; Sun, 20 Jun 2021 12:06:08 +0000
Message-ID: <84f937926c2341651927a8efbbe47ef56980feac.camel@sipsolutions.net>
Subject: Re: [PATCH 03/27] um: Drop support for hosts without
 SYSEMU_SINGLESTEP support
From: Benjamin Berg <benjamin@sipsolutions.net>
Date: Sun, 20 Jun 2021 14:05:58 +0200
In-Reply-To: <CAFLxGvwvpz26-RGw_isFYQq4PzOzbMoQOcXb5gxTYq3+vMxHaQ@mail.gmail.com>
 (sfid-20210619_221807_950608_C9764135)
References: <20210303155523.124277-1-benjamin@sipsolutions.net>
 <20210303155523.124277-4-benjamin@sipsolutions.net>
 <CAFLxGvwvpz26-RGw_isFYQq4PzOzbMoQOcXb5gxTYq3+vMxHaQ@mail.gmail.com>
 (sfid-20210619_221807_950608_C9764135)
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4062109461290840778=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: linux-um <linux-um@lists.infradead.org>


--===============4062109461290840778==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-PbcR2/XovCEQrWMBh0HZ"


--=-PbcR2/XovCEQrWMBh0HZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2021-06-19 at 22:17 +0200, Richard Weinberger wrote:
> On Thu, Mar 4, 2021 at 12:03 AM Benjamin Berg
> <benjamin@sipsolutions.net> wrote:
> >=20
> > These features have existed since Linux 2.6.14 and can be considered
> > widely available at this point.
>=20
> [...]
>=20
> > -#ifndef PTRACE_SYSEMU
> > -#define PTRACE_SYSEMU 31
> > -#endif
> > -#ifndef PTRACE_SYSEMU_SINGLESTEP
> > -#define PTRACE_SYSEMU_SINGLESTEP 32
> > -#endif
>=20
> Where did you test this? On my OpenSUSE 15.2 machine this change
> causes a build failure.

I have been testing this on Fedora, currently F34 (x86_64).

> arch/um/os-Linux/start_up.c: In function =E2=80=98check_sysemu=E2=80=99:
> arch/um/os-Linux/start_up.c:153:14: error: =E2=80=98PTRACE_SYSEMU_SINGLES=
TEP=E2=80=99
> undeclared (first use in this function); did you mean
> =E2=80=98PTRACE_SINGLESTEP=E2=80=99?
> =C2=A0=C2=A0 if (ptrace(PTRACE_SYSEMU_SINGLESTEP, pid, 0, 0) < 0)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~~
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 PTRACE_SINGLESTEP
>=20
> I think we need to carefully include the right asm headers.

Hmm, possibly. For me the definition is coming from the glibc headers
right now:

# 26 "arch/um/os-Linux/start_up.c" 2
# 1 "./arch/um/include/shared/ptrace_user.h" 1
# 9 "./arch/um/include/shared/ptrace_user.h"
# 1 "/usr/include/sys/ptrace.h" 1 3 4
# 26 "/usr/include/sys/ptrace.h" 3 4

sys/ptrace.h is in turn is provided by glibc-headers-x86-2.33-
16.fc34.noarch.

Not sure what the right thing here is. One could include
"linux/ptrace.h", but those are #defines, while the glibc header uses
an enum. I think it'll work if one first includes the glibc header for
the function definition and only then the kernel header. But, that
seems odd to me right now, and I am not why=20

Benjamin

--=-PbcR2/XovCEQrWMBh0HZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEED2NO4vMS33W8E4AFq6ZWhpmFY3AFAmDPLyYACgkQq6ZWhpmF
Y3AOfg/+P3M2oNPBDfnK00uOzwkqrha/s28bsvlhuLa4q/3b23axfx4h4vDA9z3W
WwVzgMmQIpRcEfmicILMPzZvBea+dnxfouZwylXe3gGNpgjB4WoO/CcOnT2vWFEu
M/XR7ETNRKAXMN5BtK87YoLFAwYbjmDuPlilDVhpw2SU0/uf3J2pLhkp10864g+j
pHHweGfGRFsLuUSFUKnftQxlmO7yCqdZ7F+zpR7IySQW3WgdAB4NWnj8uYjyX1m+
i+K6Sn0BWOSt1Fd/xkL6jkJ1uwuVByZUI8e7uQ2E8txINN7zdGDmq+gyW2mYe84e
rI4+BbyRBMxpQ2UmK4Wm1cipAh+CCZnmDKyRuzfJ176owAV8nT8RczgnZ90fA7Fa
eBGr1VHUpHC9E175CUzFr+2JB7oG8vX1nqpjyGKHEznTWw5WMLTdyikGjavMz83l
2L6PyJYR4IwdafRQ+ZQlttmntIreqIJRPqaQBQDH1kOmGssbBl5a5FRRYVMXyg5K
XvUsGJ/c7MnHowLYu1nlfQ1G0bxma8gZQuQSEhSk+Ucvfke4wRShi44NGVUtUkxX
xNLSr7HaDs4PbndXMDaPaBqAU2wpbaSUhJAU2UxUGbGLM+1K8swTcGVG2VzZUYZj
CrYag/gblrEy8Z3fk0TOwZrDpgqgzeFVLqAEMkFUwx24EEoeDdw=
=dWA1
-----END PGP SIGNATURE-----

--=-PbcR2/XovCEQrWMBh0HZ--



--===============4062109461290840778==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============4062109461290840778==--



