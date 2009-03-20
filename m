Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mingo@elte.hu>) id 1Lka83-0000X0-Jz
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Mar 2009 08:30:59 +0000
Received: from mx3.mail.elte.hu ([157.181.1.138])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Lka81-000521-IJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Mar 2009 08:30:59 +0000
Date: Fri, 20 Mar 2009 09:30:49 +0100
From: Ingo Molnar <mingo@elte.hu>
Message-ID: <20090320083049.GA29471@elte.hu>
References: <E1LkQeU-00020Z-Be@pomaz-ex.szeredi.hu>
	<1237537169.24626.29.camel@twins>
	<E1Lka4M-0002za-FQ@pomaz-ex.szeredi.hu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1Lka4M-0002za-FQ@pomaz-ex.szeredi.hu>
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
Cc: user-mode-linux-devel@lists.sourceforge.net, peterz@infradead.org, jdike@addtoit.com, efault@gmx.de, linux-kernel@vger.kernel.org, rjw@sisk.pl, roland@redhat.com


* Miklos Szeredi <miklos@szeredi.hu> wrote:

> On Fri, 20 Mar 2009, Peter Zijlstra wrote:
> > On Thu, 2009-03-19 at 23:23 +0100, Miklos Szeredi wrote:
> > > 
> > > This patch solves this by not scheduling on preempt_enable() after
> > > ptrace_stop() has woken up the tracer.
> > 
> > Nice,.. however did you find this?
> 
> Ftrace helped a lot, it's a really cool tool :).  I had to patch it
> with this, otherwise the timestamps would be totally off:
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index bd38c5c..557c2dd 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -108,7 +108,7 @@ u64 ring_buffer_time_stamp(int cpu)
>  
>  	preempt_disable_notrace();
>  	/* shift to debug/test normalization and TIME_EXTENTS */
> -	time = sched_clock() << DEBUG_SHIFT;
> +	time = cpu_clock(cpu) << DEBUG_SHIFT;
>  	preempt_enable_no_resched_notrace();

Btw., based on your earlier report, the same is now possible in the 
latest tracing tree via:

   echo 1 > /debug/tracing/options/global_clock

	Ingo

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

