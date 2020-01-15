Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1irniO-0005kp-Ah
 for linux-um@lists.infradead.org; Wed, 15 Jan 2020 18:48:34 +0000
Message-ID: <dce24e66d89940c8998ccc2916e57877ccc9f6ae.camel@sipsolutions.net>
Subject: Re: [RFC PATCH] UML: add support for KASAN under x86_64
From: Johannes Berg <johannes@sipsolutions.net>
Date: Wed, 15 Jan 2020 19:48:13 +0100
In-Reply-To: <20200115182816.33892-1-trishalfonso@google.com>
References: <20200115182816.33892-1-trishalfonso@google.com>
MIME-Version: 1.0
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
To: Patricia Alfonso <trishalfonso@google.com>, jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, aryabinin@virtuozzo.com, dvyukov@google.com, davidgow@google.com, brendanhiggins@google.com
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com

Hi Patricia,

On Wed, 2020-01-15 at 10:28 -0800, Patricia Alfonso wrote:
> Make KASAN run on User Mode Linux on x86_64.

Oh wow, awesome! Just what I always wanted :-)

I tried this before and failed miserably ... mostly I thought we
actually needed CONFIG_CONSTRUCTORS, which doesn't work (at least I hope
my patch for it was reverted?) - do you know what's up with that?

Couple questions, if you don't mind.

> +#ifdef CONFIG_X86_64
> +#define KASAN_SHADOW_SIZE 0x100000000000UL
> +#else
> +#error "KASAN_SHADOW_SIZE is not defined in this sub-architecture"
> +#endif

Is it even possible today to compile ARCH=um on anything but x86_64? If
yes, perhaps the above should be

	select HAVE_ARCH_KASAN if X86_64

or so? I assume KASAN itself has some dependencies though, but perhaps
ARM 64-bit or POWERPC 64-bit could possibly run into this, if not X86
32-bit.

> +++ b/arch/um/kernel/skas/Makefile
> @@ -5,6 +5,12 @@
>  
>  obj-y := clone.o mmu.o process.o syscall.o uaccess.o
>  
> +ifdef CONFIG_UML
> +# Do not instrument until after start_uml() because KASAN is not
> +# initialized yet
> +KASAN_SANITIZE	:= n
> +endif

Not sure I understand this, can anything in this file even get compiled
without CONFIG_UML?

> +++ b/kernel/Makefile
> @@ -32,6 +32,12 @@ KCOV_INSTRUMENT_kcov.o := n
>  KASAN_SANITIZE_kcov.o := n
>  CFLAGS_kcov.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
>  
> +ifdef CONFIG_UML
> +# Do not istrument kasan on panic because it can be called before KASAN

typo there - 'instrument'

> +# is initialized
> +KASAN_SANITIZE_panic.o := n
> +endif

but maybe UML shouldn't call panic() in such contexts, instead of this?
I've had some major trouble with calling into the kernel before things
are ready (or after we've started tearing things down), so that might be
a good thing overall anyway?

Could just do it this way and fix it later too though I guess.

> +++ b/lib/Makefile
> @@ -17,6 +17,16 @@ KCOV_INSTRUMENT_list_debug.o := n
>  KCOV_INSTRUMENT_debugobjects.o := n
>  KCOV_INSTRUMENT_dynamic_debug.o := n
>  
> +# Don't sanatize 

typo

> vsprintf or string functions in UM because they are used
> +# before KASAN is initialized from cmdline parsing cmdline and kstrtox are
> +# also called during uml initialization before KASAN is instrumented
> +ifdef CONFIG_UML
> +KASAN_SANITIZE_vsprintf.o := n
> +KASAN_SANITIZE_string.o := n
> +KASAN_SANITIZE_cmdline.o := n
> +KASAN_SANITIZE_kstrtox.o := n
> +endif

I guess this can't be avoided.


Very cool, I look forward to trying this out! :-)

Thanks,
johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

