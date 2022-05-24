Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ntS2V-007gqu-3C
 for linux-um@lists.infradead.org; Tue, 24 May 2022 10:45:24 +0000
Message-ID: <fce12845b59a49cc2994e55cfd88071f6890c138.camel@sipsolutions.net>
Subject: Re: [PATCH] UML: add support for KASAN under x86_64
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 24 May 2022 12:45:03 +0200
In-Reply-To: <20220524103423.GA13239@axis.com>
References: <20200226004608.8128-1-trishalfonso@google.com>
 <CAKFsvULd7w21T_nEn8QiofQGMovFBmi94dq2W_-DOjxf5oD-=w@mail.gmail.com>
 <4b8c1696f658b4c6c393956734d580593b55c4c0.camel@sipsolutions.net>
 <CAKFsvULGSQRx3hL8HgbYbEt_8GOorZj96CoMVhx6sw=xWEwSwA@mail.gmail.com>
 <1fb57ec2a830deba664379f3e0f480e08e6dec2f.camel@sipsolutions.net>
 <20220524103423.GA13239@axis.com>
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
To: Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc: Patricia Alfonso <trishalfonso@google.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, anton.ivanov@cambridgegreys.com, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dmitry Vyukov <dvyukov@google.com>, Brendan Higgins <brendanhiggins@google.com>, David Gow <davidgow@google.com>, kasan-dev <kasan-dev@googlegroups.com>, LKML <linux-kernel@vger.kernel.org>, linux-um@lists.infradead.org

Hi Vincent,

> Old thread, but I had a look at this the other day and I think I got it
> working.  Since the entire shadow area is mapped at init, we don't need
> to do any mappings later.

Nice!! I've always wanted to get back to this too.

> It works both with and without KASAN_VMALLOC.  KASAN_STACK works too
> after I disabled sanitization of the stacktrace code.  All kasan kunit
> tests pass and the test_kasan.ko module works too.

:-)

> The CONFIG_UML checks need to
> be replaced with something more appropriate (new config? __weak
> functions?) and the free functions should probably be hooked up to
> madvise(MADV_DONTNEED) so we discard unused pages in the shadow
> mapping.

I guess a new config would be most appropriate - that way code can be
compiled out accordingly. But I don't know who maintains the KASAN code,
I guess have to discuss with them.

> Note that there's a KASAN stack-out-of-bounds splat on startup when just
> booting UML.  That looks like a real (17-year-old) bug, I've posted a
> fix for that:
> 
>  https://lore.kernel.org/lkml/20220523140403.2361040-1-vincent.whitchurch@axis.com/

Hah, right, I was wondering how that came up suddenly now... Almost
suprised it's just a single bug so far :)

> --- a/mm/kasan/shadow.c
> +++ b/mm/kasan/shadow.c
> @@ -295,8 +295,14 @@ int kasan_populate_vmalloc(unsigned long addr, unsigned long size)
>  		return 0;
>  
>  	shadow_start = (unsigned long)kasan_mem_to_shadow((void *)addr);
> -	shadow_start = ALIGN_DOWN(shadow_start, PAGE_SIZE);
>  	shadow_end = (unsigned long)kasan_mem_to_shadow((void *)addr + size);
> +
> +	if (IS_ENABLED(CONFIG_UML)) {
> +		__memset(kasan_mem_to_shadow((void *)addr), KASAN_VMALLOC_INVALID, shadow_end - shadow_start);
> +		return 0;
> +	}
> 

If that were

	if (IS_ENABLED(CONFIG_KASAN_NO_SHADOW_ALLOC)) {
		...
	}

(or so) as discussed above, it might be a little more readable, but
otherwise it doesn't really seem all _that_ intrusive.

I'll give it a spin later.

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

