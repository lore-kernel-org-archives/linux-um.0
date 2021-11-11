Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from bhuna.collabora.co.uk ([2a00:1098:0:82:1000:25:2eeb:e3e3])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mlDaX-008TXl-1N
 for linux-um@lists.infradead.org; Thu, 11 Nov 2021 17:10:15 +0000
Message-ID: <ba9a4b5405774f157df790c57d658b9f37e1ae61.camel@collabora.com>
Subject: Re: [PATCH] hostfs: Fix writeback of dirty pages
From: Ritesh Raj Sarraf <ritesh.sarraf@collabora.com>
Date: Thu, 11 Nov 2021 22:40:02 +0530
In-Reply-To: <20211105081052.2353801-1-sjoerd@collabora.com>
References: <20211105081052.2353801-1-sjoerd@collabora.com>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Reply-To: ritesh.sarraf@collabora.com
Content-Type: multipart/mixed; boundary="===============0346306290653689639=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Sjoerd Simons <sjoerd@collabora.com>, linux-um@lists.infradead.org
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org


--===============0346306290653689639==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-mPx2yEaImVsfjNu+RXgK"


--=-mPx2yEaImVsfjNu+RXgK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2021-11-05 at 09:10 +0100, Sjoerd Simons wrote:
> Hostfs was not setting up the backing device information, which means
> it
> uses the noop bdi. The noop bdi does not have the writeback
> capability
> enabled, which in turns means=C2=A0 dirty pages never got written back to
> storage.
>=20
> In other words programs using mmap to write to files on=C2=A0 hostfs neve=
r
> actually got their data written out...
>=20
> Fix this by simply setting up the bdi with default settings as all
> the
> required code for writeback is already in place.
>=20
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
>=20

Tested-by: Ritesh Raj Sarraf <ritesh@collabora.com>

> ---
>=20
> =C2=A0fs/hostfs/hostfs_kern.c | 3 +++
> =C2=A01 file changed, 3 insertions(+)
>=20
> diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
> index d5c9d886cd9f..ef481c3d9019 100644
> --- a/fs/hostfs/hostfs_kern.c
> +++ b/fs/hostfs/hostfs_kern.c
> @@ -924,6 +924,9 @@ static int hostfs_fill_sb_common(struct
> super_block *sb, void *d, int silent)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sb->s_op =3D &hostfs_sbop=
s;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sb->s_d_op =3D &simple_de=
ntry_operations;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sb->s_maxbytes =3D MAX_LF=
S_FILESIZE;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0err =3D super_setup_bdi(sb);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (err)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0goto out;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* NULL is printed as '(n=
ull)' by printf(): avoid that. */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (req_root =3D=3D NULL)

--=20
Ritesh Raj Sarraf
Collabora

--=-mPx2yEaImVsfjNu+RXgK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQCVDstmIVAB/Yn02pjpYo/LhdWkFAmGNTmoACgkQpjpYo/Lh
dWnuIw/9Hs9NnkW5ktqmp8OL7AQFsgz/XAWlA45RW/5X8qPmRDDVm5PuvDeLdqbn
luiP6lwGDL4kDu6FXVR2CAEFiNeRTD8eIuLUsK8o6M0ceINdRXbbmRxA7o2zsQgP
GPTyUM7RdlEQco9BebY7Jz8EfKpaIPEMDN4Xt4oqqGLEULiq65qFahLBBq9sELvM
TPPMvTHCcdQ73ZA9UIbBg/raeyAHZFRc25yVw9escbZhISIwAJ14ZO0VhOuufPHj
pS2ZuYS0zCfx5Y6tJoFt0nhCWG+9U4OG1f4CEQhxRk9wyvb1IWbhL3n5rpkK/guD
hH0G9KAMzRSxs7BCInibIeKolFzSk+T3JjZW9Wr7PPB3bbLp4WVmdmb2R2A2cYh/
InzxwJ01iwtu1HXvp5TXpIWJ2ascPYML2SJnPJiFnc81K1e2w2VuoNv2nRTt1xOh
/4t+PYzOB7jzqqzVCoqxXJs02+vASVaXI7WzZIDLnT7CRMyGRLZ+S+6pJ9aVysMN
p4d5hneM2h4F0fvWq4kkKApwB01jBoOEcvJuZiOaz5iGPiUIO2CU32z5pU/TSztE
uNhn7ksm2JnGX1qoESiYCI2G80rN1tNElAFcLUt5+wLJeZAt41tA6SG0jeG3zUL6
pcEBytWB2NCox8LZM6lLEW3X1mhmx3GD/SfNuxjCKQoeCtrMY90=
=wNMv
-----END PGP SIGNATURE-----

--=-mPx2yEaImVsfjNu+RXgK--


--===============0346306290653689639==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============0346306290653689639==--


