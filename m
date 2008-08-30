Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KZO1t-0000f2-NN for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 30 Aug 2008 03:50:06 -0700
Received: from wa-out-1112.google.com ([209.85.146.182])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KZO1q-0002Ot-7d
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 30 Aug 2008 03:50:04 -0700
Received: by wa-out-1112.google.com with SMTP id j5so865378wah.18
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 30 Aug 2008 03:50:01 -0700 (PDT)
Message-ID: <84144f020808300350i7cb2d23aj6d1ffcbeceaf7e9c@mail.gmail.com>
Date: Sat, 30 Aug 2008 13:50:01 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
In-Reply-To: <alpine.DEB.1.00.0808291616560.15543@abydos.NerdBox.Net>
MIME-Version: 1.0
Content-Disposition: inline
References: <alpine.DEB.1.00.0808281139420.15543@abydos.NerdBox.Net>
	<alpine.DEB.1.00.0808291616560.15543@abydos.NerdBox.Net>
Subject: Re: [uml-devel] [PATCH 5/6] slab: Annotate slab
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Steve VanDeBogart <vandebo-lkml@nerdbox.net>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@us.ibm.com>, Ingo Molnar <mingo@elte.hu>, dkegel@google.com, jiayingz@google.com

Hi Steve,

On Sat, Aug 30, 2008 at 2:17 AM, Steve VanDeBogart
<vandebo-lkml@nerdbox.net> wrote:
> Valgrind annotations for the slab allocator:  Malloc-like and free-like
> for cache_alloc and free.  Telling Valgrind a region is free-like clears
> all the valid bits, so slabs with constructors need different treatment;
> tell Valgrind about slab objects when first constructed and free them
> when the slab is destroyed.

OK, I'm biased (I'm one of the kmemcheck developers) but these hooks
to SLAB are too ugly to live with. My preferred solution is that you
reuse the kmemcheck annotations
kmemcheck_slab_alloc()/kmemcheck_slab_free() we have:

http://git.kernel.org/?p=linux/kernel/git/x86/linux-2.6-tip.git;a=commitdiff;h=30532cb3c49a2a9fed94127aab26003c52398a51

Maybe making valgrind code a "UML port" (plus some more) of kmemcheck.

> Signed-off-by: Steve VanDeBogart <vandebo-lkml@nerdbox.net>
> ---
>
> Index: linux-2.6.27-rc5/mm/slab.c
> ===================================================================
> --- linux-2.6.27-rc5.orig/mm/slab.c     2008-08-29 14:24:25.000000000 -0700
> +++ linux-2.6.27-rc5/mm/slab.c  2008-08-29 14:24:42.000000000 -0700
> @@ -111,6 +111,7 @@
>  #include       <linux/rtmutex.h>
>  #include       <linux/reciprocal_div.h>
>  #include       <linux/debugobjects.h>
> +#include       <linux/memcheck.h>
>
>  #include       <asm/cacheflush.h>
>  #include       <asm/tlbflush.h>
> @@ -1906,6 +1907,8 @@
>        int i;
>        for (i = 0; i < cachep->num; i++) {
>                void *objp = index_to_obj(cachep, slabp, i);
> +               if (cachep->ctor)
> +                       VALGRIND_FREELIKE_BLOCK(objp, 0);
>
>                if (cachep->flags & SLAB_POISON) {
>  #ifdef CONFIG_DEBUG_PAGEALLOC
> @@ -1932,6 +1935,15 @@
>  #else
>  static void slab_destroy_debugcheck(struct kmem_cache *cachep, struct slab
> *slabp)
>  {
> +#ifdef CONFIG_VALGRIND_SUPPORT
> +       int i;
> +       if (cachep->ctor) {
> +               for (i = 0; i < cachep->num; i++) {
> +                       void *objp = index_to_obj(cachep, slabp, i);
> +                       VALGRIND_FREELIKE_BLOCK(objp, 0);
> +               }
> +       }
> +#endif
>  }
>  #endif
>
> @@ -2635,6 +2647,9 @@
>
>        for (i = 0; i < cachep->num; i++) {
>                void *objp = index_to_obj(cachep, slabp, i);
> +               if (cachep->ctor)
> +                       VALGRIND_MALLOCLIKE_BLOCK(objp, cachep->buffer_size,
> +                                                       0, 0);
>  #if DEBUG
>                /* need to poison the objs? */
>                if (cachep->flags & SLAB_POISON)
> @@ -3466,6 +3481,8 @@
>        objp = cache_alloc_debugcheck_after(cachep, flags, objp, caller);
>        prefetchw(objp);
>
> +       if (!cachep->ctor)
> +               VALGRIND_MALLOCLIKE_BLOCK(objp, cachep->buffer_size, 0, 0);
>        if (unlikely((flags & __GFP_ZERO) && objp))
>                memset(objp, 0, obj_size(cachep));
>
> @@ -3578,6 +3595,9 @@
>  {
>        struct array_cache *ac = cpu_cache_get(cachep);
>
> +       if (!cachep->ctor)
> +               VALGRIND_FREELIKE_BLOCK(objp, 0);
> +
>        check_irq_off();
>        objp = cache_free_debugcheck(cachep, objp,
> __builtin_return_address(0));

I'm not sure why you want to treat caches with constructor
differently. Sure, the memory regions *are* initialized but from
programmer's point of view you're not supposed to be touching the
memory unless you got it from kmalloc() or kmem_cache_alloc(). Same
goes for kfree() and kmem_cache_free() -- no touchy touchy after you
pass a pointer to either of the functions (unless you're RCU, of
course).

                           Pekka

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
