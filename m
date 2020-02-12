Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j1pPs-0004hE-Ka
 for linux-um@lists.infradead.org; Wed, 12 Feb 2020 10:38:49 +0000
Received: by mail-pf1-x42c.google.com with SMTP id 84so1039153pfy.6
 for <linux-um@lists.infradead.org>; Wed, 12 Feb 2020 02:38:47 -0800 (PST)
Received: from priyasi.researchut.com ([157.45.224.103])
 by smtp.gmail.com with ESMTPSA id l15sm7326760pgi.31.2020.02.12.02.38.45
 for <linux-um@lists.infradead.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2020 02:38:46 -0800 (PST)
Received: from localhost (localhost [IPv6:::1])
 by priyasi.researchut.com (Postfix) with ESMTP id 841D4A0554D
 for <linux-um@lists.infradead.org>; Wed, 12 Feb 2020 16:08:42 +0530 (IST)
Message-ID: <7c37a3f7310c0be2202ada464e31c2d4d424c502.camel@researchut.com>
Subject: Documentation for UML Vector network
From: Ritesh Raj Sarraf <rrs@researchut.com>
Date: Wed, 12 Feb 2020 16:08:42 +0530
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
Content-Type: multipart/mixed; boundary="===============7183049837127697469=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org


--===============7183049837127697469==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-fH2OZQarYC5vHktudbJT"


--=-fH2OZQarYC5vHktudbJT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I see in the latest changes for Linux in Linus's tree, that the
previous networking modes have been marked obsolete.

Is there any official documentation on how to use the new Vector
network in UML ? Or does it stand transparent to the users ?

--=20
Ritesh Raj Sarraf
RESEARCHUT - http://www.researchut.com
"Necessity is the mother of invention."

--=-fH2OZQarYC5vHktudbJT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQCVDstmIVAB/Yn02pjpYo/LhdWkFAl5D1bIACgkQpjpYo/Lh
dWm0XxAAtsjJgkgoX3V2pZy71QrMEO3yptcI7HHnMzYmR3BNLcBR8RSlinWgXzkN
8saAz7eKSFxALaVKKLI9xZbIFqchNKMV1lUhMBqmWWrL7eMy/DWxtX7+xXruYIrs
sb+PtPWECWoBCszQtjpB4lvGRXi2odqWYkPecRPB0qsbV6+V6cLiVhm3SxigT8Kx
cJ8yi3stnho7oI3BH+qC4+x6/FAvBXlxkCUBC2V9IZdpE4VwZF/BGmTOpB5tJ9Rv
NmetOBNpAXL34KkCr3tnEo3XExoOqdegzfJZY9z8DJEaggtci8beUW6iTPC/I0SY
L2GfXJ8LfxSe05D1UDHhWQs6mtRayhKi+xscZuymrWKCRfSL5rz0L9t3P2Q59/cO
NQZP575XDa57EtSyyRpZh3pwagZkkshkfzzsKf4tvf8OeIlQLv6biNToD/sLXhwh
FFBRoZ7zNGeXHh93VfsEDfhSu15PVgwnAwV3Qr9Xtoi3nk2MauPPWVOuQUUmb/KG
GzySMFl0RVyCWSClVxaak+QnyQdU+Gnl1v9RetCS4AQxIMd2rWFxM0qxG3lUrkiz
pBlUweUVLUn9v02TOhbHUnwN5LGSqkWVPE7n2fh6xh5BiGp1HPMo/f2PMfZvnGOZ
poP/lmikdt97CXe8vMQNWb1CgMOU/yCmvtxxayK1A/sLMyyzGqA=
=8/Od
-----END PGP SIGNATURE-----

--=-fH2OZQarYC5vHktudbJT--



--===============7183049837127697469==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============7183049837127697469==--



