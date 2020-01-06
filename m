Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ioW8P-000419-2J
 for linux-um@lists.infradead.org; Mon, 06 Jan 2020 17:25:46 +0000
Received: by mail-pl1-x641.google.com with SMTP id x17so22096471pln.1
 for <linux-um@lists.infradead.org>; Mon, 06 Jan 2020 09:25:44 -0800 (PST)
Message-ID: <bb3c230ca486ca8dcf1640c357be8d4025d5109b.camel@debian.org>
Subject: Re: Bug#928924: user-mode-linux: xterm functionality broken due to
 wrong path to port-helper
From: Ritesh Raj Sarraf <rrs@debian.org>
Date: Mon, 06 Jan 2020 22:55:21 +0530
In-Reply-To: <95a2a1cdb323633a0779acaeb0377ed60e7e3afc.camel@debian.org>
References: <451d491044af46fe1d87d10196e24e8e7b076f26.camel@debian.org>
 <157830351172.48768.9073767232890169518.reportbug@beast>
 <95a2a1cdb323633a0779acaeb0377ed60e7e3afc.camel@debian.org>
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
Content-Type: multipart/mixed; boundary="===============8464190044347047576=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: 928924@bugs.debian.org
Cc: linux-um@lists.infradead.org


--===============8464190044347047576==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-+av4Mlpi0YF7GQ9z9YSM"


--=-+av4Mlpi0YF7GQ9z9YSM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-01-06 at 21:51 +0530, Ritesh Raj Sarraf wrote:
> First, for context to the readers here, the port-helper binary is
> shipped with uml-utilities package. This package, depending on the
> architecture, installs the binary to a architecture specific
> location.
>=20
> https://sources.debian.org/src/uml-utilities/20070815.2-1/Makefile/#L10
>=20
> Which on an amd64 machine is: /usr/lib64/uml/port-helper

So 2 things I noticed on my machine.

1. There's nothing else under /usr/lib64/ on my Debian box. Even UML's
modules are built and installed under /usr/lib/

```
rrs@priyasi:/usr/lib$ ls uml/modules/5.4.6/
kernel/        modules.alias.bin  modules.builtin.bin      modules.dep=20
     modules.devname  modules.softdep  modules.symbols.bin
modules.alias  modules.builtin    modules.builtin.modinfo  modules.dep.
bin  modules.order    modules.symbols
22:18 =E2=99=92 =E0=A5=90  =E2=98=BA =F0=9F=98=84   =20
rrs@priyasi:/usr/lib$ ls ../lib64/
uml/
22:18 =E2=99=92 =E0=A5=90  =E2=98=BA =F0=9F=98=84   =20
rrs@priyasi:/usr/lib$ ls ../lib64/uml/
port-helper*
22:18 =E2=99=92 =E0=A5=90  =E2=98=BA =F0=9F=98=84   =20
```


2. Given that /usr/lib64/ is empty, quick immediate workaround could be to =
patch uml-utilities
and ship the binary under /usr/lib/. That would solve all these issues.


--=20
Ritesh Raj Sarraf | http://people.debian.org/~rrs
Debian - The Universal Operating System

--=-+av4Mlpi0YF7GQ9z9YSM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQCVDstmIVAB/Yn02pjpYo/LhdWkFAl4TbYEACgkQpjpYo/Lh
dWnhOQ/+LxY/mZlXQvCfGAg7z+dzZGCzzxAAd8mbtZPtWzmW740nyPy3xh8Q3Wfb
c2OoiuU1dW5mPkR51ZLawDHSG3dxZmSBxEAPcCVGeaZ/sxI6e7cctLAHZWsBoZq+
xoezxZrkYGBvTs16ncdzE68G4yAg9UHBn5q9A+1nLwSFVy+UGbQZCM/ZhjOMEHBS
AGghnX398Rtf4kLidEVjsXOKx7NmWLiTEQpOWm00JJIeWacc48o7SYRmagHfXYlx
Zmw05ssahAEkMRmwj1/JFQe81dH2fk4pLYjkhPj4adG8ORNqOVRxSSCkxkD9zQl3
XKFM13muShVvMM3ryZOrpuJIoX/JwMvYwEQzd/l3roo3JoCbaHLWYgCJz6bRfwoX
O5kJOY/WLwrjeFjamoOykt6GN6b+qjRSZiRC2rRyAbwyAc3Pz7kncfxT766j1bNY
yMdJ8getNxn0sls+zAVU1VZugwx/qKbJEX3R/8XFnW05YCZaVofCTlmRBGwx6zpz
4LF+EAPvO987nprc47DAqLcLXNIq2GDK6/1PvHHZJQ06OeYPLJ02Lna8P1WyBDFv
BpWvbeZMiAhyhDVgr4n3pDvrz3lG3txtTT9ItWFXlDwfpj07rwDZfzCDC/59HNxa
LI9yLuSSo++cuNKzrSOGW2ZqDdcR26qulPKFf/etMCjC95s8oeg=
=mwr2
-----END PGP SIGNATURE-----

--=-+av4Mlpi0YF7GQ9z9YSM--



--===============8464190044347047576==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============8464190044347047576==--



