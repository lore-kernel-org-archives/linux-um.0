Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1in2xP-0002EO-Di
 for linux-um@lists.infradead.org; Thu, 02 Jan 2020 16:04:20 +0000
Received: by mail-wr1-x42e.google.com with SMTP id b6so39757556wrq.0
 for <linux-um@lists.infradead.org>; Thu, 02 Jan 2020 08:04:18 -0800 (PST)
Received: from priyasi.researchut.com ([157.45.48.78])
 by smtp.gmail.com with ESMTPSA id y6sm55465385wrl.17.2020.01.02.08.04.15
 for <linux-um@lists.infradead.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2020 08:04:16 -0800 (PST)
Received: from localhost (localhost [IPv6:::1])
 by priyasi.researchut.com (Postfix) with ESMTP id 6E18B9B4C53
 for <linux-um@lists.infradead.org>; Thu,  2 Jan 2020 21:34:10 +0530 (IST)
Message-ID: <188c72613ff8b15454670dd9de68fefcaa130c74.camel@researchut.com>
Subject: Linux UM 5.4 FTBFS: uml_reserved undefined
From: Ritesh Raj Sarraf <rrs@researchut.com>
Date: Thu, 02 Jan 2020 21:34:10 +0530
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
Content-Type: multipart/mixed; boundary="===============2343460584781726878=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org


--===============2343460584781726878==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-bv/LG0tXkv+1ngjtPeGf"


--=-bv/LG0tXkv+1ngjtPeGf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Happy New Year 2020.

When trying to prepare the 5.4 version of User Mode Linux for Debian, I
have run into the following build failure on both the architectures.

For now, I have disabled VIRTIO_UML to get the new UML into Debian.


  KSYM    .tmp_kallsyms2.o
  LD      vmlinux
  SYSMAP  System.map
  LINK linux
  Building modules, stage 2.
  MODPOST 939 modules
ERROR: "uml_reserved" [arch/um/drivers/virtio_uml.ko] undefined!
make[2]: *** [scripts/Makefile.modpost:94: __modpost] Error 1
make[1]: *** [Makefile:1298: modules] Error 2
make[1]: Leaving directory '/build/user-mode-linux-5.4-1um/linux-source-5.4=
'
make: *** [debian/rules:75: build-stamp] Error 2
dpkg-buildpackage: error: debian/rules binary subprocess returned exit stat=
us 2
I: copying local configuration
E: Failed autobuilding of package
I: unmounting dev/pts filesystem
I: unmounting dev/shm filesystem
I: unmounting proc filesystem
I: unmounting sys filesystem
I: cleaning the build env=20


--=20
Ritesh Raj Sarraf
RESEARCHUT - http://www.researchut.com
"Necessity is the mother of invention."

--=-bv/LG0tXkv+1ngjtPeGf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQCVDstmIVAB/Yn02pjpYo/LhdWkFAl4OFHoACgkQpjpYo/Lh
dWk8CBAAtrvQmapKxtx9ZIoQ3kkaC8/s6LVTqHeSinDsBZDj+M9pfcocPPqCnskg
N0/SGBphIAczn+1goWR8vd8YMfS2+/+JRHzi8by0qQVwtXg7CZJsJ9i8UMlyRvdX
xuzAd87Ega5vKOFc6evygi9y4qBb+4iAUyt9mqwi2qfTw9BlD2+FcNh2DT8ePmDw
BckKpx14JL2o+s+HYc/5S4JGiDfE3HTqTvxwbtNWP6yIvVY/PPg48d/GzRlnzxXl
oFdjHkaOOlqSxlDXQGC/bPOdHX2ZalahtHLll+P8SqZPMymrYGxIxycKkqWUCf+/
ddCmYlnZfRyMD2qSZZCulK7qK6aQvCMrtjUYz6jjxswLk42W3pOaMl6UhT6dJD6X
Q2MMBBOGK/hGn+ZL7Y0EplENT6OgWr2GN1/FP/IqDJ3Wg0Wm1Nmu8TGqOsMwCbhC
8tmDQgcDxFxXPTfovI0k+yJjlT9Z/oOO7/1bAdOFR0tSN52FuhBq5PqFlw8J0H+l
Qv9aYk2M500Qw+8Vff6nV4J9s84/quxkyXhbPu5gtNf3Y94Bxhrl1PD+CXVx0bfX
5pHs/pva+W6C62Pm8csj5QB6qo2gN6aLN1CAx5f5Wb7p1ii/jHzJztLoJkp73d/I
wPsjefbHvtPN/5lEFkesmIYcYifLA1hNTsQ4nDfQtZM9w1nj2AU=
=RybU
-----END PGP SIGNATURE-----

--=-bv/LG0tXkv+1ngjtPeGf--



--===============2343460584781726878==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============2343460584781726878==--



