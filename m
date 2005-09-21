Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EIBVk-0005TL-5a	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Sep 2005 13:48:12 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)	id 1EIBVj-00029i-Vu
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Sep 2005 13:48:12 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: Re: [uml-devel] Re: [PATCH 07/10] uml: avoid fixing faults while
 atomic
Message-Id: <20050921134724.52603016.akpm@osdl.org>
In-Reply-To: <200509212222.50653.blaisorblade@yahoo.it>
References: <200509211923.21861.blaisorblade@yahoo.it>
	<20050921172908.10219.57644.stgit@zion.home.lan>
	<20050921124957.437cf069.akpm@osdl.org>
	<200509212222.50653.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Date: Wed, 21 Sep 2005 13:47:24 -0700
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, torvalds@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org

Blaisorblade <blaisorblade@yahoo.it> wrote:
>
> On Wednesday 21 September 2005 21:49, Andrew Morton wrote:
> > "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it> wrote:
> > > From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> 
> > The in_atomic() test in x86's do_page_fault() is in fact a message passed
> > into it from filemap.c's kmap_atomic().
> Ok, this can be ok, but:
> > It has accidental side-effects, 
> > such as making copy_to_user() fail if inside spinlocks when
> > CONFIG_PREEMPT=y.
> Sorry, but should it ever succeed inside spinlocks? I mean, should it ever 
> call down() inside spinlocks? (We never do down_trylock, and ever if we did 
> the x86 trick, that wouldn't make the whole thing safe at all - they still 
> take the spinlock and potentially sleep. And it's legal only if no spinlock 
> is held).

Not sure what you're asking here.

copy_to/from_user() will fail inside spinlock if CONFIG_PREMPT=y and if the
copy happens to cause a fault.  Otherwise it will succeed inside spinlock,
and it won't spew a sleeping-while-atomic warning, because that uses
in_atomic() too.  It might deadlock if we schedule away and try to retake
the same lock.

> Even if spinlocks don't always trigger in_atomic() - which means that we'd 
> need to have a better fix for this.

The patch you have will correctly cause copy_*_user()->pagefault to fail
the copy if the caller has run inc_preempt_count().  It will not cause
copy_*_user()->pagefault to fail inside spinlocks unless UML does
inc_preempt_count() in its spinlock implementation.

> (Btw, I took the above reasoning from something said, as an aside, on LWN.net 
> kernel page, about the FUTEX deadlock on mm->mmap_sem of ~ 2.6.8 - yes, it 
> wasn't the full truth, but not totally dumb).
> 
> > So I think this change is only needed if UML implements kmap_atomic, as in
> > arch/i386/mm/highmem.c, which it surely does not do?
> NACK, see above.

Yup, the patch is needed for the futex code, and for general correct
implementation of inc_preempt_count()'s intended effect.



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
