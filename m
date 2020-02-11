Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j1QnA-0006cg-Ry
 for linux-um@lists.infradead.org; Tue, 11 Feb 2020 08:21:14 +0000
Message-ID: <13b0ea0caff576e7944e4f9b91560bf46ac9caf0.camel@sipsolutions.net>
Subject: Re: [RFC PATCH v2] UML: add support for KASAN under x86_64
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 11 Feb 2020 09:20:54 +0100
In-Reply-To: <20200210225806.249297-1-trishalfonso@google.com>
 (sfid-20200210_235813_002927_509D549C)
References: <20200210225806.249297-1-trishalfonso@google.com>
 (sfid-20200210_235813_002927_509D549C)
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

Hi,

Looks very nice! Some questions/comments below:

> Depends on Constructor support in UML and is based off of
> "[RFC PATCH] um: implement CONFIG_CONSTRUCTORS for modules"
> (https://patchwork.ozlabs.org/patch/1234551/) 

I guess I should resend this as a proper patch then. Did you test
modules? I can try (later) too.

> The location of the KASAN shadow memory, starting at
> KASAN_SHADOW_OFFSET, can be configured using the
> KASAN_SHADOW_OFFSET option. UML uses roughly 18TB of address
> space, and KASAN requires 1/8th of this.

That also means if I have say 512MB memory allocated for UML, KASAN will
use an *additional* 64, unlike on a "real" system, where KASAN will take
about 1/8th of the available physical memory, right?

> +	help
> +	  This is the offset at which the ~2.25TB of shadow memory is
> +	  initialized 

Maybe that should say "mapped" instead of "initialized", since there are
relatively few machines on which it could actually all all be used?

> +// used in kasan_mem_to_shadow to divide by 8
> +#define KASAN_SHADOW_SCALE_SHIFT 3

nit: use /* */ style comments

> +#define KASAN_SHADOW_START (KASAN_SHADOW_OFFSET)
> +#define KASAN_SHADOW_END (KASAN_SHADOW_START + KASAN_SHADOW_SIZE)
> +
> +#ifdef CONFIG_KASAN
> +void kasan_init(void);
> +#else
> +static inline void kasan_init(void) { }
> +#endif /* CONFIG_KASAN */
> +
> +void kasan_map_memory(void *start, unsigned long len);
> +void kasan_unpoison_shadow(const void *address, size_t size);
> +
> +#endif /* __ASM_UM_KASAN_H */
> diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
> index 5aa882011e04..875e1827588b 100644
> --- a/arch/um/kernel/Makefile
> +++ b/arch/um/kernel/Makefile
> @@ -8,6 +8,28 @@
>  # kernel.
>  KCOV_INSTRUMENT                := n
>  
> +# The way UMl deals with the stack causes seemingly false positive KASAN
> +# reports such as:
> +# BUG: KASAN: stack-out-of-bounds in show_stack+0x15e/0x1fb
> +# Read of size 8 at addr 000000006184bbb0 by task swapper/1
> +# ==================================================================
> +# BUG: KASAN: stack-out-of-bounds in dump_trace+0x141/0x1c5
> +# Read of size 8 at addr 0000000071057eb8 by task swapper/1
> +# ==================================================================
> +# BUG: KASAN: stack-out-of-bounds in get_wchan+0xd7/0x138
> +# Read of size 8 at addr 0000000070e8fc80 by task systemd/1
> +#
> +# With these files removed from instrumentation, those reports are
> +# eliminated, but KASAN still repeatedly reports a bug on syscall_stub_data:
> +# ==================================================================
> +# BUG: KASAN: stack-out-of-bounds in syscall_stub_data+0x299/0x2bf
> +# Read of size 128 at addr 0000000071457c50 by task swapper/1

So that's actually something to fix still? Just trying to understand,
I'll test it later.

> -extern int printf(const char *msg, ...);
> -static void early_print(void)
> +#ifdef CONFIG_KASAN
> +void kasan_init(void)
>  {
> -	printf("I'm super early, before constructors\n");
> +	kasan_map_memory((void *)KASAN_SHADOW_START, KASAN_SHADOW_SIZE);

Heh, you *actually* based it on my patch, in git terms, not just in code
terms. I think you should just pick up the few lines that you need from
that patch and squash them into this one, I just posted that to
demonstrate more clearly what I meant :-)

> +/**
> + * kasan_map_memory() - maps memory from @start with a size of @len.

I think the () shouldn't be there?

> +void kasan_map_memory(void *start, size_t len)
> +{
> +	if (mmap(start,
> +		 len,
> +		 PROT_READ|PROT_WRITE,
> +		 MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE|MAP_NORESERVE,
> +		 -1,
> +		 0) == MAP_FAILED)
> +		os_info("Couldn't allocate shadow memory %s", strerror(errno));

If that fails, can we even continue?

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

