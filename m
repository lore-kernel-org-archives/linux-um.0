Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EIY5g-0003PY-3Q	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Sep 2005 13:54:48 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)	id 1EIY5e-00079C-Th
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Sep 2005 13:54:48 -0700
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [uml-devel] Re: [PATCH 07/10] uml: avoid fixing faults while
 atomic
In-Reply-To: <200509222137.41412.blaisorblade@yahoo.it>
Message-ID: <Pine.LNX.4.58.0509221341230.2553@g5.osdl.org>
References: <200509211923.21861.blaisorblade@yahoo.it>
	<20050921134724.52603016.akpm@osdl.org>
	<200509222137.41412.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Thu, 22 Sep 2005 13:54:24 -0700 (PDT)
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>, jdike@addtoit.com, linux-kernel@vger.kernel.org



On Thu, 22 Sep 2005, Blaisorblade wrote:
>
> Exactly - the point is: is it legal to call copy_from_user() while holding a 
> spinlock (which is my original question)? Or should copy_from_user try to 
> satisfy the fault, instead of seeing in_atomic() or something similar and 
> fail?

It is not legal to call copy_to/from_user() under a spinlock in general.

But what _is_ legal to do is something slightly more complex, ie

	spin_lock(...)
	inc_preempt_count();
	ret = __copy_from_user_inatomic(..)
	dec_preempt_count();
	spin_unlock();

but you have to realize that the copy-from-user will fail if the target is 
swapped out (so the code that does things like this has to look at the 
return value, and if the copy didn't copy anything it needs to release the 
locks and do it all over again without the atomic thing).

We don't do it very much, because it gets more complicated and it hasn't
historically been legal, but it could in theory be very useful if you hold
a lock and want to avoid releasing and re-taking it just to do a user
access.

Right now the only case where that happens is the futex code, and maybe 
that's a very special case. But maybe it isn't. 

			Linus


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
