Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iL5qr-00049D-Hy
 for linux-um@lists.infradead.org; Thu, 17 Oct 2019 13:30:03 +0000
Received: by mail-pf1-x441.google.com with SMTP id q12so1666082pff.9
 for <linux-um@lists.infradead.org>; Thu, 17 Oct 2019 06:30:01 -0700 (PDT)
Message-ID: <5dc5e0694d2fcf2f8bb083e3861fd1b39c768b8c.camel@researchut.com>
Subject: Re: uml segfault during I/O
From: Ritesh Raj Sarraf <rrs@researchut.com>
Date: Thu, 17 Oct 2019 19:00:12 +0530
In-Reply-To: <1ccf27d8-6b6a-7d08-acef-93077f07511b@cambridgegreys.com>
References: <a1307b17bd3f51d84d9195760492d1ef284b6382.camel@researchut.com>
 <1ccf27d8-6b6a-7d08-acef-93077f07511b@cambridgegreys.com>
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
Content-Type: multipart/mixed; boundary="===============5960096811992634166=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org


--===============5960096811992634166==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-z5Jv/VBlhsvXUGS4afFW"


--=-z5Jv/VBlhsvXUGS4afFW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-10-17 at 14:02 +0100, Anton Ivanov wrote:
> Looking into that. I have not run into anything like that, but I have
> not used any of the legacy networking for 5 odd years now.
>=20

Do you think this is related to networking ? I ask because there was no
network activity going on.

apt is just an example. The packages were all already downloaded and
there was no network activity. Rather, there was block I/O.

One thing I noticed, which may or may not be useful to this report. I
was booting the uml guest and immediately logging into it and running
the block I/O. And the segfault would occur.

If I, instead, booted the uml vm and let it remain idle for a minute or
so and then did the I/O, it worked fine. So I am not sure if there is
any lazy initialization happening in the background which gets
corrupted during immediate hot boot I/O.

On the other hand, if you think there can be any number of commands to
run locally that could generate more information, please assist me so.

Thanks,
Ritesh

--=20
Ritesh Raj Sarraf
RESEARCHUT - http://www.researchut.com
"Necessity is the mother of invention."

--=-z5Jv/VBlhsvXUGS4afFW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQCVDstmIVAB/Yn02pjpYo/LhdWkFAl2obOQACgkQpjpYo/Lh
dWk1cRAAo8+gzLzwlQiyUnpnJbbokaY0y52QM2t2aUQZixpWwd+b+sQa/k3gskVe
Gh6RtV5h07q+soTv8R1/sgvx+thFke8Z/YVh1rLEt58OZnHqyHGnb7n5ws5xFtfy
CWh/driMnv9vSJdFuQSfCIQJ75MJGRpP7oo0znsGuXuHPOKuXWRYyk+dlse1tvxQ
JILhHXAifzbERSljjj8aWUpnnSsoknOYYTsvy5s9TsVlhElprO7esXz8oc/xE8z2
fmqmrs4A+8kheoDQeCRzIpI5UN0jwf9d5fkDnjQEg/w2ybIOmeyCKvKqxvvDW03S
rMG7i6jggcKKztAIiLzrqd/UXmg1ZqV4kToW7XnX09fehQhQ7shMYuVg5P/nxALl
20ZjANicm8oSfYuwIZORkDB9FAYmEc+zzQyyLflPRLhLuvGpzmMso85TSe0VH0Km
rThXz2HrXS8foo39UBoetKjEgpv4o9A3gRA7N2dDklF8WIdfUiy3Z1y0szD/u4g/
XvGyVMIENcyyR8lEwIC+MKDGzrC70l8+Wsdfv/7EQk798AjUA+ggZnEmii3YBDrq
isYJqkBZNtZzj7Vk5KNFODb/nupL/lntgoSlY8IA8pRjDZvSoH/1GcjlEuMmLaZx
SM5x+Ii/l/gvgFs4WAKEJMgm1yYEZs8x8HP8BaFxCCOK4JHZGs4=
=OI5y
-----END PGP SIGNATURE-----

--=-z5Jv/VBlhsvXUGS4afFW--



--===============5960096811992634166==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============5960096811992634166==--



