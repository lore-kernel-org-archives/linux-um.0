Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ioWDI-0006Qm-9Z
 for linux-um@lists.infradead.org; Mon, 06 Jan 2020 17:30:49 +0000
Received: by mail-pg1-x541.google.com with SMTP id l24so27182571pgk.2
 for <linux-um@lists.infradead.org>; Mon, 06 Jan 2020 09:30:47 -0800 (PST)
Message-ID: <77154e8f71433fc0411b65b996a80641380fb717.camel@debian.org>
Subject: Re: Bug#928924: user-mode-linux: xterm functionality broken due to
 wrong path to port-helper
From: Ritesh Raj Sarraf <rrs@debian.org>
Date: Mon, 06 Jan 2020 23:00:38 +0530
In-Reply-To: <4d26aa36-d2ab-b7f1-6cd6-abf1b158fe0a@kot-begemot.co.uk>
References: <451d491044af46fe1d87d10196e24e8e7b076f26.camel@debian.org>
 <157830351172.48768.9073767232890169518.reportbug@beast>
 <95a2a1cdb323633a0779acaeb0377ed60e7e3afc.camel@debian.org>
 <4d26aa36-d2ab-b7f1-6cd6-abf1b158fe0a@kot-begemot.co.uk>
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
Content-Type: multipart/mixed; boundary="===============1357763793479660287=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>, 928924@bugs.debian.org
Cc: linux-um@lists.infradead.org


--===============1357763793479660287==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-v7d0Msxfwow0H1jV38pK"


--=-v7d0Msxfwow0H1jV38pK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-01-06 at 16:58 +0000, Anton Ivanov wrote:
> On 06/01/2020 16:21, Ritesh Raj Sarraf wrote:
> > Control: tag -1 +help
> >=20
> > On Mon, 2020-01-06 at 10:38 +0100, Sjoerd Simons wrote:
> > > On my sid system:
> > > ```
> > > $ strings /usr/bin/linux.uml | grep port-helper
> > > /usr/lib//uml/port-helper
> > > ```
> > >=20
> > > So the path is still incorrect even with newer upstream kernels.
> >=20
> > I spent some time today looking at the new build but I haven't been
> > able to ascertain why this isn't setting the correct path.
>=20
> It is used in a "user" side file - xterm.c
>=20
> None of these sees "CONFIG_" so it considers it undef-ed which
> defaults=20
> to 32 bit.
>=20
> You need to use some other way to figure out what is the build or to
> set=20
> OS_LIB_PATH for this case.

Thank you for the quick reply Anton.


--=20
Ritesh Raj Sarraf | http://people.debian.org/~rrs
Debian - The Universal Operating System

--=-v7d0Msxfwow0H1jV38pK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQCVDstmIVAB/Yn02pjpYo/LhdWkFAl4Tbr4ACgkQpjpYo/Lh
dWn2eQ/+MslVAUODrH9HmbXbhg+KlmrAtTQd46H7ettMFR1JEyNeMvG6Qi/gm0yZ
vWh5o9XbDvqSr7xAvYbb4B6P4S0r64MVdTGpvGF/UngVTd/4r4nNqRZZTe9C+/jQ
R+QjHgw7RS6oLjHkW3iOcejdGD+ZJUksEtds2FDF5pnS+rXj9Ore3V8LkCwcIGCE
+hOqrzZbJw5pC101vqrIHk8FZm20vCW+dTrFn4RsV00ESSfqawd2SeOuilUPtwes
om6OiWSSwrUyPMo2Uays2HoBNbpg22L2+LJCZZidWo8n2uHrd486B2Zeo5d0j12g
VpMmB6DGZD0cB7GqqHHRy9n+SaJ2N9IC4zg0MXd+Ch+iy0TzxZpbIt362sZbnAK3
5aAZi2u/qVtSRkWyTGXwFlAHVD7OUJvaKiFx6+L9qnzWK7NfowPdrfT8Jw9Sg0u+
h/dEazCRCnJa0wllNESTc1atdzfUGmdqgD07m0nQH2UOsxn51/04HZpAI7AXofVW
q/T84GE+fAJWLC6zmoQ8fqfAlRadBNFsea6gvEior0o9bEt9SvqyJGCdr4nP2+g5
wsUDJkW6emKFYE9Fwe1wWfe2EmU9T6ImofM9xCIh640maUif+m+jrQjTYGUUgMtU
Xz8GeSq/diF4IrS9zIskN9Z99MW+f0q/4Dm8zs7HUYgHAQX+JZA=
=Soqs
-----END PGP SIGNATURE-----

--=-v7d0Msxfwow0H1jV38pK--



--===============1357763793479660287==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============1357763793479660287==--



