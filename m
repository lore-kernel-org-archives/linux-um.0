Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DbTIV-0006Rb-Gn	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 May 2005 18:05:59 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DbTI0-0006u4-CQ	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 May 2005 18:05:58 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050527004021.8188B1AEE98@zion.home.lan>
Subject: [uml-devel] [patch 3/4] uml: clean and extend arch_switch() usage
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
Date: Fri, 27 May 2005 02:40:21 +0200
To: jdike@addtoit.com
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


Call arch_switch also in switch_to_skas, even if it's a no-op for that case
(and mark this in the comment).

Also, arch_switch for TT mode is actually useless when the PT proxy (a
complicate debugging instrumentation for TT mode) is not enabled. In fact, it
only calls update_debugregs, which checks debugregs_seq against seq (to check
if the registers are up-to-date - seq here means a "version number" of the
registers).

If the ptrace proxy is not enabled, debugregs_seq always stays 0 and
update_debugregs will be a no-op. So, optimize this out (the compiler can't do
it).

Also, I've been disappointed by the fact that it would make a lot of sense if,
after calling a successful
update_debugregs(current->thread.arch.debugregs_seq),
current->thread.arch.debugregs_seq were updated with the new debugregs_seq.
But this is not done. Is this a bug or a feature? For all purposes, it seems a
bug (otherwise the whole mechanism does not make sense, which is also a
possibility to check), which causes some performance only problems (not
correctness), since we write_debugregs when not needed.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/um/include/kern_util.h          |    5 ++++-
 linux-2.6.git-paolo/arch/um/include/sysdep-i386/ptrace.h |    5 +++++
 linux-2.6.git-paolo/arch/um/kernel/skas/process_kern.c   |    4 +++-
 linux-2.6.git-paolo/arch/um/kernel/tt/process_kern.c     |   13 +++++++++++--
 linux-2.6.git-paolo/arch/um/sys-i386/ptrace.c            |    4 ++--
 linux-2.6.git-paolo/arch/um/sys-i386/ptrace_user.c       |   10 +++++++++-
 6 files changed, 34 insertions(+), 7 deletions(-)

diff -puN arch/um/include/sysdep-i386/ptrace.h~uml-clean-arch_switch arch/um/include/sysdep-i386/ptrace.h
--- linux-2.6.git/arch/um/include/sysdep-i386/ptrace.h~uml-clean-arch_switch	2005-05-25 01:26:20.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/include/sysdep-i386/ptrace.h	2005-05-25 01:26:20.000000000 +0200
@@ -12,7 +12,12 @@
 #define MAX_REG_NR (UM_FRAME_SIZE / sizeof(unsigned long))
 #define MAX_REG_OFFSET (UM_FRAME_SIZE)
 
+#ifdef UML_CONFIG_PT_PROXY
 extern void update_debugregs(int seq);
+#else
+static inline void update_debugregs(int seq) {}
+#endif
+
 
 /* syscall emulation path in ptrace */
 
diff -puN arch/um/kernel/skas/process_kern.c~uml-clean-arch_switch arch/um/kernel/skas/process_kern.c
--- linux-2.6.git/arch/um/kernel/skas/process_kern.c~uml-clean-arch_switch	2005-05-25 01:26:20.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/kernel/skas/process_kern.c	2005-05-25 01:26:20.000000000 +0200
@@ -41,10 +41,12 @@ void *switch_to_skas(void *prev, void *n
 	switch_threads(&from->thread.mode.skas.switch_buf, 
 		       to->thread.mode.skas.switch_buf);
 
+	arch_switch(current->thread.prev_sched, current);
+
 	if(current->pid == 0)
 		switch_timers(1);
 
-	return(current->thread.prev_sched);
+	return current->thread.prev_sched;
 }
 
 extern void schedule_tail(struct task_struct *prev);
diff -puN arch/um/sys-i386/ptrace.c~uml-clean-arch_switch arch/um/sys-i386/ptrace.c
--- linux-2.6.git/arch/um/sys-i386/ptrace.c~uml-clean-arch_switch	2005-05-25 01:26:20.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/sys-i386/ptrace.c	2005-05-25 01:26:20.000000000 +0200
@@ -14,9 +14,9 @@
 #include "sysdep/sigcontext.h"
 #include "sysdep/sc.h"
 
-void arch_switch(void)
+void arch_switch(struct task_struct *from, struct task_struct *to)
 {
-	update_debugregs(current->thread.arch.debugregs_seq);
+	CHOOSE_MODE(update_debugregs(to->thread.arch.debugregs_seq), 0);
 }
 
 int is_syscall(unsigned long addr)
diff -puN arch/um/sys-i386/ptrace_user.c~uml-clean-arch_switch arch/um/sys-i386/ptrace_user.c
--- linux-2.6.git/arch/um/sys-i386/ptrace_user.c~uml-clean-arch_switch	2005-05-25 01:26:20.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/sys-i386/ptrace_user.c	2005-05-25 01:26:20.000000000 +0200
@@ -14,6 +14,7 @@
 #include "sysdep/thread.h"
 #include "user.h"
 #include "os.h"
+#include "uml-config.h"
 
 int ptrace_getregs(long pid, unsigned long *regs_out)
 {
@@ -43,6 +44,7 @@ int ptrace_setfpregs(long pid, unsigned 
 	return 0;
 }
 
+/* All the below stuff is of interest for TT mode only */
 static void write_debugregs(int pid, unsigned long *regs)
 {
 	struct user *dummy;
@@ -75,7 +77,6 @@ static void read_debugregs(int pid, unsi
 
 /* Accessed only by the tracing thread */
 static unsigned long kernel_debugregs[8] = { [ 0 ... 7 ] = 0 };
-static int debugregs_seq = 0;
 
 void arch_enter_kernel(void *task, int pid)
 {
@@ -89,6 +90,11 @@ void arch_leave_kernel(void *task, int p
 	write_debugregs(pid, TASK_DEBUGREGS(task));
 }
 
+#ifdef UML_CONFIG_PT_PROXY
+/* Accessed only by the tracing thread */
+static int debugregs_seq = 0;
+
+/* Only called by the ptrace proxy */
 void ptrace_pokeuser(unsigned long addr, unsigned long data)
 {
 	if((addr < offsetof(struct user, u_debugreg[0])) ||
@@ -109,6 +115,7 @@ static void update_debugregs_cb(void *ar
 	write_debugregs(pid, kernel_debugregs);
 }
 
+/* Optimized out in its header when not defined */
 void update_debugregs(int seq)
 {
 	int me;
@@ -118,6 +125,7 @@ void update_debugregs(int seq)
 	me = os_getpid();
 	initial_thread_cb(update_debugregs_cb, &me);
 }
+#endif
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
diff -puN arch/um/include/kern_util.h~uml-clean-arch_switch arch/um/include/kern_util.h
--- linux-2.6.git/arch/um/include/kern_util.h~uml-clean-arch_switch	2005-05-25 01:26:20.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/include/kern_util.h	2005-05-25 01:26:20.000000000 +0200
@@ -107,7 +107,10 @@ extern void *get_current(void);
 extern struct task_struct *get_task(int pid, int require);
 extern void machine_halt(void);
 extern int is_syscall(unsigned long addr);
-extern void arch_switch(void);
+
+struct task_struct;
+extern void arch_switch(struct task_struct *from, struct task_struct *to);
+
 extern void free_irq(unsigned int, void *);
 extern int um_in_interrupt(void);
 extern int cpu(void);
diff -puN arch/um/kernel/tt/process_kern.c~uml-clean-arch_switch arch/um/kernel/tt/process_kern.c
--- linux-2.6.git/arch/um/kernel/tt/process_kern.c~uml-clean-arch_switch	2005-05-25 01:26:20.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/kernel/tt/process_kern.c	2005-05-25 01:27:00.000000000 +0200
@@ -55,6 +55,13 @@ void *switch_to_tt(void *prev, void *nex
 	c = 0;
 	set_current(to);
 
+	/* Notice that here we "up" the semaphore on which "to" is waiting, and
+	 * below (the read) we wait on this semaphore (which is implemented by
+	 * switch_pipe) and go sleeping. Thus, after that, we have resumed in
+	 * "to", and can't use any more the value of "from" (which is outdated),
+	 * nor the value in "to" (since it was the task which stole us the CPU,
+	 * which we don't care about). */
+
 	err = os_write_file(to->thread.mode.tt.switch_pipe[1], &c, sizeof(c));
 	if(err != sizeof(c))
 		panic("write of switch_pipe failed, err = %d", -err);
@@ -81,12 +88,12 @@ void *switch_to_tt(void *prev, void *nex
 	change_sig(SIGALRM, alrm);
 	change_sig(SIGPROF, prof);
 
-	arch_switch();
+	arch_switch(prev_sched, current);
 
 	flush_tlb_all();
 	local_irq_restore(flags);
 
-	return(current->thread.prev_sched);
+	return prev_sched;
 }
 
 void release_thread_tt(struct task_struct *task)
@@ -147,6 +154,8 @@ static void new_thread_handler(int sig)
 	set_cmdline("(kernel thread)");
 
 	change_sig(SIGUSR1, 1);
+	/* XXX: This is bogus, it's already done in local_irq_enable. Or does
+	 * ordering matters? */
 	change_sig(SIGVTALRM, 1);
 	change_sig(SIGPROF, 1);
 	local_irq_enable();
_


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
