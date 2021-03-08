Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJD8e-00GRtL-Tv
 for linux-um@lists.infradead.org; Mon, 08 Mar 2021 10:29:27 +0000
Received: by mail-pj1-x1036.google.com with SMTP id
 q6-20020a17090a4306b02900c42a012202so2860865pjg.5
 for <linux-um@lists.infradead.org>; Mon, 08 Mar 2021 02:29:23 -0800 (PST)
Message-ID: <358bce016384468722ba5cf42d2b5ae8650868e6.camel@debian.org>
Subject: Re: Bug#983379: [PATCH] um: mark all kernel symbols as local
From: Ritesh Raj Sarraf <rrs@debian.org>
Date: Mon, 08 Mar 2021 15:59:10 +0530
In-Reply-To: <ca04eca09e65939f1b828b7572c91e9cb2046b4b.camel@debian.org>
References: <3448a70e7a39b9c3202aeefa7858ace265b8a978.camel@debian.org>
 <20210305214315.75ea78f93d79.I410acf4509c4ff51aac4a03df61d19abfa0454cb@changeid>
 <5d04179e-5ba5-a0cc-e514-c90feea5eb00@cambridgegreys.com>
 <161406935658.1350056.9530002632452194106.reportbug@beast>
 <ca04eca09e65939f1b828b7572c91e9cb2046b4b.camel@debian.org>
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
Content-Type: multipart/mixed; boundary="===============0482670241742316250=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: 983379@bugs.debian.org, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: Christopher Obbard <chris.obbard@collabora.com>, Johannes Berg <johannes.berg@intel.com>


--===============0482670241742316250==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-4jR4FnwHK+XVFNwPWyWD"


--=-4jR4FnwHK+XVFNwPWyWD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Just a follow-up question on this fix.

Is it something that is a candidate for linux-stable ?


Thanks,
Ritesh

On Sat, 2021-03-06 at 16:21 +0530, Ritesh Raj Sarraf wrote:
> > > Marking all the symbols as local seems correct, and does seem
> > > to address the issue, so do that. Also do it for static link,
> > > nsswitch libraries could still be loaded there.
> > >=20
> > > [1] https://bugs.debian.org/983379
> > >=20
> > > Reported-by: Ritesh Raj Sarraf <rrs@debian.org>
> > > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> > > ---
> > > =C2=A0 arch/um/kernel/dyn.lds.S | 6 ++++++
> > > =C2=A0 arch/um/kernel/uml.lds.S | 6 ++++++
> > > =C2=A0 2 files changed, 12 insertions(+)
> > >=20
> > > diff --git a/arch/um/kernel/dyn.lds.S b/arch/um/kernel/dyn.lds.S
> > > index dacbfabf66d8..2f2a8ce92f1e 100644
> > > --- a/arch/um/kernel/dyn.lds.S
> > > +++ b/arch/um/kernel/dyn.lds.S
> > > @@ -6,6 +6,12 @@ OUTPUT_ARCH(ELF_ARCH)
> > > =C2=A0 ENTRY(_start)
> > > =C2=A0 jiffies =3D jiffies_64;
> > > =C2=A0=20
> > > +VERSION {
> > > +=C2=A0 {
> > > +=C2=A0=C2=A0=C2=A0 local: *;
> > > +=C2=A0 };
> > > +}
> > > +
> > > =C2=A0 SECTIONS
> > > =C2=A0 {
> > > =C2=A0=C2=A0=C2=A0 PROVIDE (__executable_start =3D START);
> > > diff --git a/arch/um/kernel/uml.lds.S b/arch/um/kernel/uml.lds.S
> > > index 45d957d7004c..7a8e2b123e29 100644
> > > --- a/arch/um/kernel/uml.lds.S
> > > +++ b/arch/um/kernel/uml.lds.S
> > > @@ -7,6 +7,12 @@ OUTPUT_ARCH(ELF_ARCH)
> > > =C2=A0 ENTRY(_start)
> > > =C2=A0 jiffies =3D jiffies_64;
> > > =C2=A0=20
> > > +VERSION {
> > > +=C2=A0 {
> > > +=C2=A0=C2=A0=C2=A0 local: *;
> > > +=C2=A0 };
> > > +}
> > > +
> > > =C2=A0 SECTIONS
> > > =C2=A0 {
> > > =C2=A0=C2=A0=C2=A0 /* This must contain the right address - not quite=
 the
> default
> > > ELF one.*/
> > >=20
>=20
> Tested on all 3 machines where the issue was seen before.
>=20
>=20
> >=20
> > Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>=20
> Tested-By: Ritesh Raj Sarraf <rrs@debian.org>

--=20
Ritesh Raj Sarraf | http://people.debian.org/~rrs
Debian - The Universal Operating System

--=-4jR4FnwHK+XVFNwPWyWD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQCVDstmIVAB/Yn02pjpYo/LhdWkFAmBF/HYACgkQpjpYo/Lh
dWkq/w//bvfox/d/k6Of86PaUPgAJ/ykr7pCKCHICSj2XRj4Oemlz7hmeisHKxYs
96AiLU7oxOt+itduLqH1/MNyJJtAW+d7ckPgBCtBAg2wpb5zrWTt+Zcfw2QRT1zM
C3HEgn6rzBsMr+gNNiymPlXJZRmkiBadt6UxNJyPEUC+HCR6Lq5YQ11rXLUk+KRP
XVKrbvf7maN/X0wn8s1VT+hjhfvEpRunWE89Wkr8u6tsZRlB+dvokTHCpgQMYOF5
YZRM0OwM4/u9nwE+TSj+HkrHPK+0Nw5IDyNjKQaIS0YuwSyEg4An+VHSdHnFVb83
cv7m1H9F+R381Zo1BlRbAF76HGwZGZAGdQZ9kLNIffU0KKMw69ak9rvf+n1EU+on
RoAIslYOx7bY6Mn0KUMLiuJ5qRGpWiPkMHut7oagAeBJyyFRYYQlDWL6qaWsQFBi
V4awwkv/0lngbvqgN3dOLpfkkDvWLKKB/WNvuc1JfegiOovmH0AmK3QPxqcYqixM
BhvM2fXLJ7n15y1ImVon6k1ERjhbxSJJcno1GYMxfIE5nwkmcmKZZEs6rVxngifC
UYGsJcP8102rqSZQsqV5c41purFbYQ0UK4IGPJogGv+N+3Z4lN4wNZ27CRgthsTc
3OlpoPynRpHCZNglhEChNz1z/Vv+VBSOtliWv1/K/eOZ8HgAbYI=
=m1ES
-----END PGP SIGNATURE-----

--=-4jR4FnwHK+XVFNwPWyWD--



--===============0482670241742316250==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============0482670241742316250==--



