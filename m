Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pg0-x236.google.com ([2607:f8b0:400e:c05::236])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fTKcf-0007fT-7A
 for linux-um@lists.infradead.org; Thu, 14 Jun 2018 05:16:39 +0000
Received: by mail-pg0-x236.google.com with SMTP id z1-v6so2342160pgv.12
 for <linux-um@lists.infradead.org>; Wed, 13 Jun 2018 22:16:26 -0700 (PDT)
Received: from priyasi ([27.34.106.60])
 by smtp.gmail.com with ESMTPSA id c191-v6sm6862382pfg.48.2018.06.13.22.16.24
 for <linux-um@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 13 Jun 2018 22:16:24 -0700 (PDT)
Received: from localhost.localdomain ([::1] helo=localhost)
 by priyasi with esmtp (Exim 4.91)
 (envelope-from <rrs@researchut.com>) id 1fTKcQ-0004ME-5A
 for linux-um@lists.infradead.org; Thu, 14 Jun 2018 11:01:22 +0545
Message-ID: <eabf7e000bc0227fa6a7a74a23512cc11b84206a.camel@researchut.com>
Subject: UML fails to build on arch i386
From: Ritesh Raj Sarraf <rrs@researchut.com>
Date: Thu, 14 Jun 2018 11:01:21 +0545
Mime-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Reply-To: rrs@researchut.com
Content-Type: multipart/mixed; boundary="===============6000565885708335025=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org


--===============6000565885708335025==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-BKEVTfVXs+I/+5I+5wwv"


--=-BKEVTfVXs+I/+5I+5wwv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable


Hello Richard/UML Team,

In preparing the 4.16 UML build, the code fails to build from source on
i386. It build successfully on arch amd64.

Full build log is available at:
https://buildd.debian.org/status/fetch.php?pkg=3Duser-mode-linux&arch=3Di38
6&ver=3D4.16-1um-1&stamp=3D1528784216&raw=3D0

  CC      arch/um/kernel/tlb.o
  CC      arch/um/kernel/trap.o
  CC      arch/um/kernel/um_arch.o
  CC      arch/um/kernel/umid.o
  CC      arch/um/kernel/maccess.o
  CC      arch/um/kernel/kmsg_dump.o
  CC      arch/um/kernel/skas/clone.o
In file included from ./arch/x86/um/shared/sysdep/ptrace.h:42:0,
                 from ./arch/um/include/shared/as-layout.h:38,
                 from arch/um/kernel/skas/clone.c:11:
./arch/x86/um/shared/sysdep/ptrace_32.h:16:23:=20
                       ^
scripts/Makefile.build:329: recipe for target 'arch/um/kernel/skas/clone.o'=
 failed
make[3]: *** [arch/um/kernel/skas/clone.o] Error 1
scripts/Makefile.build:588: recipe for target 'arch/um/kernel/skas' failed
make[2]: *** [arch/um/kernel/skas] Error 2
Makefile:1048: recipe for target 'arch/um/kernel' failed
make[1]: *** [arch/um/kernel] Error 2
make[1]: Leaving directory '/<<PKGBUILDDIR>>/linux-source-4.16'
debian/rules:74: recipe for target 'build-stamp' failed
make: *** [build-stamp] Error 2
dpkg-buildpackage: error: debian/rules build-arch subprocess returned exit =
status 2
---------------------------------------------------------------------------=
-----
Build finished at 2018-06-12T06:16:48Z

Finished
--------


--=20
Ritesh Raj Sarraf
RESEARCHUT - http://www.researchut.com
"Necessity is the mother of invention."
--=-BKEVTfVXs+I/+5I+5wwv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQCVDstmIVAB/Yn02pjpYo/LhdWkFAlsh+iUACgkQpjpYo/Lh
dWkjUw//Tu27qI/0xHCam3BU2rPs6yNSJQeOsYkaj04oTOX9x45j6eezYBp8Nzy5
1MtyABOD2Qf805zv/i/Plt63CpelZe4Qs1W8+QiT9HRiN2E8G3p43i58BfzFlhHI
+0CwMjgmyy86cYdMfq4Ur+Dp0+2NWxeg/GyBexcJw95StPebyuJFL2uxTwEMfGpv
8MgxbSKyYERAi9B7m4cQwJ8vGGrCXpALi8EVlpxOVg/XupSToSJL9SWv975x85lE
ywwUf+c3Qn/XA83Z3esMwAEFTfcyKb7QeFm4HFtwRXW9LA5dm+MsVWKqNovKifja
zFReWgY+3aCaQ2Jzn04s89svEhUq55zXqFOjRpvhZgb1bduLcg2LZNgGIUrXS0f4
WQ3fQt0kUt5Ivp/yfD2oYHeEFO2j+Q+C0vXH5YWgHl+aV86EhLY6Q2MGW447aUg7
e2GPh/T9NKAjNCGd50qof/WgeRyfUyG8VhAkVUJejtR3erheIoDhNDL7YAkdEfSu
HBGli4V1+Ug+49OQFR+5W5/gXstihmIICPOP1ANaHVb2tmxlloekh3qnSBy1D917
M6EDHcmeID/SRffSCaFoi+4pfIUE5ZTioZtezPHcbsWilsCqD4DnoF6Omju0Qlfo
JCNv3N0GJJ/79FTW7ZoWS8hOTttjzXAXVaTZddqNUZJgMWZ6Zx8=
=cJ5l
-----END PGP SIGNATURE-----

--=-BKEVTfVXs+I/+5I+5wwv--



--===============6000565885708335025==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============6000565885708335025==--



