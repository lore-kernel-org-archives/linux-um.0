Return-Path: <mpe@ellerman.id.au>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 2/3] trace: refactor TRACE_IRQFLAGS_SUPPORT in Kconfig
In-Reply-To: <20210731052233.4703-2-masahiroy@kernel.org>
References: <20210731052233.4703-1-masahiroy@kernel.org>
 <20210731052233.4703-2-masahiroy@kernel.org>
Date: Mon, 02 Aug 2021 12:56:13 +1000
Message-ID: <87lf5klfle.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
To: Masahiro Yamada <masahiroy@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Linus Walleij <linus.walleij@linaro.org>, Ley Foon Tan <ley.foon.tan@intel.com>, x86@kernel.org, linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, Anshuman Khandual <anshuman.khandual@arm.com>, Nick Hu <nickhu@andestech.com>, Thomas Gleixner <tglx@linutronix.de>, Mike Rapoport <rppt@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, linux-riscv@lists.infradead.org, YiFei Zhu <yifeifz2@illinois.edu>, Greentime Hu <green.hu@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Michal Simek <monstr@monstr.eu>, Helge Deller <deller@gmx.de>, linux-sh@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Guo Ren <guoren@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Richard Weinberger <richard@nod.at>, Christian Borntraeger <borntraeger@de.ibm.com>, Rich Felker <dalias@libc.org>, Albert Ou <aou@eecs.berkeley.edu>, Heiko Carstens <hca@linux.ibm.com>, Jeff Dike <jdike@addtoit.com>, Max Filippov <jcmvbkbc@gmail.com>, linux-hexagon@vger.kernel.org, linux-xtensa@linux-xtensa.org, "H. Peter Anvin  <hpa@zytor.com>, Will Deacon <will@kernel.org>, Thomas Bogendoerfer" <tsbogend@alpha.franken.de>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, linux-s390@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, linux-um@lists.infradead.org, Andrey Konovalov <andreyknvl@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Brian Cain <bcain@codeaurora.org>, linux-csky@vger.kernel.org, Stafford Horne <shorne@gmail.com>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>, Chris Zankel <chris@zankel.net>, Vasily Gorbik <gor@linux.ibm.com>, linux-snps-arc@lists.infradead.org, Jonas Bonn <jonas@southpole.se>, linux-parisc@vger.kernel.org, Kees Cook <keescook@chromium.org>, Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>, Colin Ian King <colin.king@canonical.com>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, Vincent Chen <deanbo422@gmail.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Andrew Morton <akpm@linux-foundation.org>, Paul Mackerras <paulus@samba.org>, Mark Rutland <mark.rutland@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, linuxppc-dev@lists.ozlabs.org, openrisc@lists.librecores.org
List-ID: <linux-um.lists.infradead.org>

Masahiro Yamada <masahiroy@kernel.org> writes:
> Make architectures select TRACE_IRQFLAGS_SUPPORT instead of
> having many defines.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  arch/Kconfig                  | 3 +++
>  arch/arc/Kconfig              | 4 +---
>  arch/arm/Kconfig              | 5 +----
>  arch/arm64/Kconfig            | 4 +---
>  arch/csky/Kconfig             | 4 +---
>  arch/hexagon/Kconfig          | 4 +---
>  arch/microblaze/Kconfig       | 1 +
>  arch/microblaze/Kconfig.debug | 5 -----
>  arch/mips/Kconfig             | 1 +
>  arch/mips/Kconfig.debug       | 4 ----
>  arch/nds32/Kconfig            | 4 +---
>  arch/nios2/Kconfig            | 3 ---
>  arch/openrisc/Kconfig         | 4 +---
>  arch/parisc/Kconfig           | 1 +
>  arch/parisc/Kconfig.debug     | 3 ---
>  arch/powerpc/Kconfig          | 5 +----
>  arch/riscv/Kconfig            | 4 +---
>  arch/s390/Kconfig             | 1 +
>  arch/s390/Kconfig.debug       | 3 ---
>  arch/sh/Kconfig               | 1 +
>  arch/sh/Kconfig.debug         | 3 ---
>  arch/sparc/Kconfig            | 1 +
>  arch/sparc/Kconfig.debug      | 4 ----
>  arch/um/Kconfig               | 5 +----
>  arch/x86/Kconfig              | 1 +
>  arch/x86/Kconfig.debug        | 3 ---
>  arch/xtensa/Kconfig           | 4 +---
>  27 files changed, 21 insertions(+), 64 deletions(-)

> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index d01e3401581d..76a28452c042 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -94,10 +94,6 @@ config STACKTRACE_SUPPORT
>  	bool
>  	default y
>  
> -config TRACE_IRQFLAGS_SUPPORT
> -	bool
> -	default y
> -
>  config LOCKDEP_SUPPORT
>  	bool
>  	default y
> @@ -271,6 +267,7 @@ config PPC
>  	select STRICT_KERNEL_RWX if STRICT_MODULE_RWX
>  	select SYSCTL_EXCEPTION_TRACE
>  	select THREAD_INFO_IN_TASK
> +	select TRACE_IRQFLAGS_SUPPORT
>  	select VIRT_TO_BUS			if !PPC64
>  	#
>  	# Please keep this list sorted alphabetically.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

