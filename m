Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njU3T-00GXCa-Ns
 for linux-um@lists.infradead.org; Tue, 26 Apr 2022 22:53:14 +0000
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Tue, 26 Apr 2022 17:52:11 -0500
Message-Id: <20220426225211.308418-9-ebiederm@xmission.com>
In-Reply-To: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Subject: [PATCH 9/9] ptrace: Don't change __state
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
To: linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, Oleg Nesterov <oleg@redhat.com>, mingo@kernel.org, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de, Will Deacon <will@kernel.org>, tj@kernel.org, linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, inux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>, "Eric W. Biederman" <ebiederm@xmission.com>

Stop playing with tsk->__state to remove TASK_WAKEKILL while a ptrace
command is executing.

Instead implement a new jobtl flag JOBCTL_DELAY_WAKEKILL.  This new
flag is set in jobctl_freeze_task and cleared when ptrace_stop is
awoken or in jobctl_unfreeze_task (when ptrace_stop remains asleep).

In signal_wake_up_state drop TASK_WAKEKILL from state if TASK_WAKEKILL
is used while JOBCTL_DELAY_WAKEKILL is set.  This has the same effect
as changing TASK_TRACED to __TASK_TRACED as all of the wake_ups that
use TASK_KILLABLE go through signal_wake_up except the wake_up in
ptrace_unfreeze_traced.

Previously the __state value of __TASK_TRACED was changed to
TASK_RUNNING when woken up or back to TASK_TRACED when the code was
left in ptrace_stop.  Now when woken up ptrace_stop now clears
JOBCTL_DELAY_WAKEKILL and when left sleeping ptrace_unfreezed_traced
clears JOBCTL_DELAY_WAKEKILL.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/sched/jobctl.h |  2 ++
 include/linux/sched/signal.h |  3 ++-
 kernel/ptrace.c              | 11 +++++------
 kernel/signal.c              |  1 +
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/include/linux/sched/jobctl.h b/include/linux/sched/jobctl.h
index fa067de9f1a9..4e154ad8205f 100644
--- a/include/linux/sched/jobctl.h
+++ b/include/linux/sched/jobctl.h
@@ -19,6 +19,7 @@ struct task_struct;
 #define JOBCTL_TRAPPING_BIT	21	/* switching to TRACED */
 #define JOBCTL_LISTENING_BIT	22	/* ptracer is listening for events */
 #define JOBCTL_TRAP_FREEZE_BIT	23	/* trap for cgroup freezer */
+#define JOBCTL_DELAY_WAKEKILL_BIT	24	/* delay killable wakeups */
 
 #define JOBCTL_STOP_DEQUEUED	(1UL << JOBCTL_STOP_DEQUEUED_BIT)
 #define JOBCTL_STOP_PENDING	(1UL << JOBCTL_STOP_PENDING_BIT)
@@ -28,6 +29,7 @@ struct task_struct;
 #define JOBCTL_TRAPPING		(1UL << JOBCTL_TRAPPING_BIT)
 #define JOBCTL_LISTENING	(1UL << JOBCTL_LISTENING_BIT)
 #define JOBCTL_TRAP_FREEZE	(1UL << JOBCTL_TRAP_FREEZE_BIT)
+#define JOBCTL_DELAY_WAKEKILL	(1UL << JOBCTL_DELAY_WAKEKILL_BIT)
 
 #define JOBCTL_TRAP_MASK	(JOBCTL_TRAP_STOP | JOBCTL_TRAP_NOTIFY)
 #define JOBCTL_PENDING_MASK	(JOBCTL_STOP_PENDING | JOBCTL_TRAP_MASK)
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 3c8b34876744..1947c85aa9d9 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -437,7 +437,8 @@ extern void signal_wake_up_state(struct task_struct *t, unsigned int state);
 
 static inline void signal_wake_up(struct task_struct *t, bool resume)
 {
-	signal_wake_up_state(t, resume ? TASK_WAKEKILL : 0);
+	bool wakekill = resume && !(t->jobctl & JOBCTL_DELAY_WAKEKILL);
+	signal_wake_up_state(t, wakekill ? TASK_WAKEKILL : 0);
 }
 static inline void ptrace_signal_wake_up(struct task_struct *t, bool resume)
 {
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 842511ee9a9f..0bea74539320 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -194,7 +194,7 @@ static bool ptrace_freeze_traced(struct task_struct *task)
 
 	if (task_is_traced(task) && !looks_like_a_spurious_pid(task) &&
 	    !__fatal_signal_pending(task)) {
-		WRITE_ONCE(task->__state, __TASK_TRACED);
+		task->jobctl |= JOBCTL_DELAY_WAKEKILL;
 		ret = true;
 	}
 
@@ -203,7 +203,7 @@ static bool ptrace_freeze_traced(struct task_struct *task)
 
 static void ptrace_unfreeze_traced(struct task_struct *task)
 {
-	if (READ_ONCE(task->__state) != __TASK_TRACED)
+	if (!(READ_ONCE(task->jobctl) & JOBCTL_DELAY_WAKEKILL))
 		return;
 
 	WARN_ON(!task->ptrace || task->parent != current);
@@ -213,11 +213,10 @@ static void ptrace_unfreeze_traced(struct task_struct *task)
 	 * Recheck state under the lock to close this race.
 	 */
 	spin_lock_irq(&task->sighand->siglock);
-	if (READ_ONCE(task->__state) == __TASK_TRACED) {
+	if (task->jobctl & JOBCTL_DELAY_WAKEKILL) {
+		task->jobctl &= ~JOBCTL_DELAY_WAKEKILL;
 		if (__fatal_signal_pending(task))
 			wake_up_state(task, __TASK_TRACED);
-		else
-			WRITE_ONCE(task->__state, TASK_TRACED);
 	}
 	spin_unlock_irq(&task->sighand->siglock);
 }
@@ -253,7 +252,7 @@ static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
 	 */
 	if (lock_task_sighand(child, &flags)) {
 		if (child->ptrace && child->parent == current) {
-			WARN_ON(READ_ONCE(child->__state) == __TASK_TRACED);
+			WARN_ON(child->jobctl & JOBCTL_DELAY_WAKEKILL);
 			/*
 			 * child->sighand can't be NULL, release_task()
 			 * does ptrace_unlink() before __exit_signal().
diff --git a/kernel/signal.c b/kernel/signal.c
index 584d67deb3cb..2b332f89cbad 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2307,6 +2307,7 @@ static int ptrace_stop(int exit_code, int why, int clear_code,
 
 	/* LISTENING can be set only during STOP traps, clear it */
 	current->jobctl &= ~JOBCTL_LISTENING;
+	current->jobctl &= ~JOBCTL_DELAY_WAKEKILL;
 
 	/*
 	 * Queued signals ignored us while we were stopped for tracing.
-- 
2.35.3


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

