Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njU3Q-00GXA1-Di
 for linux-um@lists.infradead.org; Tue, 26 Apr 2022 22:53:10 +0000
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Tue, 26 Apr 2022 17:52:10 -0500
Message-Id: <20220426225211.308418-8-ebiederm@xmission.com>
In-Reply-To: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Subject: [PATCH 8/9] ptrace: Use siglock instead of tasklist_lock in
 ptrace_check_attach
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

Now that siglock protects tsk->parent and tsk->ptrace there is no need
to grab tasklist_lock in ptrace_check_attach.  The siglock can handle
all of the locking needs of ptrace_check_attach.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/ptrace.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 0634da7ac685..842511ee9a9f 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -189,17 +189,14 @@ static bool ptrace_freeze_traced(struct task_struct *task)
 {
 	bool ret = false;
 
-	/* Lockless, nobody but us can set this flag */
 	if (task->jobctl & JOBCTL_LISTENING)
 		return ret;
 
-	spin_lock_irq(&task->sighand->siglock);
 	if (task_is_traced(task) && !looks_like_a_spurious_pid(task) &&
 	    !__fatal_signal_pending(task)) {
 		WRITE_ONCE(task->__state, __TASK_TRACED);
 		ret = true;
 	}
-	spin_unlock_irq(&task->sighand->siglock);
 
 	return ret;
 }
@@ -237,33 +234,35 @@ static void ptrace_unfreeze_traced(struct task_struct *task)
  * state.
  *
  * CONTEXT:
- * Grabs and releases tasklist_lock and @child->sighand->siglock.
+ * Grabs and releases @child->sighand->siglock.
  *
  * RETURNS:
  * 0 on success, -ESRCH if %child is not ready.
  */
 static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
 {
+	unsigned long flags;
 	int ret = -ESRCH;
 
 	/*
-	 * We take the read lock around doing both checks to close a
+	 * We take the siglock around doing both checks to close a
 	 * possible race where someone else was tracing our child and
 	 * detached between these two checks.  After this locked check,
 	 * we are sure that this is our traced child and that can only
 	 * be changed by us so it's not changing right after this.
 	 */
-	read_lock(&tasklist_lock);
-	if (child->ptrace && child->parent == current) {
-		WARN_ON(READ_ONCE(child->__state) == __TASK_TRACED);
-		/*
-		 * child->sighand can't be NULL, release_task()
-		 * does ptrace_unlink() before __exit_signal().
-		 */
-		if (ignore_state || ptrace_freeze_traced(child))
-			ret = 0;
+	if (lock_task_sighand(child, &flags)) {
+		if (child->ptrace && child->parent == current) {
+			WARN_ON(READ_ONCE(child->__state) == __TASK_TRACED);
+			/*
+			 * child->sighand can't be NULL, release_task()
+			 * does ptrace_unlink() before __exit_signal().
+			 */
+			if (ignore_state || ptrace_freeze_traced(child))
+				ret = 0;
+		}
+		unlock_task_sighand(child, &flags);
 	}
-	read_unlock(&tasklist_lock);
 
 	if (!ret && !ignore_state &&
 	    WARN_ON_ONCE(!wait_task_inactive(child, 0)))
-- 
2.35.3


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

