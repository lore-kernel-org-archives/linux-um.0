Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Date: Thu, 3 Jan 2008 00:18:57 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080103051857.GA12453@c2.user-mode-linux.org>
References: <4773F11D.7060803@BitWagon.com> <477AAFA1.9060807@BitWagon.com>
	<20080102152838.GA5629@c2.user-mode-linux.org>
	<477C134C.3080107@BitWagon.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <477C134C.3080107@BitWagon.com>
Subject: Re: [uml-devel] running UserModeLinux under Valgrind(memcheck)
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
To: John Reiser <jreiser@BitWagon.com>
Cc: valgrind-developers@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

On Wed, Jan 02, 2008 at 02:42:20PM -0800, John Reiser wrote:
> It looks more complicated to me.
> 
> When include/linux/slab.h is in view, then I trace
> (where indentation indicates logical call [inline, or physical call]):
>   kmalloc   include/linux/slab.h
>     __kmalloc   mm/slab.c
>       __do_kmalloc  mm/slab.c
>         __cache_alloc   mm/slab.c
>           __do_cache_alloc   mm/slab.c
>             ____cache_alloc   mm/slab.c
>               cpu_cache_get   mm/slab.c

You're paying way too much attention to the implementation.

The rules are simple:
	1 - kmalloc and kfree and just like malloc and free - an object's
contents are destroyed between kfree and kmalloc
	2 - kmem_cache_alloc and kmem_cache_free are just like malloc and
free, except that an object may come out of kmem_cache_alloc partially
initialized

There is another requirement on kmem_cache_free - that an object be
passed in in the same initialization state as the constructor would
create.  You can interpret this as state being preserved between
kmem_cache_free and kmem_cache_alloc, which is how it is actually
implemented, or as the constructor always being called before
kmem_cache_alloc returns.  The second makes it look more like malloc
and free.

> When include/linux/slab_def.h is in view, then I trace:
>   For a size that is constant at compile time [very often the case],
>   then I trace:
> 
>     kmalloc   include/linux/slab_def.h
>       kmem_cache_alloc   mm/slab.c
>         __cache_alloc   mm/slab.c
>           <<and continues as in first case above>>

Yes, kmalloc implements its size buckets as kmem_cache_alloc slabs.
So what?  If you look at /proc/slabinfo, the size-n slabs you see
belong to kmalloc.  But that's an implementation detail that has
nothing to do with the contract you make when calling kmalloc.

> The slab allocator is by far the most used case.  slub and slob
> have not yet been used during my explorations, as far as I can tell.

Right now, it's configurable, and the default configuration uses slab.

> Under DEBUG, then cache_init_objs() in mm/slab.c does not call the ctor
> if SLAB_POISON.  Under no-DEBUG, then cache_init_objs() always calls
> the ctor.  So here is an exception to the proposed rule, and quite
> different *semantics* for DEBUG versus no-DEBUG.  Also, cache_init_objs
> is not the allocator, but only the initial condition.

No, there is no semantic difference here, only a difference in when
the objects are constructed depending on slab poisoning.  When
poisoning is in effect, the objects are constructed as late as
possible.  When it's not, they are contructed earlier.

> Under DEBUG, then cache_alloc_debugcheck_after() in mm/slab.c calls
> the ctor if SLAB_POISON.  Under no-DEBUG, then cache_alloc_debugcheck_after()
> is a no-op.  Again, a difference in *semantics* between DEBUG and
> no-DEBUG.

No, these two supposed semantics differences combine to make no
semantic difference.

> Altogether: the slab ctor is called once per object; except if DEBUG and
> SLAB_POISON, when kfree() is considered to destroy the old object and
> kmalloc is considered to create a new object (yet the two objects occupy
> identical address space.)  In the case of no-DEBUG slab, then the ctor
> is never called as a result of calling kmalloc.

The kmalloc slabs have no constructor, so of course no constructor is
called as a result of calling kmalloc.

> So kmalloc+kfree is distinctly different in semantics from malloc+free,
> at least as implemented by slab, the most common case.

No, they are identical.

> Now, in my patches, I CHANGED the semantics of slab __cache_alloc

__cache_alloc is an implementation detail - you don't describe it to
valgrind any more that you would describe some internal malloc
function.  You need to describe kmalloc/kfree and
kmem_cache_alloc/kmem_cache_free, which are both fairly close
(kmalloc/kfree being identical) to malloc/free.

> so that it calls the ctor always, ignoring both no-DEBUG and SLAB_POISON.
> If there is a ctor, then this makes kmalloc+kfree closer to malloc+free.
> But if there is no ctor, then things are murky again.  Should the result
> of kmalloc() be marked as if it were returned from malloc() or not?
> [I.e., are the contents undefined or defined?]

Undefined.

> In particular, I'm confused by allocations
> which return a "page": either "struct page *", or a "char *" with
> an aligned group of char of size PAGE_SIZE in the virtual address space.
> Help?

Examples?  I don't know what exactly you're referring to, nor what the
problem is.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
