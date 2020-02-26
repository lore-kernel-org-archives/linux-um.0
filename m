Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j6lMP-0000uR-VS
 for linux-um@lists.infradead.org; Wed, 26 Feb 2020 01:19:39 +0000
Received: by mail-pf1-x444.google.com with SMTP id j9so524384pfa.8
 for <linux-um@lists.infradead.org>; Tue, 25 Feb 2020 17:19:34 -0800 (PST)
MIME-Version: 1.0
References: <20200226004608.8128-1-trishalfonso@google.com>
In-Reply-To: <20200226004608.8128-1-trishalfonso@google.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Tue, 25 Feb 2020 17:19:21 -0800
Message-ID: <CAFd5g45gqZcJ6v3KSDuBffgBzfZ+=GJ2oCuSurYehoMHBK0Grg@mail.gmail.com>
Subject: Re: [PATCH] UML: add support for KASAN under x86_64
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Patricia Alfonso <trishalfonso@google.com>
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kasan-dev@googlegroups.com, David Gow <davidgow@google.com>, aryabinin@virtuozzo.com, Johannes Berg <johannes@sipsolutions.net>, Dmitry Vyukov <dvyukov@google.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Tue, Feb 25, 2020 at 4:46 PM Patricia Alfonso
<trishalfonso@google.com> wrote:
>
> Make KASAN run on User Mode Linux on x86_64.
>
> Depends on Constructor support in UML - "[RFC PATCH] um:
> implement CONFIG_CONSTRUCTORS for modules"
> (https://patchwork.ozlabs.org/patch/1234551/) by Johannes Berg.
>
> The location of the KASAN shadow memory, starting at
> KASAN_SHADOW_OFFSET, can be configured using the
> KASAN_SHADOW_OFFSET option. UML uses roughly 18TB of address
> space, and KASAN requires 1/8th of this. The default location of
> this offset is 0x7fff8000 as suggested by Dmitry Vyukov. There is
> usually enough free space at this location; however, it is a config
> option so that it can be easily changed if needed.
>
> The UML-specific KASAN initializer uses mmap to map
> the roughly 2.25TB of shadow memory to the location defined by
> KASAN_SHADOW_OFFSET. kasan_init() utilizes constructors to initialize
> KASAN before main().
>
> Disable stack instrumentation on UML via KASAN_STACK config option to
> avoid false positive KASAN reports.
>
> Signed-off-by: Patricia Alfonso <trishalfonso@google.com>

A couple of minor nits (well one nit and one question), but overall
this looks good to me.

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

> ---
>  arch/um/Kconfig                  | 13 +++++++++++++
>  arch/um/Makefile                 |  6 ++++++
>  arch/um/include/asm/common.lds.S |  1 +
>  arch/um/include/asm/kasan.h      | 32 ++++++++++++++++++++++++++++++++
>  arch/um/kernel/dyn.lds.S         |  5 ++++-
>  arch/um/kernel/mem.c             | 18 ++++++++++++++++++
>  arch/um/os-Linux/mem.c           | 22 ++++++++++++++++++++++
>  arch/um/os-Linux/user_syms.c     |  4 ++--
>  arch/x86/um/Makefile             |  3 ++-
>  arch/x86/um/vdso/Makefile        |  3 +++
>  lib/Kconfig.kasan                |  2 +-
>  11 files changed, 104 insertions(+), 5 deletions(-)
>  create mode 100644 arch/um/include/asm/kasan.h
>
> diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> index 0917f8443c28..fb2ad1fb05fd 100644
> --- a/arch/um/Kconfig
> +++ b/arch/um/Kconfig
> @@ -8,6 +8,7 @@ config UML
>         select ARCH_HAS_KCOV
>         select ARCH_NO_PREEMPT
>         select HAVE_ARCH_AUDITSYSCALL
> +       select HAVE_ARCH_KASAN if X86_64
>         select HAVE_ARCH_SECCOMP_FILTER
>         select HAVE_ASM_MODVERSIONS
>         select HAVE_UID16
> @@ -200,6 +201,18 @@ config UML_TIME_TRAVEL_SUPPORT
>
>           It is safe to say Y, but you probably don't need this.
>
> +config KASAN_SHADOW_OFFSET
> +       hex
> +       depends on KASAN
> +       default 0x7fff8000

nit: It looks like you chose the default that Dmitry suggested. Some
explanation of this in the help would probably be good.

> +       help
> +         This is the offset at which the ~2.25TB of shadow memory is
> +         mapped and used by KASAN for memory debugging. This can be any
> +         address that has at least KASAN_SHADOW_SIZE(total address space divided
> +         by 8) amount of space so that the KASAN shadow memory does not conflict
> +         with anything. The default is 0x7fff8000, as it fits into immediate of
> +         most instructions.
> +
>  endmenu

[...]

> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index 81f5464ea9e1..5b54f3c9a741 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -125,7 +125,7 @@ config KASAN_STACK_ENABLE
>
>  config KASAN_STACK
>         int
> -       default 1 if KASAN_STACK_ENABLE || CC_IS_GCC
> +       default 1 if (KASAN_STACK_ENABLE || CC_IS_GCC) && !UML

Up to the KASAN people, but I think you can probably move this to
arch/um/Kconfig. There is some advantage to having all the UML
specific Kconfigery in arch/um/Kconfig, but there are also already a
lot of things that specify !UML outside of arch/um/.

>         default 0
>
>  config KASAN_S390_4_LEVEL_PAGING
> --
> 2.25.0.265.gbab2e86ba0-goog
>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

