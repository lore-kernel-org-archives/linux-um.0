Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMq8K-0007Hb-1K for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Mar 2006 09:31:32 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FMq8I-00021U-Fa
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Mar 2006 09:31:32 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Re: TLS support - status - need for re-testing
Message-ID: <20060324173247.GD5400@ccure.user-mode-linux.org>
References: <200603230317.48384.blaisorblade@yahoo.it>
	<200603240044.06196.blaisorblade@yahoo.it>
	<20060324041724.GB8750@ccure.user-mode-linux.org>
	<200603241243.34687.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603241243.34687.blaisorblade@yahoo.it>
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
Date: Fri, 24 Mar 2006 12:32:47 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Antoine Martin <antoine@nagafix.co.uk>

On Fri, Mar 24, 2006 at 12:43:33PM +0100, Blaisorblade wrote:
> We discussed this time ago, and read the description of the patch:
> 
> # Also, as suggested by Jeff, remove a redundant enabling of SIGVTALRM,
> # comprised in the subsequent local_irq_enable(). I'm just a bit dubious if
> # ordering matters there...

Oops, nevermind.

> Note this pre-dates soft interrupts, however.

Shouldn't matter.

> > global-ldt-sem - We should be using mutexes now, not semaphores
> 
> That's your patch, but below I drop this.

My patch predates mutexes.

But you still use semaphores, and that should be updated.

> > undo-global-ldt-sem - what's so horrible about the global?  it won't
> > be highly contended, so making a single mutex saves memory from every
> > ldt.
> 
> For memory: 500 existing processes (a huge number in practice) * 20 byte (and
> I think a semaphore is smaller) = 10 Kbyte. We waste more for the kernel 
> stack of 1 thread.
> 
> For reason: the compilation problem can be avoided differently (and the 
> subsequent patch also merges duplicated code).
> 
> I didn't like global_ldt_sem because I felt it unclean; if done for memory 
> usage it's another story, but still we need to check this creates no locking 
> problem (almost surely no, but I want to look at the code well).

It's simpler.  A single global lock is simpler than a lock in every 
datastructure.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
