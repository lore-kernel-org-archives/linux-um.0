Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHP1j-002Emm-Pg
 for linux-um@lists.infradead.org; Wed, 03 Mar 2021 10:46:49 +0000
Received: by mail-pf1-x433.google.com with SMTP id q204so14928121pfq.10
 for <linux-um@lists.infradead.org>; Wed, 03 Mar 2021 02:46:47 -0800 (PST)
Message-ID: <e86375146432f4fa12da18525d99c56292af72ac.camel@debian.org>
Subject: Re: Bug#983379: linux uml segfault
From: Ritesh Raj Sarraf <rrs@debian.org>
Date: Wed, 03 Mar 2021 16:15:38 +0530
In-Reply-To: <3e230682-5bb8-4e86-123d-b157728d489b@kot-begemot.co.uk>
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
 <161406935658.1350056.9530002632452194106.reportbug@beast>
 <3e230682-5bb8-4e86-123d-b157728d489b@kot-begemot.co.uk>
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
Content-Type: multipart/mixed; boundary="===============7800872331998579222=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>, 983379@bugs.debian.org, Christopher Obbard <chris.obbard@collabora.com>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>


--===============7800872331998579222==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-egv5v90dyTdl8tmzTg73"


--=-egv5v90dyTdl8tmzTg73
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

HI Anton,

On Wed, 2021-03-03 at 09:30 +0000, Anton Ivanov wrote:
>=20
> >=20
> > OTOH, I have one more user (other than you) who's not been able to
> > reproduce the issue.
> >=20
> > > I will do a dissect the moment I figure out how to reproduce it.
> > > I
> > > will try to do some more experiments on that tomorrow.
>=20
> I tried to alter the userspace a bit, but it makes no difference.
>=20
> Out of curiosity, what are you running it on?
>=20

Bare-metal machines. 3 different machines, all Intel processors.
And it fails on all 3 of them.

On the distribution side, all 3 of them run Debian Unstable, with Linux
5.10.13

> >=20
>=20
> The code here is:
>=20
> static inline u32 printk_caller_id(void)
> {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return in_task() ? task_p=
id_nr(current) :
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A00x80000000 + raw_smp_processor_id();
> }
>=20
>=20
> That is something which should not bomb out unless we have memory
> corruption or something along those lines - current being invalid.
>=20

Must be something different. Not all machines could have bad memory at
the same time.


--=20
Given the large number of mailing lists I follow, I request you to CC
me in replies for quicker response

--=-egv5v90dyTdl8tmzTg73
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQCVDstmIVAB/Yn02pjpYo/LhdWkFAmA/aNIACgkQpjpYo/Lh
dWn4eQ/9EpwKAkRhf7lObcpte0G6XDuE1MG8NcnPIQuGaVTgb8kN0ZQRc+hYTpUB
xlZBGe22g2yJ3TulN610YM5KBwGuyB1xVAxdWAFqzbZttSAIw5ZBoF6jWoh4U7TZ
NUMrtHhHb9Ou7tRIK45vlWH9fA5nnB3ABQBLOyKzbpjitXGaq7HGbq/4kZ6Rbl5d
VsDw7gDhQp/Ix7UqHQAEVGQLwaNftBj76Anb7ODD9uf7YfyXPH3Z6vcwjjzkj1Jk
+Aeg4PO2HhAv9o/N9PxMKGuubxIlaIYtV5ykxV5jxfnG7XZRIiZgP1eb0X6i1d1/
k/chs9mmnTnhfU5QZQKJ7lLemt4Ucwpkx5iNgqG67PJl4eBuFrlLldG1BDDCGm5W
qJxssrjU488f6OEXWIZmhJzobw9kPH8mFUtIw1Q0d5dR4aANbEoGsIuuGBhrPwu1
mboRGFk96aINPUZVaK15oBzCKGl4IjPdOTpWEVPdz//HLoO26IKQEwV+qr4ir+r2
nF+8sd4ieggRoCXvSQ6nMS/nVVBh89DS5XdwyMaqtAbz1smXMEfEWzLPJyl6Z0Hf
JfLIgGTQUe0e2Adc8Vl2QHpssRpospayjsdYlqO/2vFuWOCf/BPnxqT7LKSD8fEm
pLD+arZnDtfgha0/nKWlmwqVFFmbfFRopWpb21NP2WpeRrGqkyU=
=Yf6q
-----END PGP SIGNATURE-----

--=-egv5v90dyTdl8tmzTg73--



--===============7800872331998579222==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============7800872331998579222==--



