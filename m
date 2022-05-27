Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nugMB-000uhj-SN
	for linux-um@lists.infradead.org; Fri, 27 May 2022 20:14:49 +0000
Message-ID: <de38a6b852d31cbe123d033965dbd9b662d29a76.camel@sipsolutions.net>
Subject: Re: [PATCH v2 2/2] UML: add support for KASAN under x86_64
From: Johannes Berg <johannes@sipsolutions.net>
Date: Fri, 27 May 2022 22:14:37 +0200
In-Reply-To: <20220527185600.1236769-2-davidgow@google.com>
References: <20220527185600.1236769-1-davidgow@google.com>
	 <20220527185600.1236769-2-davidgow@google.com>
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
To: David Gow <davidgow@google.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>, Patricia Alfonso <trishalfonso@google.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, anton.ivanov@cambridgegreys.com, Dmitry Vyukov <dvyukov@google.com>, Brendan Higgins <brendanhiggins@google.com>, Andrew Morton <akpm@linux-foundation.org>, Andrey Konovalov <andreyknvl@gmail.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: kasan-dev <kasan-dev@googlegroups.com>, linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, Daniel Latypov <dlatypov@google.com>, linux-mm@kvack.org

On Fri, 2022-05-27 at 11:56 -0700, David Gow wrote:
> 
> This is v2 of the KASAN/UML port. It should be ready to go.

Nice, thanks a lot! :)

> It does benefit significantly from the following patches:
> - Bugfix for memory corruption, needed for KASAN_STACK support:
> https://lore.kernel.org/lkml/20220523140403.2361040-1-vincent.whitchurch@axis.com/

Btw, oddly enough, I don't seem to actually see this (tried gcc 10.3 and
11.3 so far) - is there anything you know about compiler versions
related to this perhaps? Or clang only?

The kasan_stack_oob test passes though, and generally 45 tests pass and
10 are skipped.


> +# Kernel config options are not included in USER_CFLAGS, but the
> option for KASAN
> +# should be included if the KASAN config option was set.
> +ifdef CONFIG_KASAN
> +	USER_CFLAGS+=-DCONFIG_KASAN=y
> +endif
> 

I'm not sure that's (still?) necessary - you don't #ifdef on it anywhere
in the user code; perhaps the original intent had been to #ifdef
kasan_map_memory()?


> +++ b/arch/um/os-Linux/user_syms.c
> @@ -27,10 +27,10 @@ EXPORT_SYMBOL(strstr);
>  #ifndef __x86_64__
>  extern void *memcpy(void *, const void *, size_t);
>  EXPORT_SYMBOL(memcpy);
> -#endif
> -
>  EXPORT_SYMBOL(memmove);
>  EXPORT_SYMBOL(memset);
> +#endif
> +
>  EXPORT_SYMBOL(printf);
>  
>  /* Here, instead, I can provide a fake prototype. Yes, someone cares: genksyms.
> diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
> index ba5789c35809..f778e37494ba 100644
> --- a/arch/x86/um/Makefile
> +++ b/arch/x86/um/Makefile
> @@ -28,7 +28,8 @@ else
>  
>  obj-y += syscalls_64.o vdso/
>  
> -subarch-y = ../lib/csum-partial_64.o ../lib/memcpy_64.o ../entry/thunk_64.o
> +subarch-y = ../lib/csum-partial_64.o ../lib/memcpy_64.o ../entry/thunk_64.o \
> +	../lib/memmove_64.o ../lib/memset_64.o

I wonder if we should make these two changes contingent on KASAN too, I
seem to remember that we had some patches from Anton flying around at
some point to use glibc string routines, since they can be even more
optimised (we're in user space, after all).

But I suppose for now this doesn't really matter, and even if we did use
them, they'd come from libasan anyway?


Anyway, looks good to me, not sure the little not above about the user
cflags matters.

Reviewed-by: Johannes Berg <johannes@sipsolutions.net>

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

