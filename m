Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHiyv-0086rL-0q
 for linux-um@lists.infradead.org; Thu, 04 Mar 2021 08:05:16 +0000
Message-ID: <19322b1442a7fc5938e026cb4eccc113a7c2328b.camel@sipsolutions.net>
Subject: Re: linux uml segfault
From: Benjamin Berg <benjamin@sipsolutions.net>
Date: Thu, 04 Mar 2021 09:05:04 +0100
In-Reply-To: <3c447c59bc30ba2bae1130ec89beddd699a0d21a.camel@sipsolutions.net>
References: <3448a70e7a39b9c3202aeefa7858ace265b8a978.camel@debian.org>
 <6d37b5aa-36f2-1fce-b70b-8faa0ff882e0@kot-begemot.co.uk>
 <c8bb257c-1542-12f5-89f1-5c1f14b8a70a@collabora.com>
 <db40449e-6916-56bf-377c-01b042b9c890@kot-begemot.co.uk>
 <529cd4e2f39efffb18125dffab3058aeec3351ce.camel@debian.org>
 <573e256a-990b-ddf6-7965-367bb8b21229@kot-begemot.co.uk>
 <1bdedf3c60058e1ae242a2a7f16eee256b0be3e0.camel@debian.org>
 <6370b92a-84fa-aa21-4270-fcaf1bf42407@kot-begemot.co.uk>
 <02e348bbb13f0fac92f2147309fb1c006b4583b2.camel@debian.org>
 <5ee28b97-6111-e12c-d0e9-83a13f2151ce@kot-begemot.co.uk>
 <5e068447e2067fff8b21c0689f14d080b984f6e0.camel@debian.org>
 <01a1b3551284a39a3c06ab2ec0222cbf6099a537.camel@sipsolutions.net>
 <m21rcv5vi5.wl-thehajime@gmail.com>
 (sfid-20210304_063856_031728_6ABDCCE2)
 <3c447c59bc30ba2bae1130ec89beddd699a0d21a.camel@sipsolutions.net>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1489539079260713687=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Johannes Berg <johannes@sipsolutions.net>, Hajime Tazaki <thehajime@gmail.com>
Cc: rrs@debian.org, anton.ivanov@kot-begemot.co.uk, chris.obbard@collabora.com, linux-um@lists.infradead.org, 983379@bugs.debian.org


--===============1489539079260713687==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-8M3K0qbUhoMAP8iBNWK2"


--=-8M3K0qbUhoMAP8iBNWK2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2021-03-04 at 08:47 +0100, Johannes Berg wrote:
On Thu, 2021-03-04 at 14:38 +0900, Hajime Tazaki wrote:

> > Now, I don't know how to fix it (short of changing your nsswitch
> > configuration) - maybe we could somehow rename sem_init()? Or maybe
> > we
> > can somehow give the kernel binary a lower symbol resolution than
> > the
> > libc/libpthread.
>=20
> objcopy (from binutils) can localize symbols (i.e., objcopy -L
> sem_init $orig_file $new_file).=C2=A0 It also does renaming symbols.=C2=
=A0 But
> not sure this is the ideal solution.

Yes, we started thinking about it but it was too late at night when I
replied ...

I think there's basically a way to have an external list of symbols to
export, for symbol versioning, that we could/should use to basically
not
export any of the kernel symbols out to libs.

Maybe using the ld --version-script=3D option here works to mark all
kernel symbols as being "local" and prevent them from being picked up
by libraries.

Benjamin

> How does UML handle symbol conflicts between userspace code and Linux
> kernel (like this case sem_init) ?=C2=A0 AFAIK, libnl has a same symbol a=
s
> Linux kernel (genlmsg_put) and others can possibly do as well.

I fear it doesn't?

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um



--=-8M3K0qbUhoMAP8iBNWK2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEED2NO4vMS33W8E4AFq6ZWhpmFY3AFAmBAlLAACgkQq6ZWhpmF
Y3AooBAApJMU9NvMVYNLWjQlNnG/4Ywiur2/jBiikCiti5k3Omz+eWjk+FvYGTdU
T7kF25lsobS063TeWtzuRIA0v/OotovnI+Dc3dkJz1bO7CPrf0mPuClTyEMkEKJ9
2HVArECUEL8AzK885Faj5XUfHCITFcCd/PJM1JDMXK2Vz3rFcgXVJnsVaS3Nd8f3
Sp1HezcbSMm4FoaTBuxmJUVgKKD4FR1ZfC9CRxE4Tv5hT4xk8CCMH3raEu/G+vYH
aDMPhDz+YIdttK2jqsWGiyo3x+fFUz4oRAwBrWNS+W3STOwH/y6pKJPYZveSS91D
houtuv6qwovwn02IiML5whcT3CJ6D6GmS1NQPMdKBKOk22oOrbzwEoy4Fe60TcJD
iOm9068l7u91alOJHpym0ctQfmM48jQ0VZcG2qscj5ZxNNRissfOr03HdUnE6wY5
vUtAqnLRih3l1n0nVEqmyltPbUZvrLweeX9pYlPDsfcWHnhYJ4a47oOg8m5DRi00
mOUN/Wq4T9f4q3ZmiR2FNSY5gOLKO6I3l6x1CuOfG+wDYQOKnbFXRq2V9OpzYw3h
QDKH7ayGTDaYdCytkBDeDO+xVaeLarNFWwraSPpCmlfFrLB0j0vcGlIV2ifi8yha
d1trAoIiN9PM59B6wBv6WVXarBfcEipIs92ACmh36iTjXt3esZ8=
=81fu
-----END PGP SIGNATURE-----

--=-8M3K0qbUhoMAP8iBNWK2--



--===============1489539079260713687==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============1489539079260713687==--



