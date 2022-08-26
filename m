Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mout.web.de ([212.227.17.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRbQP-0075hW-28
	for linux-um@lists.infradead.org; Fri, 26 Aug 2022 15:39:14 +0000
Received: from gecko ([46.223.150.91]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mq1CC-1pEOi514B0-00n4F0 for
 <linux-um@lists.infradead.org>; Fri, 26 Aug 2022 17:39:11 +0200
Date: Fri, 26 Aug 2022 17:39:09 +0200
From: Lukas Straub <lukasstraub2@web.de>
Subject: Re: [PATCH] arch: um: Mark the stack non-executable to fix a
 binutils warning
Message-ID: <20220826173909.124aef1f@gecko>
In-Reply-To: <20220823010830.2675419-1-davidgow@google.com>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1411286686160436528=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org

--===============1411286686160436528==
Content-Type: multipart/signed; boundary="Sig_/PUkKgVXBbSEhFlOtzkt/DkX";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/PUkKgVXBbSEhFlOtzkt/DkX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Looks good to me:

Reviewed-by: Lukas Straub <lukasstraub2@web.de>
Tested-by: Lukas Straub <lukasstraub2@web.de>

Regards,
Lukas Straub
--=20


--Sig_/PUkKgVXBbSEhFlOtzkt/DkX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmMI6R0ACgkQNasLKJxd
sliiixAAqBUopgFCNG4k2Ily9KBV0Q35Mlr1Fps3GvpYekPAi98kT1ALse2qSjGp
j9OaOenDw5PtEOnJ7wLGsb3GWv7pmHMFLiZHttqAFmcoZM0S81QKAXVLysOOOjw2
CfX5BBIm4e/2y9Szxs4WRkAbWSJK/kpcqVjePP/tF3URdZlIvrDCGyVH9BoDTakF
GtUY6j+05NVX7TNaiXdGJUj4uJKhrHzA4Z+qWU9AvAcGGGTHSoE2ezdPpsVaHPNx
SRI9/wQjHACEeyJiRyXn4kPFkJjMjYmF9i+EKmUiaqgRkTIX3T/FwkVfH6L5J0Wj
2vFk7gT4xB0APBMz72XmdRrnYINuSI6hy3QoQVxY9gz7+ZemcrJ2DOGRfDsbBs+g
f2SKmq0JOcaVllpqMEODQErDAGRe3OA7smb4mt6kREgb6REx2P6A0cspJgOl7dyF
ThZFVVnMeqI1djofsY+UP2NzFYvW4aJdsxkv1MN367BuCRRMwO5R2GVtyuEpybgM
gLK98eIs9575SQMKWbnJGGkRRq7cwFJHRJfwqsQK3hSAsV74PFEXBm2hJR/3UbpV
jm/zpM3e6GMHCpEoZ0vpw+PtBCm51DtrZb/9T66bGjC/yAIzFX6TjQozY6uXCmJZ
U4kkVJNhLRCcF1f/ZhUb++4dVbl7bvpnrZlXHxUGHngZtGHuPp4=
=wktS
-----END PGP SIGNATURE-----

--Sig_/PUkKgVXBbSEhFlOtzkt/DkX--


--===============1411286686160436528==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============1411286686160436528==--


