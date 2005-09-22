Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EIXDa-0000eJ-Jn	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Sep 2005 12:58:54 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)	id 1EIXDa-0004qp-CU
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Sep 2005 12:58:54 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: Re: [uml-devel] Re: [PATCH 07/10] uml: avoid fixing faults while
 atomic
Message-Id: <20050922125801.1b7894d2.akpm@osdl.org>
In-Reply-To: <200509222137.41412.blaisorblade@yahoo.it>
References: <200509211923.21861.blaisorblade@yahoo.it>
	<200509212222.50653.blaisorblade@yahoo.it>
	<20050921134724.52603016.akpm@osdl.org>
	<200509222137.41412.blaisorblade@yahoo.it>
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
Date: Thu, 22 Sep 2005 12:58:01 -0700
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, torvalds@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org

Blaisorblade <blaisorblade@yahoo.it> wrote:
>
> On Wednesday 21 September 2005 22:47, Andrew Morton wrote:
> > Blaisorblade <blaisorblade@yahoo.it> wrote:
> > > On Wednesday 21 September 2005 21:49, Andrew Morton wrote:
> > > > "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it> wrote:
> > > > > From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> 
> > > > It has accidental side-effects,
> > > > such as making copy_to_user() fail if inside spinlocks when
> > > > CONFIG_PREEMPT=y.
> 
> > > Sorry, but should it ever succeed inside spinlocks? I mean, should it
> > > ever call down() inside spinlocks? (We never do down_trylock, and ever if
> > > we did the x86 trick, that wouldn't make the whole thing safe at all -
> > > they still take the spinlock and potentially sleep. And it's legal only
> > > if no spinlock is held).
> 
> > Not sure what you're asking here.
> 
> > copy_to/from_user() will fail inside spinlock if CONFIG_PREMPT=y and if the
> > copy happens to cause a fault.
> 
> > Otherwise it will succeed inside spinlock, 
> > and it won't spew a sleeping-while-atomic warning, because that uses
> > in_atomic() too.
> 
> > It might deadlock if we schedule away and try to retake 
> > the same lock.
> Exactly - the point is: is it legal to call copy_from_user() while holding a 
> spinlock (which is my original question)? Or should copy_from_user try to 
> satisfy the fault, instead of seeing in_atomic() or something similar and 
> fail?

No, it is not legal to call copy_*_user() while holding a spinlock.

If CONFIG_PREEMPT=n, do_page_fault() has no way of knowing that the caller
holds a spinlock.



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
