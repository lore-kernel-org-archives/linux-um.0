Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EKjEn-0003JO-HI	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Sep 2005 14:13:13 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EKjEh-00082Q-9W
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Sep 2005 14:13:13 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Clearing kmalloc_ok during shutdown is broken -
	malloc will clear our data.
Message-ID: <20050928201243.GA13636@ccure.user-mode-linux.org>
References: <200509281346.23592.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509281346.23592.blaisorblade@yahoo.it>
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
Date: Wed, 28 Sep 2005 16:12:43 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, Sep 28, 2005 at 01:46:15PM +0200, Blaisorblade wrote:
> And I am wondering about whether the recent "eactivate_all_fds failed, errno = 
> 9" 

I found this one, although I didn't notice the missing 'd'.  It turns out that
close_chan closes file descriptors, but never freed the associated IRQs.

> But still, Jeff, how can we expect that malloc won't stomp over all our data 
> which we preallocated with kmalloc and such?

Because I leave a decent amount of room between the brk and the start of 
kmalloc-able memory (which is free_pages-d during boot).  It's a couple meg,
I think.  No guarantees, of course, but there isn't a lot of mallocing
happening.

> There's no single mention of that in your original changelog, and this is 
> untrivial, so I can assume you didn't realize this issue.
> 
> The git commit is 026549d28469f7d4ca7e5a4707f0d2dc4f2c164c.
> 
> On the other side, could you explain why you don't like kmalloc in first 
> place? It surely works.

I'm not sure - let me think about it.  But I fixed that for a reason - it
was causing a crash somehow, I just don't remember the details.

> The real solution for this warning is to replace um_kmalloc with malloc(), and 
> set, during shutdown, kmalloc_only_atomic - which would switch 
> __wrap_malloc() from um_kmalloc to um_kmalloc_atomic.

Yeah, that's userspace code, so it should probably just use malloc.

> Or better yet, simply test in_atomic() and irqs_disabled() to choose between 
> the atomic and normal versions.

I don't really like testing in_atomic() because you should generally know
what context you're running in.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
