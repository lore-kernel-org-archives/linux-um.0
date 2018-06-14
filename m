Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pl0-x22d.google.com ([2607:f8b0:400e:c01::22d])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fTO61-0002pZ-Q7
 for linux-um@lists.infradead.org; Thu, 14 Jun 2018 08:59:31 +0000
Received: by mail-pl0-x22d.google.com with SMTP id b14-v6so3167058pls.5
 for <linux-um@lists.infradead.org>; Thu, 14 Jun 2018 01:58:59 -0700 (PDT)
Received: from priyasi ([27.34.106.60])
 by smtp.gmail.com with ESMTPSA id v15-v6sm8809702pfk.12.2018.06.14.01.58.56
 for <linux-um@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 14 Jun 2018 01:58:56 -0700 (PDT)
Received: from localhost.localdomain ([::1] helo=localhost)
 by priyasi with esmtp (Exim 4.91)
 (envelope-from <rrs@researchut.com>) id 1fTO5l-0002VZ-Ty
 for linux-um@lists.infradead.org; Thu, 14 Jun 2018 14:43:53 +0545
Message-ID: <d5c8646bf909902b1f4a0f593ab3832ed399f9c1.camel@researchut.com>
Subject: Re: UML fails to build on arch i386
From: Ritesh Raj Sarraf <rrs@researchut.com>
Date: Thu, 14 Jun 2018 14:43:53 +0545
In-Reply-To: <eabf7e000bc0227fa6a7a74a23512cc11b84206a.camel@researchut.com>
References: <eabf7e000bc0227fa6a7a74a23512cc11b84206a.camel@researchut.com>
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
Content-Type: multipart/mixed; boundary="===============4065873077705668536=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org


--===============4065873077705668536==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-AtCww6EsVLunie0XTTJF"


--=-AtCww6EsVLunie0XTTJF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2018-06-14 at 11:01 +0545, Ritesh Raj Sarraf wrote:
>   CC      arch/um/kernel/skas/clone.o
> In file included from ./arch/x86/um/shared/sysdep/ptrace.h:42:0,
>                  from ./arch/um/include/shared/as-layout.h:38,
>                  from arch/um/kernel/skas/clone.c:11:
> ./arch/x86/um/shared/sysdep/ptrace_32.h:16:23:=20
>                        ^

This log missed the main error line:

  CC      arch/um/kernel/maccess.o
  CC      arch/um/kernel/kmsg_dump.o
  CC      arch/um/kernel/skas/clone.o
In file included from ./arch/x86/um/shared/sysdep/ptrace.h:42:0,
                 from ./arch/um/include/shared/as-layout.h:38,
                 from arch/um/kernel/skas/clone.c:11:
./arch/x86/um/shared/sysdep/ptrace_32.h:16:23: error: expected identifier b=
efore numeric constant
 #define PTRACE_SYSEMU 31
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


--=20
Ritesh Raj Sarraf
RESEARCHUT - http://www.researchut.com
"Necessity is the mother of invention."
--=-AtCww6EsVLunie0XTTJF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQCVDstmIVAB/Yn02pjpYo/LhdWkFAlsiLk0ACgkQpjpYo/Lh
dWm0lRAAhV1cAAD0s3Bk//8OIs3Qo7Mm/JmAz0d72h0bETLsXZyXGfiDXhUlunwU
+UnnmcbklZRygrHzezTFtDLLLNRKTIRQHjGMoLfcmju2nNOI9xCwtpiiU6MVF0Fh
RKfjf8eoAQYkt/AoxP7wVyTXLnPpdfHHgLAoW+kyB9GkpH4TOXErfve/b/Ou/xvT
aN+TKVx6nt0SuG3bGL/bFyD0uNKzASIedY866X55TMdurZeTPkM9EEQmVjr/xYvU
IGRg5hsciKJIz6EUphF0FEvFINLJD7xr07ppdlqIB2hgnTF7//ylWNK+ELRALTdL
va62B5Pu5cnM9/W5mC+9VDy6PWz6pFlCFAVqdbKjrzxir5LG4HuBrYSW2I1xFaRX
Ufx+MJj/yJOc1vTatdPnLIeh6VB4iA9pA3sDdR555DCnr5bkbeUBdhR04h9Uzw6b
NVbasl+sbO7nvGSnZXmg3A7D4lSgkqcKG+M7wG1m6tg8maJoVL+IRrQdTLBxG51M
ckJkAa0j8G6jbHh9SKv3y0TXyhGHFUFFY7PluDWuFlX6TkfqdWMMSgJ6NNI+XetG
84xErSH6zuBYrkSfsor20iwlrE4i824pjhUZ3KheMZhxcGQzOb+jnNhRWj4CPSDw
r0Be/deqInW58flS4djkA4IduOiSrc30mE4AIktJ4FXSHf3Q1bg=
=4LKC
-----END PGP SIGNATURE-----

--=-AtCww6EsVLunie0XTTJF--



--===============4065873077705668536==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============4065873077705668536==--



