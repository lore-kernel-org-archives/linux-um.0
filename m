Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ioV8Q-0004bd-G1
 for linux-um@lists.infradead.org; Mon, 06 Jan 2020 16:21:44 +0000
Received: by mail-pj1-x1043.google.com with SMTP id m13so7964850pjb.2
 for <linux-um@lists.infradead.org>; Mon, 06 Jan 2020 08:21:41 -0800 (PST)
Message-ID: <95a2a1cdb323633a0779acaeb0377ed60e7e3afc.camel@debian.org>
Subject: Re: Bug#928924: user-mode-linux: xterm functionality broken due to
 wrong path to port-helper
From: Ritesh Raj Sarraf <rrs@debian.org>
Date: Mon, 06 Jan 2020 21:51:36 +0530
In-Reply-To: <157830351172.48768.9073767232890169518.reportbug@beast>
References: <451d491044af46fe1d87d10196e24e8e7b076f26.camel@debian.org>
 <157830351172.48768.9073767232890169518.reportbug@beast>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Reply-To: rrs@debian.org
Content-Type: multipart/mixed; boundary="===============0070498601403580167=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Sjoerd Simons <sjoerd@debian.org>, 928924@bugs.debian.org
Cc: linux-um@lists.infradead.org


--===============0070498601403580167==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-0wIsQa6lV4juzfO00ErN"


--=-0wIsQa6lV4juzfO00ErN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Control: tag -1 +help

On Mon, 2020-01-06 at 10:38 +0100, Sjoerd Simons wrote:
> On my sid system:
> ```
> $ strings /usr/bin/linux.uml | grep port-helper
> /usr/lib//uml/port-helper
> ```
>=20
> So the path is still incorrect even with newer upstream kernels.

I spent some time today looking at the new build but I haven't been
able to ascertain why this isn't setting the correct path.

```
$ strings `which  linux.uml` | grep port-helper
/usr/lib/uml/port-helper
```

First, for context to the readers here, the port-helper binary is
shipped with uml-utilities package. This package, depending on the
architecture, installs the binary to a architecture specific location.

https://sources.debian.org/src/uml-utilities/20070815.2-1/Makefile/#L10

Which on an amd64 machine is: /usr/lib64/uml/port-helper

```
$ dpkg  -S /usr/lib64/uml/port-helper
uml-utilities: /usr/lib64/uml/port-helper
```

The UML setup on my box always worked because long back, when I first
encountered this problem, I had created a symlink of the path to
/usr/lib/ too. And had completely forgotten about it. My apologies.


But that said, the current problem is with the UML binary built by the
kernel sources.
Problem is that, as mentioned above and other reports too on this bug
report thread, the path resolved at build time is always
"/usr/lib/uml/".

The build configuration and the code are all correct.

```
$ grep 64BIT .config
CONFIG_64BIT=3Dy
CONFIG_64BIT_TIME=3Dy
CONFIG_PHYS_ADDR_T_64BIT=3Dy
CONFIG_ARCH_DMA_ADDR_T_64BIT=3Dy
```


Snipped from: arch/um/include/shared/os.h

```
#ifdef CONFIG_64BIT
#define OS_LIB_PATH     "/usr/lib64/"
#else
#define OS_LIB_PATH     "/usr/lib/"
#endif
```

I also checked the generated include headers and they are correct for
the amd64 .config file.

```
linux-source-5.4/include/generated$ grep 64BIT autoconf.h=20
#define CONFIG_64BIT_TIME 1
#define CONFIG_PHYS_ADDR_T_64BIT 1
#define CONFIG_64BIT 1
#define CONFIG_ARCH_DMA_ADDR_T_64BIT 1
```

I'll keep looking as time permits but if anyone else has ideas on what
I may be doing wrong, please do mention.

Thanks,
Ritesh

--=20
Ritesh Raj Sarraf | http://people.debian.org/~rrs
Debian - The Universal Operating System

--=-0wIsQa6lV4juzfO00ErN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQCVDstmIVAB/Yn02pjpYo/LhdWkFAl4TXpAACgkQpjpYo/Lh
dWmDVA//VE7XWluxHUWVk/vOrSbNlzztDwlQnBlAtiA6myb8LgioTeSn37Y/gtPj
kEAaFeHKSHK2vl6UGbruB3GSNGW3iXa0Ma2Z18rdubIDGWd22zZvGU/aBfGa1Qpl
y4vXw8eY9J6hI+m5NkeBaJWQy31NtIkEA3aRJahmHD/JvfguEmhzkkznHFCpxakC
ksJQSps2Jgehxr2z8SAnSlRnUyIVjAegbNKJNB5UOtifhHZkUAmBZsxAaw9RHn2B
Pg+CUzjQTz70rCrhpm+m0vl6a61Qdz8J7pJCJ+N59JvA4UaLzok+3UY3UywQx/hc
Yqi3m2bCowdcyb/KfCv0or2mqQAKdFFyPe75SYF/kqjYBIQH+VhuOPO3YIfGd96l
5gt8B/TuMegd4AVGcOjfX5JovzZmt4Ln9YAqhaOW0gAiPIbprnfbHItqC17IpQg+
cImD1DBwIqQRpjRVizimnOFExRBf3KOGz5rD/Z3zBuTmtwYWkr1UKNGZrrBQIFel
lV2jZOMv6EM5NSJi/PrYKFjmSGZbZA+8yYQ9SGp+sCDQO88KQPDhWCN2FliKb9MI
tgcpOfDdOdfq7dB19nZdJ86pLUSHB0nbNPZFbQbBm/q/7t4p+2fMpm7/0G5nj7G9
UccPkGQCqvPqZMBDttObUdrxiDWw5p1q6t94NJA+yRroEcQB6sI=
=UDQp
-----END PGP SIGNATURE-----

--=-0wIsQa6lV4juzfO00ErN--



--===============0070498601403580167==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============0070498601403580167==--



