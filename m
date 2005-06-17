Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dj6hH-0007tS-2r	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Jun 2005 19:35:07 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1Dj6hC-0001ML-Uq	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Jun 2005 19:35:07 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Recent patches of note
Message-ID: <20050617003516.GA12344@ccure.user-mode-linux.org>
References: <20050616160728.GA6040@ccure.user-mode-linux.org>
	<20050616174735.GB7532@ccure.user-mode-linux.org>
	<42B1BD11.7050806@fujitsu-siemens.com>
	<200506162009.35357.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506162009.35357.blaisorblade@yahoo.it>
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
Date: Thu, 16 Jun 2005 20:35:16 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

On Thu, Jun 16, 2005 at 08:09:34PM +0200, Blaisorblade wrote:
> +struct task_struct;
> +extern void arch_switch(struct task_struct *from, struct task_struct *to);

Is the task_struct; needed, considering that there is get_task returning
one a few lines higher?

> +	/* XXX: This is bogus, it's already done in local_irq_enable. Or does
> +	 * ordering matters? */

No, my signal handler initialization is confused and redundant in places.
Just fix that and resend.

> Fix the do_fork calling convention: normal arch pass the regs and the new sp
> value to do_fork instead of NULL.
> 
> Currently the arch-independent code ignores these values, while the UML code   
> (actually it's copy_thread) gets the right values by itself.
> 
> With this patch, things are fixed up.
>     
> Low-priority.

But long-overdue.  This one is applied.



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
