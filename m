Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CxgjC-00067Z-K1 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 05 Feb 2005 23:21:06 -0800
Received: from mx2.elte.hu ([157.181.151.9])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CxgjA-0002I2-Rw for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 05 Feb 2005 23:21:06 -0800
From: Ingo Molnar <mingo@elte.hu>
Message-ID: <20050206071935.GA19991@elte.hu>
References: <42021E35.8050601@fujitsu-siemens.com>
	<4202C18F.5010605@yahoo.com.au>
	<42036C2C.5040503@fujitsu-siemens.com>
	<4203F40C.8040707@yahoo.com.au>
	<20050204143917.1f9507cb.akpm@osdl.org>
	<4204020F.2000501@yahoo.com.au> <42044D17.5040703@yahoo.com.au>
	<42058E52.8030306@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42058E52.8030306@yahoo.com.au>
Subject: [uml-devel] Re: [PATCH] fix wait_task_inactive race (was Re: Race
	condition in ptrace)
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
Date: Sun, 6 Feb 2005 08:19:35 +0100
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, bstroesser@fujitsu-siemens.com, roland@redhat.com, jdike@addtoit.com, blaisorblade_spam@yahoo.it, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> When a task is put to sleep, it is dequeued from the runqueue
> while it is still running. The problem is that the runqueue
> lock can be dropped and retaken in schedule() before the task
> actually schedules off, and wait_task_inactive did not account
> for this.

ugh. This has been the Nth time we got bitten by the fundamental
unrobustness of non-atomic scheduling on some architectures ...
(And i'll say the N+1th time that this is not good.)

> +static int task_onqueue(runqueue_t *rq, task_t *p)
> +{
> +	return (p->array || task_running(rq, p));
> +}

the fix looks good, but i'd go for the simplified oneliner patch below. 
I dont like the name 'task_onqueue()', a because a task is 'on the
queue' when it has p->array != NULL. The task is running when it's
task_running().  On architectures with nonatomic scheduling a task may
be running while not on the queue and external observers with the
runqueue lock might notice this - and wait_task_inactive() has to take
care of this case. I'm not sure how introducing a function named
"task_onqueue()" will make the situation any clearer.

ok?

	Ingo

--
When a task is put to sleep, it is dequeued from the runqueue
while it is still running. The problem is that one some arches
that has non-atomic scheduling, the runqueue lock can be
dropped and retaken in schedule() before the task actually
schedules off, and wait_task_inactive did not account for this.

Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

---

 linux/kernel/sched.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux/kernel/sched.c.orig
+++ linux/kernel/sched.c
@@ -867,7 +875,7 @@ void wait_task_inactive(task_t * p)
 repeat:
 	rq = task_rq_lock(p, &flags);
 	/* Must be off runqueue entirely, not preempted. */
-	if (unlikely(p->array)) {
+	if (unlikely(p->array || task_running(rq, p))) {
 		/* If it's preempted, we yield.  It could be a while. */
 		preempted = !task_running(rq, p);
 		task_rq_unlock(rq, &flags);



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
