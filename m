Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i174u-00053Y-2G
 for linux-um@lists.infradead.org; Fri, 23 Aug 2019 10:45:59 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 4/4] arch: um: implement TRACE_IRQFLAGS_SUPPORT
Date: Fri, 23 Aug 2019 12:44:29 +0200
Message-Id: <20190823104429.11047-4-johannes@sipsolutions.net>
In-Reply-To: <20190823104429.11047-1-johannes@sipsolutions.net>
References: <20190823104429.11047-1-johannes@sipsolutions.net>
MIME-Version: 1.0
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
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>

From: Johannes Berg <johannes.berg@intel.com>

UML enables TRACE_IRQFLAGS_SUPPORT but doesn't actually implement
it. It seems to have been added for lockdep support, but that can't
actually really work well without IRQ flags tracing, as is also
very noisily reported when enabling CONFIG_DEBUG_LOCKDEP.

Implement it now.

Fixes: 711553efa5b8 ("[PATCH] uml: declare in Kconfig our partial LOCKDEP support")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/include/shared/longjmp.h |  2 +-
 arch/um/include/shared/os.h      |  7 +++++
 arch/um/kernel/process.c         |  2 ++
 arch/um/kernel/signal.c          | 30 +++++++++++++++++++--
 arch/um/kernel/skas/mmu.c        |  4 +--
 arch/um/kernel/skas/process.c    |  2 +-
 arch/um/os-Linux/main.c          |  2 +-
 arch/um/os-Linux/sigio.c         |  6 ++---
 arch/um/os-Linux/signal.c        | 46 +++++++++++++++++++++++---------
 arch/um/os-Linux/skas/process.c  | 12 ++++-----
 10 files changed, 85 insertions(+), 28 deletions(-)

diff --git a/arch/um/include/shared/longjmp.h b/arch/um/include/shared/longjmp.h
index b3315c1f198b..85a1cc290ecb 100644
--- a/arch/um/include/shared/longjmp.h
+++ b/arch/um/include/shared/longjmp.h
@@ -18,7 +18,7 @@ extern void longjmp(jmp_buf, int);
 	enable = get_signals(); \
 	n = setjmp(*buf); \
 	if(n != 0) \
-		set_signals(enable); \
+		set_signals_trace(enable); \
 	n; })
 
 #endif
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index da7ebbe4ebb3..72c22843ac9f 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -239,6 +239,7 @@ extern void block_signals(void);
 extern void unblock_signals(void);
 extern int get_signals(void);
 extern int set_signals(int enable);
+extern int set_signals_trace(int enable);
 extern int os_is_signal_stack(void);
 extern void deliver_alarm(void);
 
@@ -324,4 +325,10 @@ extern unsigned long os_get_top_address(void);
 
 long syscall(long number, ...);
 
+/* irqflags tracing */
+extern void block_signals_trace(void);
+extern void unblock_signals_trace(void);
+extern void um_trace_signals_on(void);
+extern void um_trace_signals_off(void);
+
 #endif
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 6bede7888fc2..30f8516eb2aa 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -127,6 +127,8 @@ void new_thread_handler(void)
 	fn = current->thread.request.u.thread.proc;
 	arg = current->thread.request.u.thread.arg;
 
+	um_trace_signals_on();
+
 	/*
 	 * callback returns only if the kernel thread execs a process
 	 */
diff --git a/arch/um/kernel/signal.c b/arch/um/kernel/signal.c
index 57acbd67d85d..1a8050bcd168 100644
--- a/arch/um/kernel/signal.c
+++ b/arch/um/kernel/signal.c
@@ -6,14 +6,40 @@
 #include <linux/module.h>
 #include <linux/ptrace.h>
 #include <linux/sched.h>
+#include <linux/ftrace.h>
 #include <asm/siginfo.h>
 #include <asm/signal.h>
 #include <asm/unistd.h>
 #include <frame_kern.h>
 #include <kern_util.h>
+#include <os.h>
 
-EXPORT_SYMBOL(block_signals);
-EXPORT_SYMBOL(unblock_signals);
+
+void block_signals_trace(void)
+{
+	block_signals();
+	if (current_thread_info())
+		trace_hardirqs_off();
+}
+
+void unblock_signals_trace(void)
+{
+	if (current_thread_info())
+		trace_hardirqs_on();
+	unblock_signals();
+}
+
+void um_trace_signals_on(void)
+{
+	if (current_thread_info())
+		trace_hardirqs_on();
+}
+
+void um_trace_signals_off(void)
+{
+	if (current_thread_info())
+		trace_hardirqs_off();
+}
 
 /*
  * OK, we're invoking a handler
diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
index 29e7f5f9f188..ace71f805700 100644
--- a/arch/um/kernel/skas/mmu.c
+++ b/arch/um/kernel/skas/mmu.c
@@ -63,12 +63,12 @@ int init_new_context(struct task_struct *task, struct mm_struct *mm)
 	if (current->mm != NULL && current->mm != &init_mm)
 		from_mm = &current->mm->context;
 
-	block_signals();
+	block_signals_trace();
 	if (from_mm)
 		to_mm->id.u.pid = copy_context_skas0(stack,
 						     from_mm->id.u.pid);
 	else to_mm->id.u.pid = start_userspace(stack);
-	unblock_signals();
+	unblock_signals_trace();
 
 	if (to_mm->id.u.pid < 0) {
 		ret = to_mm->id.u.pid;
diff --git a/arch/um/kernel/skas/process.c b/arch/um/kernel/skas/process.c
index d4dbf08722d6..404914627dd6 100644
--- a/arch/um/kernel/skas/process.c
+++ b/arch/um/kernel/skas/process.c
@@ -19,7 +19,7 @@ static int __init start_kernel_proc(void *unused)
 {
 	int pid;
 
-	block_signals();
+	block_signals_trace();
 	pid = os_getpid();
 
 	cpu_tasks[0].pid = pid;
diff --git a/arch/um/os-Linux/main.c b/arch/um/os-Linux/main.c
index f1fee2b91239..6d098e712839 100644
--- a/arch/um/os-Linux/main.c
+++ b/arch/um/os-Linux/main.c
@@ -170,7 +170,7 @@ int __init main(int argc, char **argv, char **envp)
 	 * that they won't be delivered after the exec, when
 	 * they are definitely not expected.
 	 */
-	unblock_signals();
+	unblock_signals_trace();
 
 	os_info("\n");
 	/* Reboot */
diff --git a/arch/um/os-Linux/sigio.c b/arch/um/os-Linux/sigio.c
index 46e762f926eb..21b226aa1041 100644
--- a/arch/um/os-Linux/sigio.c
+++ b/arch/um/os-Linux/sigio.c
@@ -132,7 +132,7 @@ static void update_thread(void)
 	int n;
 	char c;
 
-	flags = set_signals(0);
+	flags = set_signals_trace(0);
 	CATCH_EINTR(n = write(sigio_private[0], &c, sizeof(c)));
 	if (n != sizeof(c)) {
 		printk(UM_KERN_ERR "update_thread : write failed, err = %d\n",
@@ -147,7 +147,7 @@ static void update_thread(void)
 		goto fail;
 	}
 
-	set_signals(flags);
+	set_signals_trace(flags);
 	return;
  fail:
 	/* Critical section start */
@@ -161,7 +161,7 @@ static void update_thread(void)
 	close(write_sigio_fds[0]);
 	close(write_sigio_fds[1]);
 	/* Critical section end */
-	set_signals(flags);
+	set_signals_trace(flags);
 }
 
 int add_sigio_fd(int fd)
diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index 4cd88b5b9006..d8c52ee3eb3a 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -34,6 +34,8 @@ static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
 	struct uml_pt_regs r;
 	int save_errno = errno;
 
+	um_trace_signals_off();
+
 	r.is_user = 0;
 	if (sig == SIGSEGV) {
 		/* For segfaults, we want the data from the sigcontext. */
@@ -43,7 +45,7 @@ static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
 
 	/* enable signals if sig isn't IRQ signal */
 	if ((sig != SIGIO) && (sig != SIGWINCH))
-		unblock_signals();
+		unblock_signals_trace();
 
 	(*sig_info[sig])(sig, si, &r);
 
@@ -76,11 +78,11 @@ void sig_handler(int sig, struct siginfo *si, mcontext_t *mc)
 		return;
 	}
 
-	block_signals();
+	block_signals_trace();
 
 	sig_handler_common(sig, si, mc);
 
-	set_signals(enabled);
+	set_signals_trace(enabled);
 }
 
 static void timer_real_alarm_handler(mcontext_t *mc)
@@ -104,7 +106,7 @@ void timer_alarm_handler(int sig, struct siginfo *unused_si, mcontext_t *mc)
 		return;
 	}
 
-	block_signals();
+	block_signals_trace();
 
 	signals_active |= SIGALRM_MASK;
 
@@ -112,7 +114,7 @@ void timer_alarm_handler(int sig, struct siginfo *unused_si, mcontext_t *mc)
 
 	signals_active &= ~SIGALRM_MASK;
 
-	set_signals(enabled);
+	set_signals_trace(enabled);
 }
 
 void deliver_alarm(void) {
@@ -253,6 +255,8 @@ void unblock_signals(void)
 	if (signals_enabled == 1)
 		return;
 
+	signals_enabled = 1;
+
 	/*
 	 * We loop because the IRQ handler returns with interrupts off.  So,
 	 * interrupts may have arrived and we need to re-enable them and
@@ -262,12 +266,9 @@ void unblock_signals(void)
 		/*
 		 * Save and reset save_pending after enabling signals.  This
 		 * way, signals_pending won't be changed while we're reading it.
-		 */
-		signals_enabled = 1;
-
-		/*
+		 *
 		 * Setting signals_enabled and reading signals_pending must
-		 * happen in this order.
+		 * happen in this order, so have the barrier here.
 		 */
 		barrier();
 
@@ -280,10 +281,13 @@ void unblock_signals(void)
 		/*
 		 * We have pending interrupts, so disable signals, as the
 		 * handlers expect them off when they are called.  They will
-		 * be enabled again above.
+		 * be enabled again above. We need to trace this, as we're
+		 * expected to be enabling interrupts already, but any more
+		 * tracing that happens inside the handlers we call for the
+		 * pending signals will mess up the tracing state.
 		 */
-
 		signals_enabled = 0;
+		um_trace_signals_off();
 
 		/*
 		 * Deal with SIGIO first because the alarm handler might
@@ -306,6 +310,9 @@ void unblock_signals(void)
 		if (!(signals_pending & SIGIO_MASK) && (signals_active & SIGALRM_MASK))
 			return;
 
+		/* Re-enable signals and trace that we're doing so. */
+		um_trace_signals_on();
+		signals_enabled = 1;
 	}
 }
 
@@ -328,6 +335,21 @@ int set_signals(int enable)
 	return ret;
 }
 
+int set_signals_trace(int enable)
+{
+	int ret;
+	if (signals_enabled == enable)
+		return enable;
+
+	ret = signals_enabled;
+	if (enable)
+		unblock_signals_trace();
+	else
+		block_signals_trace();
+
+	return ret;
+}
+
 int os_is_signal_stack(void)
 {
 	stack_t ss;
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index df4a985716eb..095bff707bb3 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -425,9 +425,9 @@ void userspace(struct uml_pt_regs *regs, unsigned long *aux_fp_regs)
 			case SIGBUS:
 			case SIGFPE:
 			case SIGWINCH:
-				block_signals();
+				block_signals_trace();
 				(*sig_info[sig])(sig, (struct siginfo *)&si, regs);
-				unblock_signals();
+				unblock_signals_trace();
 				break;
 			default:
 				printk(UM_KERN_ERR "userspace - child stopped "
@@ -625,10 +625,10 @@ void initial_thread_cb_skas(void (*proc)(void *), void *arg)
 	cb_arg = arg;
 	cb_back = &here;
 
-	block_signals();
+	block_signals_trace();
 	if (UML_SETJMP(&here) == 0)
 		UML_LONGJMP(&initial_jmpbuf, INIT_JMP_CALLBACK);
-	unblock_signals();
+	unblock_signals_trace();
 
 	cb_proc = NULL;
 	cb_arg = NULL;
@@ -637,13 +637,13 @@ void initial_thread_cb_skas(void (*proc)(void *), void *arg)
 
 void halt_skas(void)
 {
-	block_signals();
+	block_signals_trace();
 	UML_LONGJMP(&initial_jmpbuf, INIT_JMP_HALT);
 }
 
 void reboot_skas(void)
 {
-	block_signals();
+	block_signals_trace();
 	UML_LONGJMP(&initial_jmpbuf, INIT_JMP_REBOOT);
 }
 
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

