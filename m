Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ntaJq-0092aE-TX
 for linux-um@lists.infradead.org; Tue, 24 May 2022 19:35:52 +0000
Received: by mail-wm1-x332.google.com with SMTP id
 r126-20020a1c4484000000b00397345f2c6fso1704653wma.4
 for <linux-um@lists.infradead.org>; Tue, 24 May 2022 12:35:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200226004608.8128-1-trishalfonso@google.com>
 <CAKFsvULd7w21T_nEn8QiofQGMovFBmi94dq2W_-DOjxf5oD-=w@mail.gmail.com>
 <4b8c1696f658b4c6c393956734d580593b55c4c0.camel@sipsolutions.net>
 <CAKFsvULGSQRx3hL8HgbYbEt_8GOorZj96CoMVhx6sw=xWEwSwA@mail.gmail.com>
 <1fb57ec2a830deba664379f3e0f480e08e6dec2f.camel@sipsolutions.net>
 <20220524103423.GA13239@axis.com>
In-Reply-To: <20220524103423.GA13239@axis.com>
From: David Gow <davidgow@google.com>
Date: Tue, 24 May 2022 12:35:33 -0700
Message-ID: <CABVgOSnTX_e+tzR6c3KnGhDidVtEoUdtt_CJ62g2+MQDMp657g@mail.gmail.com>
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
To: Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, Patricia Alfonso <trishalfonso@google.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dmitry Vyukov <dvyukov@google.com>, Brendan Higgins <brendanhiggins@google.com>, kasan-dev <kasan-dev@googlegroups.com>, LKML <linux-kernel@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>, Daniel Axtens <dja@axtens.net>

+dja in case he has any KASAN_VMALLOC thoughts.

On Tue, May 24, 2022 at 3:34 AM Vincent Whitchurch
<vincent.whitchurch@axis.com> wrote:
>
> On Wed, Mar 11, 2020 at 11:44:37PM +0100, Johannes Berg wrote:
> > On Wed, 2020-03-11 at 15:32 -0700, Patricia Alfonso wrote:
> > > I'll need some time to investigate these all myself. Having just
> > > gotten my first module to run about an hour ago, any more information
> > > about how you got these errors would be helpful so I can try to
> > > reproduce them on my own.
> >
> > See the other emails, I was basically just loading random modules. In my
> > case cfg80211, mac80211, mac80211-hwsim - those are definitely available
> > without any (virtio) hardware requirements, so you could use them.
> >
> > Note that doing a bunch of vmalloc would likely result in similar
> > issues, since the module and vmalloc space is the same on UML.
>
> Old thread, but I had a look at this the other day and I think I got it
> working.  Since the entire shadow area is mapped at init, we don't need
> to do any mappings later.

Wow -- thanks for looking at this again. It's been on my to-do list
for quite a while, too. I'd somewhat resigned myself to having to
re-implement the shadow memory stuff on top of page allocation
functions, so I'm particularly thrilled to see this working without
needing to do that.

>
> It works both with and without KASAN_VMALLOC.  KASAN_STACK works too
> after I disabled sanitization of the stacktrace code.  All kasan kunit
> tests pass and the test_kasan.ko module works too.

I've got this running myself, and can confirm the kasan tests work
under kunit_tool in most cases, though there are a couple of failures
when built with clang/llvm:
[11:56:30] # kasan_global_oob_right: EXPECTATION FAILED at lib/test_kasan.c:732
[11:56:30] KASAN failure expected in "*(volatile char *)p", but none occurred
[11:56:30] not ok 32 - kasan_global_oob_right
[11:56:30] [FAILED] kasan_global_oob_right
[11:56:30] # kasan_global_oob_left: EXPECTATION FAILED at lib/test_kasan.c:746
[11:56:30] KASAN failure expected in "*(volatile char *)p", but none occurred
[11:56:30] not ok 33 - kasan_global_oob_left
[11:56:30] [FAILED] kasan_global_oob_left

The global_oob_left test doesn't work on gcc either (but fails on all
architectures, so is disabled), but kasan_global_oob_right should work
in theory.

>
> Delta patch against Patricia's is below.  The CONFIG_UML checks need to
> be replaced with something more appropriate (new config? __weak
> functions?) and the free functions should probably be hooked up to
> madvise(MADV_DONTNEED) so we discard unused pages in the shadow mapping.

I'd probably go with a new config here, rather than using __weak
functions. Either have a "shadow already allocated" config like the
CONFIG_KASAN_NO_SHADOW_ALLOC Johannes suggests, or something like
CONFIG_KASAN_HAS_ARCH_SHADOW_ALLOC, and call into an
architecture-specific "shadow allocator", which would just do the
__memset(). The latter would make adding the madvise(MADV_DONTNEED)
easier, I think, though it's more work in general. Ultimately a
question for the KASAN folks, though.

> Note that there's a KASAN stack-out-of-bounds splat on startup when just
> booting UML.  That looks like a real (17-year-old) bug, I've posted a
> fix for that:
>
>  https://lore.kernel.org/lkml/20220523140403.2361040-1-vincent.whitchurch@axis.com/
>

Wow, that's a good catch. And also explains a bit why I was so
confused trying to understand that code when we were originally
looking at this.

> 8<-----------
> diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> index a1bd8c07ce14..5f3a4d25d57e 100644
> --- a/arch/um/Kconfig
> +++ b/arch/um/Kconfig
> @@ -12,6 +12,7 @@ config UML
>         select ARCH_NO_PREEMPT
>         select HAVE_ARCH_AUDITSYSCALL
>         select HAVE_ARCH_KASAN if X86_64
> +       select HAVE_ARCH_KASAN_VMALLOC if HAVE_ARCH_KASAN
>         select HAVE_ARCH_SECCOMP_FILTER
>         select HAVE_ASM_MODVERSIONS
>         select HAVE_UID16
> @@ -223,7 +224,7 @@ config UML_TIME_TRAVEL_SUPPORT
>  config KASAN_SHADOW_OFFSET
>         hex
>         depends on KASAN
> -       default 0x7fff8000
> +       default 0x100000000000
>         help
>           This is the offset at which the ~2.25TB of shadow memory is
>           mapped and used by KASAN for memory debugging. This can be any
> diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
> index 1c2d4b29a3d4..a089217e2f0e 100644
> --- a/arch/um/kernel/Makefile
> +++ b/arch/um/kernel/Makefile
> @@ -27,6 +27,9 @@ obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
>  obj-$(CONFIG_STACKTRACE) += stacktrace.o
>  obj-$(CONFIG_GENERIC_PCI_IOMAP) += ioport.o
>
> +KASAN_SANITIZE_stacktrace.o := n
> +KASAN_SANITIZE_sysrq.o := n
> +
>  USER_OBJS := config.o
>
>  include arch/um/scripts/Makefile.rules
> diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
> index 7c3196c297f7..a32cfce53efb 100644
> --- a/arch/um/kernel/mem.c
> +++ b/arch/um/kernel/mem.c
> @@ -33,7 +33,7 @@ void kasan_init(void)
>  }
>
>  static void (*kasan_init_ptr)(void)
> -__section(.kasan_init) __used
> +__section(".kasan_init") __used
>  = kasan_init;
>  #endif
>
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index 1113cf5fea25..1f3e620188a2 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -152,7 +152,7 @@ config KASAN_STACK
>         bool "Enable stack instrumentation (unsafe)" if CC_IS_CLANG && !COMPILE_TEST
>         depends on KASAN_GENERIC || KASAN_SW_TAGS
>         depends on !ARCH_DISABLE_KASAN_INLINE
> -       default y if CC_IS_GCC && !UML
> +       default y if CC_IS_GCC
>         help
>           The LLVM stack address sanitizer has a know problem that
>           causes excessive stack usage in a lot of functions, see
> diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> index a4f07de21771..d8c518bd0e7d 100644
> --- a/mm/kasan/shadow.c
> +++ b/mm/kasan/shadow.c
> @@ -295,8 +295,14 @@ int kasan_populate_vmalloc(unsigned long addr, unsigned long size)
>                 return 0;
>
>         shadow_start = (unsigned long)kasan_mem_to_shadow((void *)addr);
> -       shadow_start = ALIGN_DOWN(shadow_start, PAGE_SIZE);
>         shadow_end = (unsigned long)kasan_mem_to_shadow((void *)addr + size);
> +
> +       if (IS_ENABLED(CONFIG_UML)) {
> +               __memset(kasan_mem_to_shadow((void *)addr), KASAN_VMALLOC_INVALID, shadow_end - shadow_start);
> +               return 0;
> +       }
> +
> +       shadow_start = ALIGN_DOWN(shadow_start, PAGE_SIZE);
>         shadow_end = ALIGN(shadow_end, PAGE_SIZE);

Is there a particular reason we're not doing the rounding under UML,
particularly since I think it's happening anyway in
kasan_release_vmalloc() below. (I get that it's not really necessary,
but is there an actual bug you've noticed with it?)

>
>         ret = apply_to_page_range(&init_mm, shadow_start,
> @@ -466,6 +472,10 @@ void kasan_release_vmalloc(unsigned long start, unsigned long end,
>
>         if (shadow_end > shadow_start) {
>                 size = shadow_end - shadow_start;
> +               if (IS_ENABLED(CONFIG_UML)) {
> +                       __memset(shadow_start, KASAN_SHADOW_INIT, shadow_end - shadow_start);
> +                       return;
> +               }
>                 apply_to_existing_page_range(&init_mm,
>                                              (unsigned long)shadow_start,
>                                              size, kasan_depopulate_vmalloc_pte,
> @@ -531,6 +541,11 @@ int kasan_alloc_module_shadow(void *addr, size_t size, gfp_t gfp_mask)
>         if (WARN_ON(!PAGE_ALIGNED(shadow_start)))
>                 return -EINVAL;
>
> +       if (IS_ENABLED(CONFIG_UML)) {
> +               __memset((void *)shadow_start, KASAN_SHADOW_INIT, shadow_size);
> +               return 0;
> +       }
> +
>         ret = __vmalloc_node_range(shadow_size, 1, shadow_start,
>                         shadow_start + shadow_size,
>                         GFP_KERNEL,
> @@ -554,6 +569,9 @@ int kasan_alloc_module_shadow(void *addr, size_t size, gfp_t gfp_mask)
>
>  void kasan_free_module_shadow(const struct vm_struct *vm)
>  {
> +       if (IS_ENABLED(CONFIG_UML))
> +               return;
> +
>         if (vm->flags & VM_KASAN)
>                 vfree(kasan_mem_to_shadow(vm->addr));
>  }

In any case, this looks pretty great to me. I still definitely want to
play with it a bit more, particularly with various module loads -- and
it'd be great to track down why those global_oob tests are failing --
but I'm definitely hopeful that we can finish this off and get it
upstream.

It's probably worth sending a new rebased/combined patch out which has
your fixes and applies more cleanly on recent kernels. (I've got a
working tree here, so I can do that if you'd prefer.)

Cheers,
-- David

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

