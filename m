Return-Path: <linux-kernel-owner@vger.kernel.org>
References: <1450875553-17717-1-git-send-email-mic@digikod.net>
 <20151223214212.GA1300@x>
From: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <567BE089.8030903@digikod.net>
Date: Thu, 24 Dec 2015 13:09:45 +0100
MIME-Version: 1.0
In-Reply-To: <20151223214212.GA1300@x>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="koHP90tJNW3JWTuFf7weXOpKN4UBHfsV3"
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v2] um: Fix build error and kconfig for i386
To: Josh Triplett <josh@joshtriplett.org>
Cc: linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net, "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>, Michal Marek <mmarek@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, stable@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--koHP90tJNW3JWTuFf7weXOpKN4UBHfsV3
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable


On 23/12/2015 22:42, Josh Triplett wrote:
> On Wed, Dec 23, 2015 at 01:59:13PM +0100, Micka=EBl Sala=FCn wrote:
>> Fix build error by selecting COREDUMP when X86_32 is selected:
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
> I suppose um doesn't care deeply about binary size, but ideally I would=

> suggest changing arch/x86/um/Makefile to make elfcore.c compiled in whe=
n
> CONFIG_ELF_CORE rather than CONFIG_BINFMT_ELF.

That looks better! Since the first patch has been added to the mmots tree=
 (but not yet in mmotm) I'll send a patch update instead of a new one rev=
erting the first. I hope this is OK.

Regards,
 Micka=EBl


--koHP90tJNW3JWTuFf7weXOpKN4UBHfsV3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJWe+CJAAoJECLe/t9zvWqVo9UH/1AbNIyQgMPhGZrAhntqVYS0
R4GrJKZeGf4/y1TH8Vp5YDOWBHSikwStpRA2+G9zfY059+iWhWT8QtquH5S5ByP2
2Hk2Uyrj5ibZcMA9sDs1zPQk5Gd46RHdwAdJAES/9zOdKsDNgQjrJ9fsORuh8tBl
fp0ONNAnoj45U0SBaN/QfHrgzmv1NQijVfdZAj6gl1UWIqZ8fqMEnI7K7JC7y/1q
40hLO+A8hdqCVUMMsHza5676TNwPNM5EqvAJPG5GNWPUJKZgHwilht+pbLatYFGG
YeVenvHDC0wgGQQlgxqFrAJQsJHf8GFwjEqenAINoZe3uPJ4YGEgzRr94p160Bw=
=z8iL
-----END PGP SIGNATURE-----

--koHP90tJNW3JWTuFf7weXOpKN4UBHfsV3--
