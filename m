Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-list2-new-b.sourceforge.net ([10.3.1.94]
	helo=sc8-sf-list2-new.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J9WQX-0003oL-KC for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 31 Dec 2007 18:00:21 -0800
Date: Mon, 31 Dec 2007 21:00:09 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080101020009.GB19579@c2.user-mode-linux.org>
References: <4773F11D.7060803@BitWagon.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4773F11D.7060803@BitWagon.com>
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

On Thu, Dec 27, 2007 at 10:38:21AM -0800, John Reiser wrote:
> Patches have been developed which enable UserModeLinux for i686 to
> run under the memcheck tool of Valgrind on i686.  Thus it is possible
> to check dynamically the memory accesses made by a running Linux kernel
> against memcheck's model of allowed behavior.  This work was supported
> by Google Inc.
> 
> The goods:

Nice!

Did you find anything needing fixing besides the ubd and random
drivers reading uninitialized stuff and the random bytes that UML uses
to communicate with itself being uninitialized?

I did a quick scan of the UML patch, and didn't see any unexpected
fixes there.

> On the UML side, there is a significant technical issue: the semantics
> of kmalloc+kfree do not match the semantics of malloc+free.  The kernel
> slab allocator caches and re-issues identified objects, which accumulate
> state and retain it throughout execution, including from kfree to kmalloc.
> In contrast, a region that is passed to free() loses both its contents
> and its identity.  Also, size is an important parameter to malloc,
> but is implicit to kmalloc.  The initial patches finesse these issues
> (for instance: by supplying the size as trailing parameter to kmalloc,
> and by noticing that SLAB_POISON ==> free()), but there will be
> significant discussion and work in resolving the differences.

Any problem with supporting these sorts of allocation models in
valgrind?  Not all the world is malloc and free (although maybe 99%
is).

Can we pass the allocation size through a valgrind annotation rather
than add the parameter to kmem_cache_alloc?  

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
