Return-Path: <linux-kernel-owner+geert=40linux-m68k.org-S1754188AbZCTI22@vger.kernel.org>
In-reply-to: <1237537169.24626.29.camel@twins> (message from Peter Zijlstra on
	Fri, 20 Mar 2009 09:19:29 +0100)
Subject: Re: [patch] fix uml slowness caused by ptrace preemption bug on
 host
References: <E1LkQeU-00020Z-Be@pomaz-ex.szeredi.hu> <1237537169.24626.29.camel@twins>
Message-Id: <E1Lka4M-0002za-FQ@pomaz-ex.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 20 Mar 2009 09:27:10 +0100
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org
Cc: miklos@szeredi.hu, roland@redhat.com, efault@gmx.de, rjw@sisk.pl, jdike@addtoit.com, mingo@elte.hu, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Fri, 20 Mar 2009, Peter Zijlstra wrote:
> On Thu, 2009-03-19 at 23:23 +0100, Miklos Szeredi wrote:
> > 
> > This patch solves this by not scheduling on preempt_enable() after
> > ptrace_stop() has woken up the tracer.
> 
> Nice,.. however did you find this?

Ftrace helped a lot, it's a really cool tool :).  I had to patch it
with this, otherwise the timestamps would be totally off:

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index bd38c5c..557c2dd 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -108,7 +108,7 @@ u64 ring_buffer_time_stamp(int cpu)
 
 	preempt_disable_notrace();
 	/* shift to debug/test normalization and TIME_EXTENTS */
-	time = sched_clock() << DEBUG_SHIFT;
+	time = cpu_clock(cpu) << DEBUG_SHIFT;
 	preempt_enable_no_resched_notrace();
 
 	return time;
