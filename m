Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Atzhe-0007xQ-Op
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 19 Feb 2004 17:43:42 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1Atzc4-0005ZR-Kg
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 19 Feb 2004 17:37:57 -0800
Message-Id: <200402200206.i1K265QH004886@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Re: Diagnosed and repeatable kernel mode panic in schedule() for 2.6! 
In-Reply-To: Your message of "Thu, 19 Feb 2004 20:01:26 +0100."
             <200402192001.26102.blaisorblade_spam@yahoo.it> 
References: <200402151911.11890.blaisorblade_spam@yahoo.it> <200402162025.24853.blaisorblade_spam@yahoo.it> <200402170446.i1H4kUsq026113@ccure.user-mode-linux.org>  <200402192001.26102.blaisorblade_spam@yahoo.it> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 19 Feb 2004 21:06:05 -0500
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Ingo Molnar <mingo@elte.hu>

blaisorblade_spam@yahoo.it said:
> By the way, would you check if this is needed in the 2.4 kernel, too?
> I've  checked the 2.4.24-1 uml patch and it seems to miss that line
> (and your  reason seem to apply to 2.4 too). 

Yup, I think so too.

> What is more strange is that the panic  happens deterministically, and
> in the same situation (same root fs and same  kernel) I get it at the
> same addresses! Since what happens seem to change  with each single
> kernel, but is easily repeatable, I would say that it is not  a race
> condition, but something with a crazy pointer outside of the core
> code.

I'm seeing two things, which don't happen deterministically :
	an exited process scheduling to itself, causing the exit.c BUG - I
don't see what prevents a TASK_ZOMBIE process from being schedulable offhand.
It doesn't seem to be dequeued from any runqueues as a result of calling exit().

	a segfault in schedule() caused by there being not bits set in the
queue bitmap (except for bit 140 which I guess is there to prevent ffs from
running into nowhereland).  And bit 140 doesn't refer to a valid queue, so
the task pulled of it is bogus.

> So it seems that both active.queue[140] and  active.queue.nr_active
> are corrupted.

Repeating the above, it looks like #140 isn't supposed to be valid.

> However, even in expired.queue[125] there is a problem, since in the
> list  there is one list_head (the one at 0xa08e40a0) whose next and
> prev pointers  point to itself (i.e. that is an empty list); however
> this "empty list" can  be reached by expired.queue[125]. 

Yup, interesting.  What I would do is stick some code in that looks for
this condition (and if you can look for it being created, that's even better).

I was looking for something that seemed like an invariant being violated,
and came up empty.  This looks like a good one, though.  If we can figure
out what's causing it, that gets us one step closer to the bug.

				Jeff



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
