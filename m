Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <onestero@redhat.com>) id 1LkfNv-0005Lv-8o
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Mar 2009 14:07:43 +0000
Received: from mx2.redhat.com ([66.187.237.31])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LkfNt-0005Fz-3C for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Mar 2009 14:07:43 +0000
Date: Fri, 20 Mar 2009 15:04:09 +0100
From: Oleg Nesterov <oleg@redhat.com>
Message-ID: <20090320140409.GB20965@redhat.com>
References: <E1LkQeU-00020Z-Be@pomaz-ex.szeredi.hu>
	<20090319233311.8B26BFC381@magilla.sf.frob.com>
	<E1LkZjf-0002vu-84@pomaz-ex.szeredi.hu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1LkZjf-0002vu-84@pomaz-ex.szeredi.hu>
Subject: Re: [uml-devel] [patch] fix uml slowness caused by ptrace
	preemption bug on	host
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: user-mode-linux-devel@lists.sourceforge.net, peterz@infradead.org, jdike@addtoit.com, efault@gmx.de, linux-kernel@vger.kernel.org, rjw@sisk.pl, mingo@elte.hu, roland@redhat.com

On 03/20, Miklos Szeredi wrote:
>
> I'm no scheduler expert either.

neither me ;)

> --- linux.git.orig/kernel/sched.c	2009-03-18 12:53:47.000000000 +0100
> +++ linux.git/kernel/sched.c	2009-03-20 08:58:13.000000000 +0100
> @@ -4629,7 +4629,8 @@ asmlinkage void __sched preempt_schedule
>  	 * If there is a non-zero preempt_count or interrupts are disabled,
>  	 * we do not want to preempt the current task. Just return..
>  	 */
> -	if (likely(ti->preempt_count || irqs_disabled()))
> +	if (likely(ti->preempt_count || irqs_disabled() ||
> +		   current->state != TASK_RUNNING))

But this was specially designed to allow to preempt !TASK_RUNNING tasks,
note the "if (prev->state && !(preempt_count() & PREEMPT_ACTIVE))" in
schedule().

Perhaps "|| current->state == TASK_TRACED" makes more sense, TASK_TRACED
is special because we know we are going to schedule really soon. But I think
your previous patch is better, imho we should change preempt_schedule() to
fix the very specific problem with ptrace_notify().

Oleg.


------------------------------------------------------------------------------
Apps built with the Adobe(R) Flex(R) framework and Flex Builder(TM) are
powering Web 2.0 with engaging, cross-platform capabilities. Quickly and
easily build your RIAs with Flex Builder, the Eclipse(TM)based development
software that enables intelligent coding and step-through debugging.
Download the free 60 day trial. http://p.sf.net/sfu/www-adobe-com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

