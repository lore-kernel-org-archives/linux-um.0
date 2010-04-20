Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <4BCDE103.7080709@web.de>
Date: Tue, 20 Apr 2010 19:14:43 +0200
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
Subject: Re: [PATCH 4/5] uml: i386: Avoid redefinition of NR_syscalls
References: <cover.1271713955.git.jan.kiszka@web.de> <3e07ad1a38e88a22d7298deb88a8f3962b101998.1271713955.git.jan.kiszka@web.de> <20100420101056.GC5317@cr0.nay.redhat.com>
In-Reply-To: <20100420101056.GC5317@cr0.nay.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE42528AEAB116ABBB9FB79BA"
Sender: linux-kernel-owner@vger.kernel.org
To: Amerigo Wang <xiyou.wangcong@gmail.com>
Cc: trivial@kernel.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE42528AEAB116ABBB9FB79BA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Amerigo Wang wrote:
> On Mon, Apr 19, 2010 at 11:53:07PM +0200, Jan Kiszka wrote:
>> The i386 subarch happens to pull in original NR_syscalls. Maybe we can=

>> make that work for all host arch, but for now just avoid the clash by
>> using an all-upper-case name.
>>
>=20
> Where?

Not sure if this answers your question:

  CC      arch/um/kernel/skas/syscall.o
/data/linux-2.6/arch/um/kernel/skas/syscall.c:13:1: warning:
"NR_syscalls" redefined
In file included from /data/linux-2.6/arch/x86/include/asm/unistd.h:3,
                 from
/data/linux-2.6/arch/um/sys-i386/shared/sysdep/syscalls.h:6,
                 from /data/linux-2.6/arch/um/kernel/skas/syscall.c:10:
/data/linux-2.6/arch/x86/include/asm/unistd_32.h:349:1: warning: this is
the location of the previous definition

Jan


--------------enigE42528AEAB116ABBB9FB79BA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkvN4QQACgkQitSsb3rl5xSL+ACeMsBiZ+haVHmcv3BDGYwCJiFh
qgAAoJiOHLlBKdEWx46Ey+zumz2y/IF/
=mzB9
-----END PGP SIGNATURE-----

--------------enigE42528AEAB116ABBB9FB79BA--
