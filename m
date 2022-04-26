Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njU3F-00GWro-1R
 for linux-um@lists.infradead.org; Tue, 26 Apr 2022 22:52:58 +0000
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Tue, 26 Apr 2022 17:52:04 -0500
Message-Id: <20220426225211.308418-2-ebiederm@xmission.com>
In-Reply-To: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Subject: [PATCH 2/9] signal: Replace __group_send_sig_info with
 send_signal_locked
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

The function send_signal_locked does more than __group_send_sig_info so
replace it.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 drivers/tty/tty_jobctrl.c      | 4 ++--
 include/linux/signal.h         | 1 -
 kernel/signal.c                | 8 +-------
 kernel/time/posix-cpu-timers.c | 6 +++---
 4 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/tty_jobctrl.c b/drivers/tty/tty_jobctrl.c
index 80b86a7992b5..0d04287da098 100644
--- a/drivers/tty/tty_jobctrl.c
+++ b/drivers/tty/tty_jobctrl.c
@@ -215,8 +215,8 @@ int tty_signal_session_leader(struct tty_struct *tty, int exit_session)
 				spin_unlock_irq(&p->sighand->siglock);
 				continue;
 			}
-			__group_send_sig_info(SIGHUP, SEND_SIG_PRIV, p);
-			__group_send_sig_info(SIGCONT, SEND_SIG_PRIV, p);
+			send_signal_locked(SIGHUP, SEND_SIG_PRIV, p, PIDTYPE_TGID);
+			send_signal_locked(SIGCONT, SEND_SIG_PRIV, p, PIDTYPE_TGID);
 			put_pid(p->signal->tty_old_pgrp);  /* A noop */
 			spin_lock(&tty->ctrl.lock);
 			tty_pgrp = get_pid(tty->ctrl.pgrp);
diff --git a/include/linux/signal.h b/include/linux/signal.h
index 55605bdf5ce9..3b98e7a28538 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -282,7 +282,6 @@ extern int do_send_sig_info(int sig, struct kernel_siginfo *info,
 				struct task_struct *p, enum pid_type type);
 extern int group_send_sig_info(int sig, struct kernel_siginfo *info,
 			       struct task_struct *p, enum pid_type type);
-extern int __group_send_sig_info(int, struct kernel_siginfo *, struct task_struct *);
 extern int send_signal_locked(int sig, struct kernel_siginfo *info,
 			      struct task_struct *p, enum pid_type type);
 extern int sigprocmask(int, sigset_t *, sigset_t *);
diff --git a/kernel/signal.c b/kernel/signal.c
index b0403197b0ad..72d96614effc 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1281,12 +1281,6 @@ static int __init setup_print_fatal_signals(char *str)
 
 __setup("print-fatal-signals=", setup_print_fatal_signals);
 
-int
-__group_send_sig_info(int sig, struct kernel_siginfo *info, struct task_struct *p)
-{
-	return send_signal_locked(sig, info, p, PIDTYPE_TGID);
-}
-
 int do_send_sig_info(int sig, struct kernel_siginfo *info, struct task_struct *p,
 			enum pid_type type)
 {
@@ -2173,7 +2167,7 @@ static void do_notify_parent_cldstop(struct task_struct *tsk,
 	spin_lock_irqsave(&sighand->siglock, flags);
 	if (sighand->action[SIGCHLD-1].sa.sa_handler != SIG_IGN &&
 	    !(sighand->action[SIGCHLD-1].sa.sa_flags & SA_NOCLDSTOP))
-		__group_send_sig_info(SIGCHLD, &info, parent);
+		send_signal_locked(SIGCHLD, &info, parent, PIDTYPE_TGID);
 	/*
 	 * Even if SIGCHLD is not generated, we must wake up wait4 calls.
 	 */
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 0a97193984db..cb925e8ef9a8 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -870,7 +870,7 @@ static inline void check_dl_overrun(struct task_struct *tsk)
 {
 	if (tsk->dl.dl_overrun) {
 		tsk->dl.dl_overrun = 0;
-		__group_send_sig_info(SIGXCPU, SEND_SIG_PRIV, tsk);
+		send_signal_locked(SIGXCPU, SEND_SIG_PRIV, tsk, PIDTYPE_TGID);
 	}
 }
 
@@ -884,7 +884,7 @@ static bool check_rlimit(u64 time, u64 limit, int signo, bool rt, bool hard)
 			rt ? "RT" : "CPU", hard ? "hard" : "soft",
 			current->comm, task_pid_nr(current));
 	}
-	__group_send_sig_info(signo, SEND_SIG_PRIV, current);
+	send_signal_locked(signo, SEND_SIG_PRIV, current, PIDTYPE_TGID);
 	return true;
 }
 
@@ -958,7 +958,7 @@ static void check_cpu_itimer(struct task_struct *tsk, struct cpu_itimer *it,
 		trace_itimer_expire(signo == SIGPROF ?
 				    ITIMER_PROF : ITIMER_VIRTUAL,
 				    task_tgid(tsk), cur_time);
-		__group_send_sig_info(signo, SEND_SIG_PRIV, tsk);
+		send_signal_locked(signo, SEND_SIG_PRIV, tsk, PIDTYPE_TGID);
 	}
 
 	if (it->expires && it->expires < *expires)
-- 
2.35.3


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

