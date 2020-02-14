Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j2ZIO-0004ap-IT
 for linux-um@lists.infradead.org; Fri, 14 Feb 2020 11:38:09 +0000
Received: by mail-pg1-x52d.google.com with SMTP id 70so4829668pgf.8
 for <linux-um@lists.infradead.org>; Fri, 14 Feb 2020 03:38:07 -0800 (PST)
Message-ID: <41e0199cf2ad126bca3047d18e14493ab903bbe6.camel@researchut.com>
Subject: Re: Documentation for UML Vector network
From: Ritesh Raj Sarraf <rrs@researchut.com>
Date: Fri, 14 Feb 2020 17:08:03 +0530
In-Reply-To: <c6774e9e-7811-cbbb-eea5-83e5045b59e9@kot-begemot.co.uk>
References: <7c37a3f7310c0be2202ada464e31c2d4d424c502.camel@researchut.com>
 <32d50bed-cfdb-288a-181c-e186143c8169@kot-begemot.co.uk>
 <44b7a3a49731dfabe9cdfbeb281ad9470e71b625.camel@researchut.com>
 <c6774e9e-7811-cbbb-eea5-83e5045b59e9@kot-begemot.co.uk>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Reply-To: rrs@researchut.com
Content-Type: multipart/mixed; boundary="===============4943299132634941293=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>, linux-um@lists.infradead.org


--===============4943299132634941293==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-gl2DumAOIbLQTxWrlCQT"


--=-gl2DumAOIbLQTxWrlCQT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Anton,

On Wed, 2020-02-12 at 15:54 +0000, Anton Ivanov wrote:
> In first instance I intend to update that. There is actually a .rd
> markup version in progress for the next kernel versions.
>=20
> A wiki will be nice, because there is no way to fit all new UML
> features like direct tunnel/overlay attachment, time travel, etc in
> the documentation in the kernel tree.

A follow-up question.

The traditional UML networking modes supported slirp, which allowed for
unprivileged networking access.=20

Is that something achievable with UML Vector network ?
We have a use case where we want to be able be capable to use UML with
network features. But do not have necessary privileges to set
networking up on the host.


--=20
Ritesh Raj Sarraf
RESEARCHUT - http://www.researchut.com
"Necessity is the mother of invention."

--=-gl2DumAOIbLQTxWrlCQT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQCVDstmIVAB/Yn02pjpYo/LhdWkFAl5GhpsACgkQpjpYo/Lh
dWk+yw//dPOta4lcdvalMsyfeOb42CB58kY/jfzvPHPESCbhuwctMXQy9zuCi/Uu
p6yXFuoP+QDFf00u8LN2DROWbOBJ8+BfVUAo3SXTJGWELjeUmWYIzpKPs4AhWyFE
WhKIS0Uew+7bRZwAWwhKf1fBAAs32GkiGJpxLWFJnbUdRkyPbLc7x+NMuDIR4Nlk
2Lw7lo8eaZI3NAI/wcy/kgiheQurVp/eLvnk64q2hN9KXTZrRg6AYTHb1ONpOl2u
LWp2a3JeA7LGu59YUXvaehfck2lq8AdC56FhuNrUscPbiqZqW8Lli8YL+CGM3Xzt
cDiQtVpR9UhMQkpK+Gjwvdkih187B1i7ZSBPzOc0/qWogI/JC1/4W+ya+cL5YQhM
4cBsDkXECf8IiQ4M4PBJfNIQL5GU0c81hXlR4YCbctYp9o6pmswOdMZEXr9gvPgL
VJIW4iCprHMTyc5++3VLioWHzsKcGxrjFalr/OtBXsd9S1Vd63QWn33WvP257Vhb
L1XnLhjbWazrnffcNEus6qkkwZROOlLnkjP5dhzqFkQZU6ibDW0GalqpwT69zohx
IrbS/fSo0/1mMINE9q0yU+KF7hIsVPTm75OjN9XIPO0VO5PDnc/XzR9NLg+j5i3m
bvE7N5ft4ERFdkb6JbxVf+BZSdw76IiwNlYklaNMWNw6DslOueE=
=hVt1
-----END PGP SIGNATURE-----

--=-gl2DumAOIbLQTxWrlCQT--



--===============4943299132634941293==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============4943299132634941293==--



