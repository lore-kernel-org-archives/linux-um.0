Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DjLsO-0008OY-Ee	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Jun 2005 11:47:36 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DjLsJ-0002c7-PJ	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Jun 2005 11:47:36 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Recent patches of note
References: <20050616160728.GA6040@ccure.user-mode-linux.org>
	<200506162009.35357.blaisorblade@yahoo.it>
	<20050617003516.GA12344@ccure.user-mode-linux.org>
In-Reply-To: <20050617003516.GA12344@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506172040.20564.blaisorblade@yahoo.it>
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
Date: Fri, 17 Jun 2005 20:40:20 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

On Friday 17 June 2005 02:35, Jeff Dike wrote:
> On Thu, Jun 16, 2005 at 08:09:34PM +0200, Blaisorblade wrote:
> > +struct task_struct;
> > +extern void arch_switch(struct task_struct *from, struct task_struct
> > *to);

> Is the task_struct; needed, considering that there is get_task returning
> one a few lines higher?
I've not checked the rest of the header; if it compiles without the line it's 
ok.
> > +	/* XXX: This is bogus, it's already done in local_irq_enable. Or does
> > +	 * ordering matters? */
>
> No, my signal handler initialization is confused and redundant in places.
> Just fix that and resend.
>
> > Fix the do_fork calling convention: normal arch pass the regs and the new
> > sp value to do_fork instead of NULL.
> >
> > Currently the arch-independent code ignores these values, while the UML
> > code (actually it's copy_thread) gets the right values by itself.
> >
> > With this patch, things are fixed up.
> >
> > Low-priority.
>
> But long-overdue.  This one is applied.
Please retest in all configurations, the first version did an innocent change 
to kernel_thread() which killed TT mode. And I did a change to switch_to(), 
replacing prev_sched with current->thread.prev_sched (or something like that) 
after the last testing (if I understood things properly, it won't change 
anything, but give it a bit of testing; it should fail loudly if I did 
something wrong).
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
