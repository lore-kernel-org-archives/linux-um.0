Return-Path: <richard@nod.at>
From: Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH -next 0/3] Add support for fast mremap
Date: Sat, 03 Nov 2018 10:15:11 +0100
Message-ID: <6886607.O3ZT5bM3Cy@blindfold>
In-Reply-To: <20181103040041.7085-1-joelaf@google.com>
References: <20181103040041.7085-1-joelaf@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
To: Joel Fernandes <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, Joel Fernandes <joelaf@google.com>, akpm@linux-foundation.org, Andrey Ryabinin <aryabinin@virtuozzo.com>, Andy Lutomirski <luto@kernel.org>, anton.ivanov@kot-begemot.co.uk, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Chris Zankel <chris@zankel.net>, dancol@google.com, Dave Hansen <dave.hansen@linux.intel.com>, "David S. Miller" <davem@davemloft.net>, elfring@users.sourceforge.net, Fenghua Yu <fenghua.yu@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Guan Xuetao <gxt@pku.edu.cn>, Helge Deller <deller@gmx.de>, hughd@google.com, Ingo Molnar <mingo@redhat.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Jeff Dike <jdike@addtoit.com>, Jonas Bonn <jonas@southpole.se>, Julia Lawall <Julia.Lawall@lip6.fr>, kasan-dev@googlegroups.com, kirill@shutemov.name, kvmarm@lists.cs.columbia.edu, Ley Foon Tan <lftan@altera.com>, linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vge, r.kernel.org@lithops.sigma-star.at, linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org, linux-mm@kvack.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, lokeshgidra@google.com, Max Filippov <jcmvbkbc@gmail.com>, Michal Hocko <mhocko@kernel.org>, minchan@kernel.org, nios2-dev@lists.rocketboards.org, pantin@google.com, Peter Zijlstra <peterz@infradead.org>, Rich Felker <dalias@libc.org>, Sam Creasey <sammy@sammy.net>, sparclinux@vger.kernel.org, Stafford Horne <shorne@gmail.com>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Thomas Gleixner <tglx@linutronix.de>, Tony Luck <tony.luck@intel.com>, Will Deacon <will.deacon@arm.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>
List-ID: <linux-um.lists.infradead.org>

Joel,

Am Samstag, 3. November 2018, 05:00:38 CET schrieb Joel Fernandes:
> Hi,
> Here is the latest "fast mremap" series. This just a repost with Kirill's
> Acked-bys added. I would like this to be considered for linux -next.  I a=
lso
> dropped the CONFIG enablement patch for arm64 since I am yet to test it w=
ith
> the new TLB flushing code that is in very recent kernel releases. (None o=
f my
> arm64 devices run mainline right now.) so I will post the arm64 enablemen=
t once
> I get to that. The performance numbers in the series are for x86.
>=20
> List of patches in series:
>=20
> (1) mm: select HAVE_MOVE_PMD in x86 for faster mremap
>=20
> (2) mm: speed up mremap by 20x on large regions (v4)
> v1->v2: Added support for per-arch enablement (Kirill Shutemov)
> v2->v3: Updated commit message to state the optimization may also
> 	run for non-thp type of systems (Daniel Col).
> v3->v4: Remove useless pmd_lock check (Kirill Shutemov)
> 	Rebased ontop of Linus's master, updated perf results based
>         on x86 testing. Added Kirill's Acks.
>=20
> (3) mm: treewide: remove unused address argument from pte_alloc functions=
 (v2)
> v1->v2: fix arch/um/ prototype which was missed in v1 (Anton Ivanov)
>         update changelog with manual fixups for m68k and microblaze.
>=20
> not included - (4) mm: select HAVE_MOVE_PMD in arm64 for faster mremap
>     This patch is dropped since last posting pending further performance
>     testing on arm64 with new TLB gather updates. See notes in patch
>     titled "mm: speed up mremap by 500x on large regions" for more
>     details.
>=20

This breaks UML build:
  CC      mm/mremap.o
mm/mremap.c: In function =E2=80=98move_normal_pmd=E2=80=99:
mm/mremap.c:229:2: error: implicit declaration of function =E2=80=98set_pmd=
_at=E2=80=99; did you mean =E2=80=98set_pte_at=E2=80=99? [-Werror=3Dimplici=
t-function-declaration]
  set_pmd_at(mm, new_addr, new_pmd, pmd);
  ^~~~~~~~~~
  set_pte_at
  CC      crypto/rng.o
  CC      fs/direct-io.o
cc1: some warnings being treated as errors

To test yourself, just run on a x86 box:
$ make defconfig ARCH=3Dum
$ make linux ARCH=3Dum

Thanks,
//richard



