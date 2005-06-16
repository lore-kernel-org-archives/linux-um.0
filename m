Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Diyk2-0002TQ-I7	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Jun 2005 11:05:26 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1Diyjy-0006Gw-3N	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Jun 2005 11:05:26 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Recent patches of note
References: <20050616160728.GA6040@ccure.user-mode-linux.org>
	<20050616174735.GB7532@ccure.user-mode-linux.org>
	<42B1BD11.7050806@fujitsu-siemens.com>
In-Reply-To: <42B1BD11.7050806@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_fBcsCDVQip+NJ5p"
Message-Id: <200506162009.35357.blaisorblade@yahoo.it>
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
Date: Thu, 16 Jun 2005 20:09:34 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Bodo Stroesser <bstroesser@fujitsu-siemens.com>, Jeff Dike <jdike@addtoit.com>

--Boundary-00=_fBcsCDVQip+NJ5p
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 16 June 2005 19:55, Bodo Stroesser wrote:
> Jeff Dike wrote:
> > I'll fix things accordingly.

> Could you please make handling in switch_to subarch-specific,
> e.g. in arch_switch_to?
arch_switch already exists (wasn't used for SKAS). About improving it and 
making it more "general-purpose" (I've written this for the TLS code needs), 
could you have a look to the attached patches? do_fork-* is another thing (a 
cleanup discussed some time ago with Jeff) but may be needed to apply the 
second.
> s390 might have some special handling for fpregs and debug-regs
> in a single syscall.

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_fBcsCDVQip+NJ5p
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="uml-clean-arch_switch.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="uml-clean-arch_switch.patch"


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
--- linux-2.6.git/arch/um/include/sysdep-i386/ptrace.h~uml-clean-arch_switch	2005-06-02 18:46:18.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/include/sysdep-i386/ptrace.h	2005-06-02 18:46:18.000000000 +0200
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
--- linux-2.6.git/arch/um/kernel/skas/process_kern.c~uml-clean-arch_switch	2005-06-02 18:46:18.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/kernel/skas/process_kern.c	2005-06-02 18:46:18.000000000 +0200
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
--- linux-2.6.git/arch/um/sys-i386/ptrace.c~uml-clean-arch_switch	2005-06-02 18:46:18.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/sys-i386/ptrace.c	2005-06-02 18:46:18.000000000 +0200
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
--- linux-2.6.git/arch/um/sys-i386/ptrace_user.c~uml-clean-arch_switch	2005-06-02 18:46:18.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/sys-i386/ptrace_user.c	2005-06-02 18:46:18.000000000 +0200
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
--- linux-2.6.git/arch/um/include/kern_util.h~uml-clean-arch_switch	2005-06-02 18:46:18.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/include/kern_util.h	2005-06-02 18:46:18.000000000 +0200
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
--- linux-2.6.git/arch/um/kernel/tt/process_kern.c~uml-clean-arch_switch	2005-06-02 18:46:18.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/kernel/tt/process_kern.c	2005-06-02 18:46:18.000000000 +0200
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

--Boundary-00=_fBcsCDVQip+NJ5p
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="uml-do_fork-param-cleanup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="uml-do_fork-param-cleanup.patch"


Fix the do_fork calling convention: normal arch pass the regs and the new sp
value to do_fork instead of NULL.

Currently the arch-independent code ignores these values, while the UML code
(actually it's copy_thread) gets the right values by itself.

With this patch, things are fixed up.

Low-priority.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/um/kernel/process_kern.c      |    5 ++-
 linux-2.6.git-paolo/arch/um/kernel/skas/process_kern.c |   13 ----------
 linux-2.6.git-paolo/arch/um/kernel/syscall_kern.c      |   19 +++-----------
 linux-2.6.git-paolo/arch/um/kernel/tt/process_kern.c   |   15 +----------
 linux-2.6.git-paolo/arch/um/sys-i386/syscalls.c        |   22 ++---------------
 linux-2.6.git-paolo/arch/um/sys-x86_64/syscalls.c      |   22 ++---------------
 6 files changed, 17 insertions(+), 79 deletions(-)

diff -puN arch/um/sys-i386/syscalls.c~uml-do_fork-param-cleanup arch/um/sys-i386/syscalls.c
--- linux-2.6.git/arch/um/sys-i386/syscalls.c~uml-do_fork-param-cleanup	2005-06-02 05:06:42.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/sys-i386/syscalls.c	2005-06-02 05:06:42.000000000 +0200
@@ -69,15 +69,10 @@ long sys_clone(unsigned long clone_flags
 {
 	long ret;
 
-	/* XXX: normal arch do here this pass, and also pass the regs to
-	 * do_fork, instead of NULL. Currently the arch-independent code
-	 * ignores these values, while the UML code (actually it's
-	 * copy_thread) does the right thing. But this should change,
-	 probably. */
-	/*if (!newsp)
-		newsp = UPT_SP(current->thread.regs);*/
+	if (!newsp)
+		newsp = UPT_SP(&current->thread.regs.regs);
 	current->thread.forking = 1;
-	ret = do_fork(clone_flags, newsp, NULL, 0, parent_tid, child_tid);
+	ret = do_fork(clone_flags, newsp, &current->thread.regs, 0, parent_tid, child_tid);
 	current->thread.forking = 0;
 	return(ret);
 }
@@ -197,14 +192,3 @@ long sys_sigaction(int sig, const struct
 
 	return ret;
 }
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
diff -puN arch/um/kernel/tt/process_kern.c~uml-do_fork-param-cleanup arch/um/kernel/tt/process_kern.c
--- linux-2.6.git/arch/um/kernel/tt/process_kern.c~uml-do_fork-param-cleanup	2005-06-02 05:06:42.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/kernel/tt/process_kern.c	2005-06-02 18:47:47.000000000 +0200
@@ -266,8 +266,8 @@ int copy_thread_tt(int nr, unsigned long
 	}
 
 	if(current->thread.forking){
-		sc_to_sc(UPT_SC(&p->thread.regs.regs), 
-			 UPT_SC(&current->thread.regs.regs));
+		sc_to_sc(UPT_SC(&p->thread.regs.regs),
+			 UPT_SC(&regs->regs));
 		SC_SET_SYSCALL_RETURN(UPT_SC(&p->thread.regs.regs), 0);
 		if(sp != 0) SC_SP(UPT_SC(&p->thread.regs.regs)) = sp;
 	}
@@ -459,14 +459,3 @@ int is_valid_pid(int pid)
 	read_unlock(&tasklist_lock);
 	return(0);
 }
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
diff -puN arch/um/kernel/skas/process_kern.c~uml-do_fork-param-cleanup arch/um/kernel/skas/process_kern.c
--- linux-2.6.git/arch/um/kernel/skas/process_kern.c~uml-do_fork-param-cleanup	2005-06-02 05:06:42.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/kernel/skas/process_kern.c	2005-06-02 18:47:47.000000000 +0200
@@ -107,7 +107,7 @@ int copy_thread_skas(int nr, unsigned lo
 
 	if(current->thread.forking){
 	  	memcpy(&p->thread.regs.regs.skas, 
-		       &current->thread.regs.regs.skas, 
+		       &regs->regs.skas,
 		       sizeof(p->thread.regs.regs.skas));
 		REGS_SET_SYSCALL_RETURN(p->thread.regs.regs.skas.regs, 0);
 		if(sp != 0) REGS_SP(p->thread.regs.regs.skas.regs) = sp;
@@ -196,14 +196,3 @@ int thread_pid_skas(struct task_struct *
 #warning Need to look up userspace_pid by cpu
 	return(userspace_pid[0]);
 }
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
diff -puN arch/um/kernel/syscall_kern.c~uml-do_fork-param-cleanup arch/um/kernel/syscall_kern.c
--- linux-2.6.git/arch/um/kernel/syscall_kern.c~uml-do_fork-param-cleanup	2005-06-02 05:06:42.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/kernel/syscall_kern.c	2005-06-02 05:06:42.000000000 +0200
@@ -31,7 +31,8 @@ long sys_fork(void)
 	long ret;
 
 	current->thread.forking = 1;
-        ret = do_fork(SIGCHLD, 0, NULL, 0, NULL, NULL);
+	ret = do_fork(SIGCHLD, UPT_SP(&current->thread.regs.regs),
+			&current->thread.regs, 0, NULL, NULL);
 	current->thread.forking = 0;
 	return(ret);
 }
@@ -41,8 +42,9 @@ long sys_vfork(void)
 	long ret;
 
 	current->thread.forking = 1;
-	ret = do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, 0, NULL, 0, NULL,
-		      NULL);
+	ret = do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD,
+			UPT_SP(&current->thread.regs.regs), &current->thread.regs, 0,
+			NULL, NULL);
 	current->thread.forking = 0;
 	return(ret);
 }
@@ -162,14 +164,3 @@ int next_syscall_index(int limit)
 	spin_unlock(&syscall_lock);
 	return(ret);
 }
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
diff -puN arch/um/kernel/process_kern.c~uml-do_fork-param-cleanup arch/um/kernel/process_kern.c
--- linux-2.6.git/arch/um/kernel/process_kern.c~uml-do_fork-param-cleanup	2005-06-02 05:06:42.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/kernel/process_kern.c	2005-06-02 05:06:42.000000000 +0200
@@ -95,8 +95,9 @@ int kernel_thread(int (*fn)(void *), voi
 
 	current->thread.request.u.thread.proc = fn;
 	current->thread.request.u.thread.arg = arg;
-	pid = do_fork(CLONE_VM | CLONE_UNTRACED | flags, 0, NULL, 0, NULL,
-		      NULL);
+	pid = do_fork(CLONE_VM | CLONE_UNTRACED | flags,
+			0, &current->thread.regs, 0,
+			NULL, NULL);
 	if(pid < 0)
 		panic("do_fork failed in kernel_thread, errno = %d", pid);
 	return(pid);
diff -puN arch/um/sys-x86_64/syscalls.c~uml-do_fork-param-cleanup arch/um/sys-x86_64/syscalls.c
--- linux-2.6.git/arch/um/sys-x86_64/syscalls.c~uml-do_fork-param-cleanup	2005-06-02 05:06:42.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/sys-x86_64/syscalls.c	2005-06-02 05:06:42.000000000 +0200
@@ -174,26 +174,10 @@ long sys_clone(unsigned long clone_flags
 {
 	long ret;
 
-	/* XXX: normal arch do here this pass, and also pass the regs to
-	 * do_fork, instead of NULL. Currently the arch-independent code
-	 * ignores these values, while the UML code (actually it's
-	 * copy_thread) does the right thing. But this should change,
-	 probably. */
-	/*if (!newsp)
-		newsp = UPT_SP(current->thread.regs);*/
+	if (!newsp)
+		newsp = UPT_SP(&current->thread.regs.regs);
 	current->thread.forking = 1;
-	ret = do_fork(clone_flags, newsp, NULL, 0, parent_tid, child_tid);
+	ret = do_fork(clone_flags, newsp, &current->thread.regs, 0, parent_tid, child_tid);
 	current->thread.forking = 0;
 	return(ret);
 }
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
_

--Boundary-00=_fBcsCDVQip+NJ5p--

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
