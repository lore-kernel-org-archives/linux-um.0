Return-Path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: Your message of "Sun, 29 May 2011 11:22:01 +0200."
             <201105291122.01602.toralf.foerster@gmx.de>
From: Valdis.Kletnieks@vt.edu
References: <201105291122.01602.toralf.foerster@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1306689477_27223P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 29 May 2011 13:17:57 -0400
Message-ID: <103895.1306689477@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: 2 small kernel config issues related to UML + RTC
To: Toralf =?utf-8?q?F=C3=B6rster?= <toralf.foerster@gmx.de>, Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

--==_Exmh_1306689477_27223P
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Sun, 29 May 2011 11:22:01 +0200, Toralf F=3DF6rster said:
>   =E2=94=82 Symbol: STMMAC_RTC_TIMER =3D5B=3D3Dn=3D5D                    =
   =3D20
>   =E2=94=82 Type  : boolean
>   =E2=94=82 Prompt: Real time clock
>   =E2=94=82   Defined at drivers/net/stmmac/Kconfig:50
>   =E2=94=82   Depends on: <choice> && RTC_CLASS
>   =E2=94=82   Location:
>   =E2=94=82     -> Network device support (NETDEVICES =3D5B=3D3Dy=3D5D)
>   =E2=94=82       -> Ethernet (1000 Mbit) (NETDEV_1000 =3D5B=3D3Dn=3D5D)
>   =E2=94=82         -> STMicroelectronics 10/100/1000 Ethernet driver (ST=
MMAC_E=3D
TH =3D5B=3D3Dn=3D5D)
>   =E2=94=82           -> STMMAC Timer optimisation (STMMAC_TIMER =3D5B=3D=
3Dn=3D5D)
>   =E2=94=82             -> Select Timer device (<choice> =3D5B=3D3Dn=3D5D)

Ouch. That has to be the strangest place one could *possibly* put an RTC =3D
driver. ;)

Giuseppe - is that RTC driver *really* an integral part of the chipset an=3D
d
won't work without the Ethernet parts, or should the driver code for the =3D
RTC
live elsewhere in the tree?


--==_Exmh_1306689477_27223P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD4DBQFN4n/FcC3lWbTT17ARAulNAJ9BhXhUUV0WBKViuZNErEpOMYQJpACUCkx1
JzlXXFc+TtSPi10Dl9TpLQ==
=Cqc3
-----END PGP SIGNATURE-----

--==_Exmh_1306689477_27223P--

