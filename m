Return-Path: <david.laight@aculab.com>
From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH v2 02/18] uaccess: fix nios2 and microblaze get_user_8()
Date: Wed, 16 Feb 2022 13:35:25 +0000
Message-ID: <4a7e026b07c94668a18cb4857ad6b7a5@AcuMS.aculab.com>
References: <20220216131332.1489939-1-arnd@kernel.org>
 <20220216131332.1489939-3-arnd@kernel.org>
In-Reply-To: <20220216131332.1489939-3-arnd@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: 'Arnd Bergmann' <arnd@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Cc: "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "will@kernel.org" <will@kernel.org>, "guoren@kernel.org" <guoren@kernel.org>, "bcain@codeaurora.org" <bcain@codeaurora.org>, "geert@linux-m68k.org" <geert@linux-m68k.org>, "monstr@monstr.eu" <monstr@monstr.eu>, "tsbogend@alpha.franken.de" <tsbogend@alpha.franken.de>, "nickhu@andestech.com" <nickhu@andestech.com>, "green.hu@gmail.com" <green.hu@gmail.com>, "dinguyen@kernel.org" <dinguyen@kernel.org>, "shorne@gmail.com" <shorne@gmail.com>, "deller@gmx.de" <deller@gmx.de>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "hca@linux.ibm.com" <hca@linux.ibm.com>, "dalias@libc.org" <dalias@libc.org>, "davem@davemloft.net" <davem@davemloft.net>, "richard@nod.at" <richard@nod.at>, "x86@kernel.org" <x86@kernel.org>, "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>, "ebiederm@xmission.com" <ebiederm@xmission.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "ardb@kernel.org" <ardb@kernel.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>
List-ID: <linux-um.lists.infradead.org>

From: Arnd Bergmann
> Sent: 16 February 2022 13:13
>=20
> These two architectures implement 8-byte get_user() through
> a memcpy() into a four-byte variable, which won't fit.
>=20
> Use a temporary 64-bit variable instead here, and use a double
> cast the way that risc-v and openrisc do to avoid compile-time
> warnings.
>=20
...
>  =09case 4:=09=09=09=09=09=09=09=09\
> -=09=09__get_user_asm("lw", (ptr), __gu_val, __gu_err);=09\
> +=09=09__get_user_asm("lw", (ptr), x, __gu_err);=09=09\
>  =09=09break;=09=09=09=09=09=09=09\
> -=09case 8:=09=09=09=09=09=09=09=09\
> -=09=09__gu_err =3D __copy_from_user(&__gu_val, ptr, 8);=09=09\
> -=09=09if (__gu_err)=09=09=09=09=09=09\
> -=09=09=09__gu_err =3D -EFAULT;=09=09=09=09\
> +=09case 8: {=09=09=09=09=09=09=09\
> +=09=09__u64 __x =3D 0;=09=09=09=09=09=09\
> +=09=09__gu_err =3D raw_copy_from_user(&__x, ptr, 8) ?=09=09\
> +=09=09=09=09=09=09=09-EFAULT : 0;=09\
> +=09=09(x) =3D (typeof(x))(typeof((x) - (x)))__x;=09=09\
>  =09=09break;=09=09=09=09=09=09=09\

Wouldn't it be better to just fetch two 32bit values:
Something like (for LE - nios2 is definitely LE:
=09=09__u32 val_lo, val_hi;
=09=09__get_user_asm("lw", (ptr), val_lo, __gu_err);
=09=09__get_user_asm("lw", (ptr) + 4, val_hi, __gu_err);
=09=09x =3D val_lo | val_hi << 32;
=09=09break;

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


