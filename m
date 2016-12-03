Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <glud-user-mode-linux-devel@m.gmane.org>)
	id 1cDF4j-000260-1i for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 03 Dec 2016 18:30:17 +0000
Received: from [195.159.176.226] (helo=blaine.gmane.org)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cDF4h-0003ri-Uj
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 03 Dec 2016 18:30:17 +0000
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
	(envelope-from <glud-user-mode-linux-devel@m.gmane.org>)
	id 1cDF4W-0004ax-OK for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 03 Dec 2016 19:30:04 +0100
From: Ritesh Raj Sarraf <rrs@researchut.com>
Date: Sat, 03 Dec 2016 23:50:53 +0530
Message-ID: <1480789253.13532.5.camel@researchut.com>
Mime-Version: 1.0
Subject: [uml-devel] Build failure on new gcc-6 on Debian Sid
Reply-To: rrs@researchut.com
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0352365613170826502=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net


--===============0352365613170826502==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-pZ/tF+FfOSRuQpcNgDMH"


--=-pZ/tF+FfOSRuQpcNgDMH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Debian Sid (Unstable), with Linux version 4.8.11, I was hopeful that uml
would build proper with gcc-6. But I still am getting the below mentioned b=
uild
failure.

The 4.8.11 kernel has the fixes for the core kernel. I'm not sure if any ex=
tra
changes are needed for UM again.

The current workaround that we use in Debian to build latest UML bits from =
the
kernel source, is to use the gcc-5 compiler.

The Debian bug report is accessible at:
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D837579

Thanks,
Ritesh


The fix that went in the stable release is:
http://git.kernel.org/cgit/linux/kernel/git/stable/stable-queue.git/commit/=
?id=3Da
fad7e0e67ef545a4d92507a236f0666c33d3ad4

=C2=A0 CC [M]=C2=A0=C2=A0lib/cordic.o
=C2=A0 CC [M]=C2=A0=C2=A0lib/asn1_decoder.o
=C2=A0 GEN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lib/oid_registry_data.c
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0LANGUAGE =3D "en_IN:en",
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0LC_ALL =3D (unset),
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0LC_TIME =3D "en_IN.utf8",
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0LC_MONETARY =3D "en_IN.utf8=
",
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0LC_COLLATE =3D "C",
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0LC_MEASUREMENT =3D "en_IN.u=
tf8",
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0LC_NUMERIC =3D "C",
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0LC_PAPER =3D "en_IN.utf8",
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0LANG =3D "C"
=C2=A0=C2=A0=C2=A0=C2=A0are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
=C2=A0 CC [M]=C2=A0=C2=A0lib/oid_registry.o
=C2=A0 LD=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0virt/lib/built-in.o
=C2=A0 LD=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0virt/built-in.o
=C2=A0 LINK=C2=A0=C2=A0=C2=A0=C2=A0vmlinux
=C2=A0 LD=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0vmlinux.o
=C2=A0 MODPOST vmlinux.o
=C2=A0 GEN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.version
=C2=A0 CHK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0include/generated/compile.h
=C2=A0 UPD=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0include/generated/compile.h
=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0init/version.o
=C2=A0 LD=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0init/built-in.o
/usr/bin/ld: arch/um/drivers/built-in.o: relocation R_X86_64_32 against
`.rodata.str1.1' can not be used when making a shared object; recompile wit=
h
-fPIC
/usr/bin/ld: final link failed: Nonrepresentable section on output
collect2: error: ld returned 1 exit status
Makefile:955: recipe for target 'vmlinux' failed
make[1]: *** [vmlinux] Error 1
make[1]: Leaving directory '/build/user-mode-linux-4.8-1um/linux-source-4.8=
'
debian/rules:76: recipe for target 'build-stamp' failed
make: *** [build-stamp] Error 2
dpkg-buildpackage: error: debian/rules build gave error exit status 2
I: copying local configuration
E: Failed autobuilding of package
I: unmounting /var/tmp/lxc/ccache/ccache filesystem
I: unmounting /var/cache/apt/archives/ filesystem
I: unmounting dev/pts filesystem
I: unmounting run/shm filesystem
I: unmounting proc filesystem
I: unmounting sys filesystem
I: cleaning the build env
I: removing directory /var/tmp/Debian-Build/Build//25270 and its subdirecto=
ries
23:15 =E2=99=92=E2=99=92=E2=99=92=C2=A0=C2=A0=C2=A0=C2=A0=E2=98=B9=C2=A0=C2=
=A0=3D> 1=C2=A0=C2=A0
rrs@chutzpah:~/Community/Packaging/user-mode-linux (master)$



--=20
Given the large number of mailing lists I follow, I request you to CC
me in replies for quicker response
--=-pZ/tF+FfOSRuQpcNgDMH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQCVDstmIVAB/Yn02pjpYo/LhdWkFAlhDDQUACgkQpjpYo/Lh
dWkUhQ//WivBtN4o5syeHw1nktUU3wa56r56/YZjNzWL8LKGWRmgkFugv0fEkE4j
xeIzOgsyR0bW4G393Ixv+vdtE218gP6glIlpEE810ybRKYKbK8NBvm2k1wPASG4l
/N9QHRpwVloFYe9BMup8BqxHbtTvlpdMWctuhAOFxnHXSCMb/kMFlJ1KmoMXjPMU
lpWsaEaELGigS/mFK3J1QV+hdrRasJnp3WUZaXzUWoqwE6DmpY4sbz9gmLJmczRi
Mxlrc312hR+cjWMDfYGQm6EQHp7Safth0wId9YkcFz/xTbu43xo9jLzY0AxURlbp
miW/ygSLnag3SU/0/o1ekrBt6lDnBs4ogSlKR42RWpWZH3jbz5FRhHu48bGwUAFQ
iDQKVCtRRL6haN+6jAGbF+YNT4lX2PPRWuBhu2nRw4LgHS0GERbDMK6qacqOBjfg
l9m/ahbPiKzKH+zJxDZys7q029KjhgvmuNt0QYh/+xI/R34Rfwdqz00IcXrttabs
E6XMcOVv1rcAZyUUfJ7lGyp7ZvzaLd0/Rg3h7h/t0OT4glwHHFo/vfQ0ZF0ojpa5
WBanedTKq+TbTJwdfKm50cTbc9zG9KVr1JO41VJw1gzTqD2sYbVizRSK12cFO3ay
JjpgVoxcQeTDR4JAeTfDagRyJcHyXGIbfcvjT+o4nqVxNxQEhdk=
=P4li
-----END PGP SIGNATURE-----

--=-pZ/tF+FfOSRuQpcNgDMH--




--===============0352365613170826502==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
--===============0352365613170826502==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============0352365613170826502==--




