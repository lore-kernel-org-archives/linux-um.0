Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nucAW-000SYx-Ah
	for linux-um@lists.infradead.org; Fri, 27 May 2022 15:46:29 +0000
Received: by mail-lf1-x130.google.com with SMTP id v8so7491925lfd.8
        for <linux-um@lists.infradead.org>; Fri, 27 May 2022 08:46:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220525111756.GA15955@axis.com> <20220526010111.755166-1-davidgow@google.com>
 <e2339dcea553f9121f2d3aad29f7428c2060f25f.camel@sipsolutions.net>
 <CACT4Y+ZVrx9VudKV5enB0=iMCBCEVzhCAu_pmxBcygBZP_yxfg@mail.gmail.com>
 <6fa1ebe49b8d574fb1c82aefeeb54439d9c98750.camel@sipsolutions.net>
 <CACT4Y+bhBMDn80u=W8VBbn4uZg1oD8zsE3RJJC-YJRS2i8Q2oA@mail.gmail.com>
 <134957369d2e0abf51f03817f1e4de7cbf21f76e.camel@sipsolutions.net>
 <CACT4Y+aH7LqDUqAyQ7+hkyeZTtkYnMHia73M7=EeAzMYzJ8pQg@mail.gmail.com> <5eef2f1b43c25447ccca2f50f4964fd77a719b08.camel@sipsolutions.net>
In-Reply-To: <5eef2f1b43c25447ccca2f50f4964fd77a719b08.camel@sipsolutions.net>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 27 May 2022 17:46:11 +0200
Message-ID: <CACT4Y+Yv2AGRCLZ=cpxQtkrxz9YKxPGLBcriyFo7FVGoDiyaSQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3] UML: add support for KASAN under x86_64
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: David Gow <davidgow@google.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>, Patricia Alfonso <trishalfonso@google.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, anton.ivanov@cambridgegreys.com, Brendan Higgins <brendanhiggins@google.com>, kasan-dev <kasan-dev@googlegroups.com>, linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, Daniel Latypov <dlatypov@google.com>

On Fri, 27 May 2022 at 16:28, Johannes Berg <johannes@sipsolutions.net> wrote:
> > > > > On Fri, 2022-05-27 at 15:09 +0200, Dmitry Vyukov wrote:
> > > > > > > I did note (this is more for kasan-dev@) that the "freed by" is fairly
> > > > > > > much useless when using kfree_rcu(), it might be worthwhile to annotate
> > > > > > > that somehow, so the stack trace is recorded by kfree_rcu() already,
> > > > > > > rather than just showing the RCU callback used for that.
> [...]
> > Humm... I don't have any explanation based only on this info.
> > Generally call_rcu stacks are memorized and I see the call is still there:
> > https://elixir.bootlin.com/linux/v5.18/source/kernel/rcu/tree.c#L3595
>
> Oh, that's simple then, UML is !SMP && !PREEMPT so it gets TINY_RCU
> instead of TREE_RCU.

Nice!

> Unfortunately, it's not entirely trivial to fix, something like this,
> mostly because of header maze (cannot include kasan.h in rcutiny.h):
>
> diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
> index 5fed476f977f..d84e13f2c384 100644
> --- a/include/linux/rcutiny.h
> +++ b/include/linux/rcutiny.h
> @@ -38,7 +38,7 @@ static inline void synchronize_rcu_expedited(void)
>   */
>  extern void kvfree(const void *addr);
>
> -static inline void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> +static inline void __kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  {
>         if (head) {
>                 call_rcu(head, func);
> @@ -51,6 +51,15 @@ static inline void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>         kvfree((void *) func);
>  }
>
> +#ifdef CONFIG_KASAN_GENERIC
> +void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func);
> +#else
> +static inline void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> +{
> +       __kvfree_call_rcu(head, func);
> +}
> +#endif
> +
>  void rcu_qs(void);
>
>  static inline void rcu_softirq_qs(void)
> diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
> index 340b3f8b090d..aa235f0332ba 100644
> --- a/kernel/rcu/tiny.c
> +++ b/kernel/rcu/tiny.c
> @@ -217,6 +217,18 @@ bool poll_state_synchronize_rcu(unsigned long oldstate)
>  }
>  EXPORT_SYMBOL_GPL(poll_state_synchronize_rcu);
>
> +void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> +{
> +       if (head) {
> +               void *ptr = (void *) head - (unsigned long) func;
> +
> +               kasan_record_aux_stack_noalloc(ptr);
> +       }
> +
> +       __kvfree_call_rcu(head, func);
> +}
> +EXPORT_SYMBOL_GPL(kvfree_call_rcu);
> +
>  void __init rcu_init(void)
>  {
>         open_softirq(RCU_SOFTIRQ, rcu_process_callbacks);
>
>
>
>
> Or I guess I could copy/paste
>
> #ifdef CONFIG_KASAN_GENERIC
> void kasan_record_aux_stack_noalloc(void *ptr);
> #else /* CONFIG_KASAN_GENERIC */
> static inline void kasan_record_aux_stack_noalloc(void *ptr) {}
> #endif /* CONFIG_KASAN_GENERIC */
>
>
> into rcutiny.h, that'd be smaller, and export the symbol ...
>
> johannes
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/5eef2f1b43c25447ccca2f50f4964fd77a719b08.camel%40sipsolutions.net.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

