Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 24 Dec 2015 17:34:09 -0800
From: Josh Triplett <josh@joshtriplett.org>
Message-ID: <20151225013409.GC12977@x>
References: <1450959131-5113-1-git-send-email-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <1450959131-5113-1-git-send-email-mic@digikod.net>
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v3] um: Fix build error and kconfig for i386
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net, "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>, Michal Marek <mmarek@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, stable@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Thu, Dec 24, 2015 at 01:12:11PM +0100, Micka=EBl Sala=FCn wrote:
> Fix build error by generating elfcore.o only when ELF_CORE (depending=
 on
> COREDUMP) is selected:
>=20
> arch/x86/um/built-in.o: In function `elf_core_write_extra_phdrs':
> (.text+0x3e62): undefined reference to `dump_emit'
> arch/x86/um/built-in.o: In function `elf_core_write_extra_data':
> (.text+0x3eef): undefined reference to `dump_emit'
>=20
> Fixes: 5d2acfc7b974 ("kconfig: make allnoconfig disable options behin=
d EMBEDDED and EXPERT")
> Signed-off-by: Micka=EBl Sala=FCn <mic@digikod.net>
> Cc: Jeff Dike <jdike@addtoit.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Cc: Michal Marek <mmarek@suse.cz>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>

It looks like ELF_CORE depends on COREDUMP, but not on BINFMT_ELF.
Should it?  What happens if you build this with ELF_CORE=3Dy and
BINFMT_ELF=3Dn?  Does that configuration even make sense?

>  arch/x86/um/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
> index a8fecc226946..3ee2bb6b440b 100644
> --- a/arch/x86/um/Makefile
> +++ b/arch/x86/um/Makefile
> @@ -17,7 +17,7 @@ obj-y =3D bug.o bugs_$(BITS).o delay.o fault.o ksym=
s.o ldt.o \
>  ifeq ($(CONFIG_X86_32),y)
> =20
>  obj-y +=3D checksum_32.o
> -obj-$(CONFIG_BINFMT_ELF) +=3D elfcore.o
> +obj-$(CONFIG_ELF_CORE) +=3D elfcore.o
> =20
>  subarch-y =3D ../lib/string_32.o ../lib/atomic64_32.o ../lib/atomic6=
4_cx8_32.o
>  subarch-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) +=3D ../lib/rwsem.o
> --=20
> 2.6.4
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

