Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Message-ID: <477C134C.3080107@BitWagon.com>
Date: Wed, 02 Jan 2008 14:42:20 -0800
From: John Reiser <jreiser@BitWagon.com>
MIME-Version: 1.0
References: <4773F11D.7060803@BitWagon.com> <477AAFA1.9060807@BitWagon.com>
	<20080102152838.GA5629@c2.user-mode-linux.org>
In-Reply-To: <20080102152838.GA5629@c2.user-mode-linux.org>
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
To: Jeff Dike <jdike@addtoit.com>
Cc: valgrind-developers@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

Jeff Dike responded:
 John Reiser wrote:
>>The web page  http://bitwagon.com/valgrind+uml/index.html
>>now exists with news, history, commentary, scripts, links

> You refer to kmalloc and kfree as keeping object state intact between
> kfree and kmalloc, thus not being semantically the same as malloc and
> free.  However, this is true of kmem_cache_alloc and kmem_cache_free,
> not kmalloc and kfree.
> 
> Object contents are destroyed between kfree and kmalloc.

It looks more complicated to me.

When include/linux/slab.h is in view, then I trace
(where indentation indicates logical call [inline, or physical call]):
  kmalloc   include/linux/slab.h
    __kmalloc   mm/slab.c
      __do_kmalloc  mm/slab.c
        __cache_alloc   mm/slab.c
          __do_cache_alloc   mm/slab.c
            ____cache_alloc   mm/slab.c
              cpu_cache_get   mm/slab.c

When include/linux/slab_def.h is in view, then I trace:
  For a size that is constant at compile time [very often the case],
  then I trace:

    kmalloc   include/linux/slab_def.h
      kmem_cache_alloc   mm/slab.c
        __cache_alloc   mm/slab.c
          <<and continues as in first case above>>

  If the size is non-constant at compile time, then I trace:

    kmalloc   include/linux/slab_def.h
      __kmalloc   mm/slab.c
        <<and continues as in first case above>>

My tracking of kfree is much simpler:
  kfree   mm/slab.c
    __cache_free   mm/slab.c

The net effect is that the slab allocator always calls __cache_alloc,
thus re-using a kfree()d object and its accumulated contents.

The slab allocator is by far the most used case.  slub and slob
have not yet been used during my explorations, as far as I can tell.

> As far as kmem_cache_alloc and kmem_cache_free are concerned, would it
> work to say that they are like malloc and free, except that if there's
> a constructor, it is always called before kmem_cache_alloc returns?

Under DEBUG, then cache_init_objs() in mm/slab.c does not call the ctor
if SLAB_POISON.  Under no-DEBUG, then cache_init_objs() always calls
the ctor.  So here is an exception to the proposed rule, and quite
different *semantics* for DEBUG versus no-DEBUG.  Also, cache_init_objs
is not the allocator, but only the initial condition.

Under DEBUG, then cache_alloc_debugcheck_after() in mm/slab.c calls
the ctor if SLAB_POISON.  Under no-DEBUG, then cache_alloc_debugcheck_after()
is a no-op.  Again, a difference in *semantics* between DEBUG and no-DEBUG.

Altogether: the slab ctor is called once per object; except if DEBUG and
SLAB_POISON, when kfree() is considered to destroy the old object and
kmalloc is considered to create a new object (yet the two objects occupy
identical address space.)  In the case of no-DEBUG slab, then the ctor
is never called as a result of calling kmalloc.

So kmalloc+kfree is distinctly different in semantics from malloc+free,
at least as implemented by slab, the most common case.


Now, in my patches, I CHANGED the semantics of slab __cache_alloc
so that it calls the ctor always, ignoring both no-DEBUG and SLAB_POISON.
If there is a ctor, then this makes kmalloc+kfree closer to malloc+free.
But if there is no ctor, then things are murky again.  Should the result
of kmalloc() be marked as if it were returned from malloc() or not?
[I.e., are the contents undefined or defined?]
At least some clients act that way (under DEBUG and SLAB_POISON),
and in general it would be simpler for memcheck if it were so.
The patch acts as if it *is* so:
        VALGRIND_MALLOCLIKE_BLOCK(objp, size, 0, 0);
In particular, the contents are considered to be undefined.
[Then the ctor, if it exists, defines some or all.]

Obviously this is open for corrections, debate, and better understanding!
I had difficulty understanding what I observed, and still I search ...
The existing patches are the result of trial-and-error to find something
which could survive for a complete session of boot+login+halt while
respecting at least some intent of memcheck.  But probably I missed
an important point or two.  In particular, I'm confused by allocations
which return a "page": either "struct page *", or a "char *" with
an aligned group of char of size PAGE_SIZE in the virtual address space.
Help?

-- 
John Reiser, jreiser@BitWagon.com

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
