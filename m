Return-Path: <jcmvbkbc@gmail.com>
MIME-Version: 1.0
References: <20211026100432.1730393-1-arnd@kernel.org> <20211026100432.1730393-2-arnd@kernel.org>
In-Reply-To: <20211026100432.1730393-2-arnd@kernel.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 26 Oct 2021 05:30:26 -0700
Message-ID: <CAMo8BfLN0Q+_K2fP9KVBPyqAMahtCSZB1MwLBRtQYcK3R35N7Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] futex: remove futex_cmpxchg detection
Content-Type: text/plain; charset="UTF-8"
To: Arnd Bergmann <arnd@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Chris Zankel <chris@zankel.net>, Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@collabora.com>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Anshuman Khandual <anshuman.khandual@arm.com>, linux-snps-arc@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, "open list:M68K ARCHITECTURE" <linux-m68k@lists.linux-m68k.org>, linux-riscv@lists.infradead.org, linux-s390 <linux-s390@vger.kernel.org>, "open list:SUPERH" <linux-sh@vger.kernel.org>, linux-um@lists.infradead.org, "open list:TENSILICA XTENSA PORT (xtensa)" <linux-xtensa@linux-xtensa.org>
List-ID: <linux-um.lists.infradead.org>

On Tue, Oct 26, 2021 at 3:06 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Now that all architectures have a working futex implementation
> in any configuration, remove the runtime detection code.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arc/Kconfig              |  1 -
>  arch/arm/Kconfig              |  1 -
>  arch/arm64/Kconfig            |  1 -
>  arch/csky/Kconfig             |  1 -
>  arch/m68k/Kconfig             |  1 -
>  arch/riscv/Kconfig            |  1 -
>  arch/s390/Kconfig             |  1 -
>  arch/sh/Kconfig               |  1 -
>  arch/um/Kconfig               |  1 -
>  arch/um/kernel/skas/uaccess.c |  1 -
>  arch/xtensa/Kconfig           |  1 -
>  init/Kconfig                  |  8 --------
>  kernel/futex/core.c           | 35 -----------------------------------
>  kernel/futex/futex.h          |  6 ------
>  kernel/futex/syscalls.c       | 22 ----------------------
>  15 files changed, 82 deletions(-)

For xtensa:
Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max

