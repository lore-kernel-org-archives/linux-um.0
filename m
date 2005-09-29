Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EL3yu-0007qO-0e	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Sep 2005 12:22:12 -0700
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EL3yp-0000jM-6q
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Sep 2005 12:22:11 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] a question about sigsetjmp() in copy_from/to_user()
References: <3524bf1f050927070645b999bd@mail.gmail.com>
	<20050928145009.GA11610@ccure.user-mode-linux.org>
	<3524bf1f0509281225180173ae@mail.gmail.com>
In-Reply-To: <3524bf1f0509281225180173ae@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200509291409.28067.blaisorblade@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 29 Sep 2005 14:09:27 +0200
To: user-mode-linux-devel@lists.sourceforge.net, Young Koh <young.koh@gmail.com>
Cc: Jeff Dike <jdike@addtoit.com>

On Wednesday 28 September 2005 21:25, Young Koh wrote:
> hi,
>
> On 9/28/05, Jeff Dike <jdike@addtoit.com> wrote:
> > On Wed, Sep 28, 2005 at 09:47:41AM -0400, Young Koh wrote:

> > No, just that page is bad.
Again, that page is not bad. There is no page yet for this address, and the 
host won't allocate one for now.
> > Another page could have been dirtied and thus 
> > allocated on the host, and it would be usable.  So, it's not a fatal
> > problem.
Ok, this makes a bit of sense, even if IMHO it doesn't work, I now see your 
point (but I still insist with what said above).

However, even a dirtied page could be "bad", if it has been swapped. If we're 
getting a SIGBUS, it meant that it didn't succeed in freeing any memory.

And, frankly, unless the UML ram file is kept on ramfs (which is RAM-only), it 
can be swapped (both for disk-based filesystem and for tmpfs).
So, I don't think what you suggest could work.
> then, if just that page is bad, shouldn't UML kernel wait until
> another page is usable (or force another page to be swapped out)
We're talking about the host, and if the host is on OOM, you can't help it. 
The best you can do is to reclaim cache memory. But that must be done when the 
host is starting to swap, not at SIGBUS time.

> and 
> allocate the free page? and proceed normal? i may be still confused.

Jeff's point is that once we have dirtied a page, and the host hasn't yet 
swapped it, it could be in memory - and accessing it would work. Having 
dirtied it means we allocated it with (say) kmalloc and then dirtied it.

> Ok, my thought/idea/suggestion is that what if UML uses a TLB-like
> table before it does the address translation?

> i mean, once there is a 
> valid mapping, UML inserts the address mapping(or page mapping) into a
> software TLB. after that, for that userspace address, UML can search
> the software TLB table and use the mapping without calling sigsetjmp()
> and walking through page tables.

> it seems that sigsetjmp() has 
> relatively large overhead, we could reduce some overhead by not
> calling it.

How do you measure it? I'm curious myself - I know there's the possibility to 
use gprof, but I've never used that myself.

Surely the "sig" thing is heavy (some syscalls like sigprocmask() for 
blocking/unblocking signals). Or better, it's the only heavy thing - the rest 
consists only of saving a couple of registers (6, IIRC) in memory, there's no 
interest in optimizing it away (I assume).

But that part will go away - there's a "softints" patch for this (i.e. moving 
the blocking/unblocking to userspace - the signal handler notices the signal 
is stopped and queues the handling via userspace mechanisms). It's at:

http://user-mode-linux.sourceforge.net/patches.html

> but surely the problem is the mapping can go corrupted. 
> for that, UML may invalidate a TLB entry if the corresponding page is
> swapped out or any change is made. what do you think?

In short, it's a really interesting idea.

The kernel (arch-independent) infrastructure for this exists, for managing the 
real TLBs. You already need to invalidate TLB entries when you swap a page and 
such. Reading Documentation/cachetlb.txt is definitely worth the time spent.

And actually, currently that is used to update the host mappings.

Using TLBs to save the page table walk is interesting, especially since that 
would avoid taking a spinlock on SMP (the current implementation of 
maybe_map() doesn't, but it should), and more important because the TLBs would 
likely be hotter than all the page tables, so it would probably fit in the L2 
cache (while, to walk page tables, we're likely going to have a L2 miss - 
they're too big). Hotter means "more likely to be accessed, and thus more 
worth to keep in cache". The cache usage discussion in Reiser4 whitepaper 
(www.namesys.com) is really enlightening on this point.

Don't know if we can optimize the locking on the TLBs, though - we could use 
maybe atomic ops, or have per-processor TLBs (which is the way it's 
implemented in hardware - you get IPIs on flush, though, and on i386 
atomic_read and atomic_set have no additional cost over non-atomic 
counterparts. So maybe shared TLBs are ok - they'd need to be tagged, 
however).

I've not yet thought about an efficient data structure - an array means that 
invalidation checks each entry, and I'd like to avoid that. The other way is 
to empty the TLB on flushing a single entry.

The only problem is when there is a fault on the kernelspace address.
However, we may implement some checking, if setjmp() is still costly:
only kernelspace addresses upper than TASK_SIZE are valid (or something of 
this sort).
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
