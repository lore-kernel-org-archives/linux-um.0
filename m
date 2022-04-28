Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Thu, 28 Apr 2022 18:09:53 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 7/9] ptrace: Simplify the wait_task_inactive call in
 ptrace_check_attach
Message-ID: <Ymq8UafDbJEjSoB0@hirez.programming.kicks-ass.net>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
 <20220426225211.308418-7-ebiederm@xmission.com>
 <20220427151455.GE17421@redhat.com>
 <Ympvf1Pam1ckX+EA@hirez.programming.kicks-ass.net>
 <20220428111911.GA3804@redhat.com>
 <YmqckaB+xB6azP1d@hirez.programming.kicks-ass.net>
 <20220428145750.GA15485@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220428145750.GA15485@redhat.com>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de, Will Deacon <will@kernel.org>, tj@kernel.org, linux-pm@vger.kernel.org, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, inux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>

On Thu, Apr 28, 2022 at 04:57:50PM +0200, Oleg Nesterov wrote:

> > Shouldn't we then switch wait_task_inactive() so have & matching instead
> > of the current ==.
> 
> Sorry, I don't understand the context...

This.. I've always found it strange to have wti use a different matching
scheme from ttwu.

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f259621f4c93..c039aef4c8fe 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3304,7 +3304,7 @@ unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state
 		 * is actually now running somewhere else!
 		 */
 		while (task_running(rq, p)) {
-			if (match_state && unlikely(READ_ONCE(p->__state) != match_state))
+			if (match_state && unlikely(!(READ_ONCE(p->__state) & match_state)))
 				return 0;
 			cpu_relax();
 		}
@@ -3319,7 +3319,7 @@ unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state
 		running = task_running(rq, p);
 		queued = task_on_rq_queued(p);
 		ncsw = 0;
-		if (!match_state || READ_ONCE(p->__state) == match_state)
+		if (!match_state || (READ_ONCE(p->__state) & match_state))
 			ncsw = p->nvcsw | LONG_MIN; /* sets MSB */
 		task_rq_unlock(rq, p, &rf);
 

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

