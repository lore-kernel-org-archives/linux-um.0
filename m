Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CxHfb-0002dR-VW for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Feb 2005 20:35:43 -0800
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CxHfZ-0001gM-FL for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Feb 2005 20:35:43 -0800
Message-ID: <42044D17.5040703@yahoo.com.au>
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
References: <42021E35.8050601@fujitsu-siemens.com>	<4202C18F.5010605@yahoo.com.au>	<42036C2C.5040503@fujitsu-siemens.com>	<4203F40C.8040707@yahoo.com.au>
	<20050204143917.1f9507cb.akpm@osdl.org>
	<4204020F.2000501@yahoo.com.au>
In-Reply-To: <4204020F.2000501@yahoo.com.au>
Content-Type: multipart/mixed; boundary="------------030704040005090303040304"
Subject: [uml-devel] Re: Race condition in ptrace
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
Date: Sat, 05 Feb 2005 15:35:35 +1100
To: Andrew Morton <akpm@osdl.org>
Cc: bstroesser@fujitsu-siemens.com, roland@redhat.com, jdike@addtoit.com, blaisorblade_spam@yahoo.it, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030704040005090303040304
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Nick Piggin wrote:
> Andrew Morton wrote:
> 
>> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>>

>>> Andrew, IMO this is another bug to hold 2.6.11 for.
>>
>>
>>
>> Sure.  I wouldn't consider Bodo's patch to be the one to use though..
> 
> 
> No. Something similar could be done that works on all architectures
> and all wait_task_inactive callers (and is confined to sched.c). That
> would still be more or less a hack to work around smtnice's unfortunate
> locking though.
> 

Something like the following (untested) extension of Bodo's work
could be the minimal fix for 2.6.11. As I've said though, I'd
consider it a hack and prefer to do something about the locking.
That could be done after 2.6.11 though. Depends how you feel.

Bodo, I wonder if this looks like a suitable fix for your problem?

--------------030704040005090303040304
Content-Type: text/plain;
 name="sched-fixup-locking.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-fixup-locking.patch"




---

 linux-2.6-npiggin/include/linux/init_task.h |    1 +
 linux-2.6-npiggin/include/linux/sched.h     |    1 +
 linux-2.6-npiggin/kernel/sched.c            |   12 ++++++++++--
 3 files changed, 12 insertions(+), 2 deletions(-)

diff -puN include/linux/sched.h~sched-fixup-locking include/linux/sched.h
--- linux-2.6/include/linux/sched.h~sched-fixup-locking	2005-02-05 15:24:00.000000000 +1100
+++ linux-2.6-npiggin/include/linux/sched.h	2005-02-05 15:24:39.000000000 +1100
@@ -533,6 +533,7 @@ struct task_struct {
 	unsigned long ptrace;
 
 	int lock_depth;		/* Lock depth */
+	int on_cpu;		/* Is the task on the CPU, or in a ctxsw */
 
 	int prio, static_prio;
 	struct list_head run_list;
diff -puN kernel/sched.c~sched-fixup-locking kernel/sched.c
--- linux-2.6/kernel/sched.c~sched-fixup-locking	2005-02-05 15:24:02.000000000 +1100
+++ linux-2.6-npiggin/kernel/sched.c	2005-02-05 15:34:37.000000000 +1100
@@ -294,7 +294,7 @@ static DEFINE_PER_CPU(struct runqueue, r
 #ifndef prepare_arch_switch
 # define prepare_arch_switch(rq, next)	do { } while (0)
 # define finish_arch_switch(rq, next)	spin_unlock_irq(&(rq)->lock)
-# define task_running(rq, p)		((rq)->curr == (p))
+# define task_running(rq, p)		((p)->on_cpu)
 #endif
 
 /*
@@ -867,7 +867,7 @@ void wait_task_inactive(task_t * p)
 repeat:
 	rq = task_rq_lock(p, &flags);
 	/* Must be off runqueue entirely, not preempted. */
-	if (unlikely(p->array)) {
+	if (unlikely(p->array || p->on_cpu)) {
 		/* If it's preempted, we yield.  It could be a while. */
 		preempted = !task_running(rq, p);
 		task_rq_unlock(rq, &flags);
@@ -2805,11 +2805,18 @@ switch_tasks:
 		rq->curr = next;
 		++*switch_count;
 
+		next->on_cpu = 1;
 		prepare_arch_switch(rq, next);
 		prev = context_switch(rq, prev, next);
 		barrier();
 
 		finish_task_switch(prev);
+		/*
+		 * Some architectures release the runqueue lock before
+		 * context switching. Make sure this isn't reordered.
+		 */
+		smp_wmb();
+		prev->on_cpu = 0;
 	} else
 		spin_unlock_irq(&rq->lock);
 
@@ -4055,6 +4062,7 @@ void __devinit init_idle(task_t *idle, i
 	set_task_cpu(idle, cpu);
 
 	spin_lock_irqsave(&rq->lock, flags);
+	idle->on_cpu = 1;
 	rq->curr = rq->idle = idle;
 	set_tsk_need_resched(idle);
 	spin_unlock_irqrestore(&rq->lock, flags);
diff -puN include/linux/init_task.h~sched-fixup-locking include/linux/init_task.h
--- linux-2.6/include/linux/init_task.h~sched-fixup-locking	2005-02-05 15:24:56.000000000 +1100
+++ linux-2.6-npiggin/include/linux/init_task.h	2005-02-05 15:25:07.000000000 +1100
@@ -73,6 +73,7 @@ extern struct group_info init_groups;
 	.usage		= ATOMIC_INIT(2),				\
 	.flags		= 0,						\
 	.lock_depth	= -1,						\
+	.on_cpu		= 0,						\
 	.prio		= MAX_PRIO-20,					\
 	.static_prio	= MAX_PRIO-20,					\
 	.policy		= SCHED_NORMAL,					\

_

--------------030704040005090303040304--




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
