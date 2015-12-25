Return-Path: <linux-kernel-owner@vger.kernel.org>
References: <1450959131-5113-1-git-send-email-mic@digikod.net>
 <20151225013409.GC12977@x>
From: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <567D8ED5.7000409@digikod.net>
Date: Fri, 25 Dec 2015 19:45:41 +0100
MIME-Version: 1.0
In-Reply-To: <20151225013409.GC12977@x>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="vKe5cHfgRhuDvjNv6W2D1NRiqXKSbaFup"
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v3] um: Fix build error and kconfig for i386
To: Josh Triplett <josh@joshtriplett.org>
Cc: linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net, "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>, Michal Marek <mmarek@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, stable@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vKe5cHfgRhuDvjNv6W2D1NRiqXKSbaFup
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable


On 25/12/2015 02:34, Josh Triplett wrote:
> On Thu, Dec 24, 2015 at 01:12:11PM +0100, Micka=EBl Sala=FCn wrote:
>> Fix build error by generating elfcore.o only when ELF_CORE (depending =
on
>> COREDUMP) is selected:
>>
>> arch/x86/um/built-in.o: In function `elf_core_write_extra_phdrs':
>> (.text+0x3e62): undefined reference to `dump_emit'
>> arch/x86/um/built-in.o: In function `elf_core_write_extra_data':
>> (.text+0x3eef): undefined reference to `dump_emit'
>>
>> Fixes: 5d2acfc7b974 ("kconfig: make allnoconfig disable options behind=
 EMBEDDED and EXPERT")
>> Signed-off-by: Micka=EBl Sala=FCn <mic@digikod.net>
>> Cc: Jeff Dike <jdike@addtoit.com>
>> Cc: Richard Weinberger <richard@nod.at>
>> Cc: Josh Triplett <josh@joshtriplett.org>
>> Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>> Cc: Michal Marek <mmarek@suse.cz>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>=20
> It looks like ELF_CORE depends on COREDUMP, but not on BINFMT_ELF.
> Should it?  What happens if you build this with ELF_CORE=3Dy and
> BINFMT_ELF=3Dn?  Does that configuration even make sense?

It build fine with ELF_CORE=3Dy and BINFMT_ELF=3Dn but does not seem usef=
ul. Nevertheless, it's the same for all architectures (cf. init/Kconfig):=
 ELF_CORE only depends on COREDUMP.

 Micka=EBl


--vKe5cHfgRhuDvjNv6W2D1NRiqXKSbaFup
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJWfY7aAAoJECLe/t9zvWqVYl8H/1zdbVrFnAUK4nIe+3vIXZtR
F0985nX8BBqX+fI52gH3lGLU/Xbvvu12yQl85jjFNrT401qqZ9IRoYeSQ1Sba0cl
OQzzdCV/AxRhFPnaLznJ0XT8546tVkE6zegaeUSr9t2yN4hTcHTy1kg6FaC8+QZx
mPFZBKvf2AYwwbeuijtS9r4RQBkUGgqgQiW6Hhr8+43hdm6FYecTQx9qYxcmdhNC
vCatDKBwF3j+PhVFDnoEHS4SQR6lcTd1J5dAYQ+UQjn24Y9m5uYGJqwh6q0EZi18
n5hdcarBMBOTf5g6ODtl3/K2Mw4FI8RNseF+YZ85fU6S1kRlKPnBZ/WozTJdgzg=
=LK+s
-----END PGP SIGNATURE-----

--vKe5cHfgRhuDvjNv6W2D1NRiqXKSbaFup--
