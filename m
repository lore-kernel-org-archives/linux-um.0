Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Gerd Knorr <kraxel@bytesex.org>
Message-ID: <20041018212612.GA3052@bytesex>
References: <4173F1FD.6080004@colitti.com> <87d5zgrkm2.fsf@bytesex.org>
	<200410182118.09005.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
In-Reply-To: <200410182118.09005.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Re: [uml-user] Host processes never terminate on 2.6.9rc3
	host (stuck in ptrace_stop)
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
Date: Mon, 18 Oct 2004 23:26:13 +0200
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net, Lorenzo Colitti <lorenzo@colitti.com>, Massimo Rimondini <rimondin@dia.uniroma3.it>


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> > Yes, I see that as well, it actually *is* that ptrace change added in
> > patch-2.6.9-rc1-bk16.
> 
> > IMHO it is a bug, I've reported it to lkml a 
> > few days ago, no response yet.
> 
> Oh well, did I lost it or you did not CC the UML mailing list? And in the 2nd 
> case, why?

I didn't cc the uml list as it isn't a uml bug, its just that uml
triggeres it.

> I'm downloading the patches from BitKeeper.

I'll attach the offending one for reference, also a short test app
showing the buggy behavior.

> > Problem is that you can't kill -9 processes any more which are ptraced
> > _and_ stopped at the same time.
> Sorry, tried kill -CONT? I'm almost sure it works (tried by both Henrik 
> Normstrod and me, not in this case).

IMHO it is a clear bug in the (host) kernel, so I didn't attempt yet to
workaround that by playing tricks in the UML kernel.  I can't see the
bug when reading the patch through, probably the separation of stopped
and traced process states triggeres some odd corner case somewhere else
in the kernel ...

If you send a SIGKILL to the process being stopped & ptraced *nothing*
happens.  Neither the process is killed nor the ptracing parent is
notified.  That can't be correct.

  Gerd

-- 
return -ENOSIG;

--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="1.1832.54.192.diff"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1832.54.191 -> 1.1832.54.192
#	kernel/power/process.c	1.9     -> 1.10   
#	include/linux/sched.h	1.252   -> 1.253  
#	arch/arm/kernel/ptrace.c	1.24    -> 1.25   
#	arch/parisc/kernel/ptrace.c	1.11    -> 1.12   
#	arch/m68k/kernel/ptrace.c	1.11    -> 1.12   
#	arch/h8300/kernel/ptrace.c	1.5     -> 1.6    
#	     kernel/signal.c	1.132   -> 1.133  
#	arch/v850/kernel/ptrace.c	1.3     -> 1.4    
#	arch/arm26/kernel/ptrace.c	1.1     -> 1.2    
#	arch/m68knommu/kernel/ptrace.c	1.1     -> 1.2    
#	     fs/proc/array.c	1.67    -> 1.68   
#	      fs/proc/base.c	1.78    -> 1.79   
#	arch/sh64/kernel/ptrace.c	1.1     -> 1.2    
#	      kernel/sched.c	1.346   -> 1.347  
#	       kernel/exit.c	1.152   -> 1.153  
#	arch/cris/arch-v10/kernel/ptrace.c	1.2     -> 1.3    
#	arch/sparc64/kernel/ptrace.c	1.21    -> 1.22   
#	arch/sparc/kernel/ptrace.c	1.17    -> 1.18   
#	     kernel/ptrace.c	1.34    -> 1.35   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/09/08	roland@redhat.com	1.1832.54.192
# [PATCH] cleanup ptrace stops and remove notify_parent
# 
# This adds a new state TASK_TRACED that is used in place of TASK_STOPPED
# when a thread stops because it is ptraced.  Now ptrace operations are only
# permitted when the target is in TASK_TRACED state, not in TASK_STOPPED. 
# This means that if a process is stopped normally by a job control signal
# and then you PTRACE_ATTACH to it, you will have to send it a SIGCONT before
# you can do any ptrace operations on it.  (The SIGCONT will be reported to
# ptrace and then you can discard it instead of passing it through when you
# call PTRACE_CONT et al.)
# 
# If a traced child gets orphaned while in TASK_TRACED state, it morphs into
# TASK_STOPPED state.  This makes it again possible to resume or destroy the
# process with SIGCONT or SIGKILL.
# 
# All non-signal tracing stops should now be done via ptrace_notify.  I've
# updated the syscall tracing code in several architectures to do this
# instead of replicating the work by hand.  I also fixed several that were
# unnecessarily repeating some of the checks in ptrace_check_attach.  Calling
# ptrace_check_attach alone is sufficient, and the old checks repeated before
# are now incorrect, not just superfluous.
# 
# I've closed a race in ptrace_check_attach.  With this, we should have a
# robust guarantee that when ptrace starts operating, the task will be in
# TASK_TRACED state and won't come out of it.  This is because the only way
# to resume from TASK_TRACED is via ptrace operations, and only the one
# parent thread attached as the tracer can do those.
# 
# This patch also cleans up the do_notify_parent and do_notify_parent_cldstop
# code so that the dead and stopped cases are completely disjoint.  The
# notify_parent function is gone.
# 
# Signed-off-by: Roland McGrath <roland@redhat.com>
# Signed-off-by: Andrew Morton <akpm@osdl.org>
# Signed-off-by: Linus Torvalds <torvalds@osdl.org>
# --------------------------------------------
#
diff -Nru a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
--- a/arch/arm/kernel/ptrace.c	Tue Oct 12 10:30:23 2004
+++ b/arch/arm/kernel/ptrace.c	Tue Oct 12 10:30:23 2004
@@ -792,11 +792,8 @@
 
 	/* the 0x80 provides a way for the tracing parent to distinguish
 	   between a syscall stop and SIGTRAP delivery */
-	current->exit_code = SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
-					? 0x80 : 0);
-	current->state = TASK_STOPPED;
-	notify_parent(current, SIGCHLD);
-	schedule();
+	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
+				 ? 0x80 : 0));
 	/*
 	 * this isn't the same as continuing with a signal, but it will do
 	 * for normal use.  strace only continues with a signal if the
diff -Nru a/arch/arm26/kernel/ptrace.c b/arch/arm26/kernel/ptrace.c
--- a/arch/arm26/kernel/ptrace.c	Tue Oct 12 10:30:23 2004
+++ b/arch/arm26/kernel/ptrace.c	Tue Oct 12 10:30:23 2004
@@ -729,11 +729,8 @@
 
 	/* the 0x80 provides a way for the tracing parent to distinguish
 	   between a syscall stop and SIGTRAP delivery */
-	current->exit_code = SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
-					? 0x80 : 0);
-	current->state = TASK_STOPPED;
-	notify_parent(current, SIGCHLD);
-	schedule();
+	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
+				 ? 0x80 : 0));
 	/*
 	 * this isn't the same as continuing with a signal, but it will do
 	 * for normal use.  strace only continues with a signal if the
diff -Nru a/arch/cris/arch-v10/kernel/ptrace.c b/arch/cris/arch-v10/kernel/ptrace.c
--- a/arch/cris/arch-v10/kernel/ptrace.c	Tue Oct 12 10:30:23 2004
+++ b/arch/cris/arch-v10/kernel/ptrace.c	Tue Oct 12 10:30:23 2004
@@ -85,17 +85,8 @@
 		goto out_tsk;
 	}
 	
-	ret = -ESRCH;
-	
-	if (!(child->ptrace & PT_PTRACED))
-		goto out_tsk;
-	
-	if (child->state != TASK_STOPPED) {
-		if (request != PTRACE_KILL)
-			goto out_tsk;
-	}
-	
-	if (child->parent != current)
+	ret = ptrace_check_attach(child, request == PTRACE_KILL);
+	if (ret < 0)
 		goto out_tsk;
 
 	switch (request) {
diff -Nru a/arch/h8300/kernel/ptrace.c b/arch/h8300/kernel/ptrace.c
--- a/arch/h8300/kernel/ptrace.c	Tue Oct 12 10:30:23 2004
+++ b/arch/h8300/kernel/ptrace.c	Tue Oct 12 10:30:23 2004
@@ -89,13 +89,6 @@
 		ret = ptrace_attach(child);
 		goto out_tsk;
 	}
-	ret = -ESRCH;
-	if (!(child->ptrace & PT_PTRACED))
-		goto out_tsk;
-	if (child->state != TASK_STOPPED) {
-		if (request != PTRACE_KILL)
-			goto out_tsk;
-	}
 	ret = ptrace_check_attach(child, request == PTRACE_KILL);
 	if (ret < 0)
 		goto out_tsk;
@@ -270,10 +263,8 @@
 		return;
 	if (!(current->ptrace & PT_PTRACED))
 		return;
-	current->exit_code = SIGTRAP;
-	current->state = TASK_STOPPED;
-	notify_parent(current, SIGCHLD);
-	schedule();
+	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
+				 ? 0x80 : 0));
 	/*
 	 * this isn't the same as continuing with a signal, but it will do
 	 * for normal use.  strace only continues with a signal if the
diff -Nru a/arch/m68k/kernel/ptrace.c b/arch/m68k/kernel/ptrace.c
--- a/arch/m68k/kernel/ptrace.c	Tue Oct 12 10:30:23 2004
+++ b/arch/m68k/kernel/ptrace.c	Tue Oct 12 10:30:23 2004
@@ -379,11 +379,8 @@
 	if (!current->thread.work.delayed_trace &&
 	    !current->thread.work.syscall_trace)
 		return;
-	current->exit_code = SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
-					? 0x80 : 0);
-	current->state = TASK_STOPPED;
-	notify_parent(current, SIGCHLD);
-	schedule();
+	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
+				 ? 0x80 : 0));
 	/*
 	 * this isn't the same as continuing with a signal, but it will do
 	 * for normal use.  strace only continues with a signal if the
diff -Nru a/arch/m68knommu/kernel/ptrace.c b/arch/m68knommu/kernel/ptrace.c
--- a/arch/m68knommu/kernel/ptrace.c	Tue Oct 12 10:30:23 2004
+++ b/arch/m68knommu/kernel/ptrace.c	Tue Oct 12 10:30:23 2004
@@ -133,13 +133,6 @@
 		ret = ptrace_attach(child);
 		goto out_tsk;
 	}
-	ret = -ESRCH;
-	if (!(child->ptrace & PT_PTRACED))
-		goto out_tsk;
-	if (child->state != TASK_STOPPED) {
-		if (request != PTRACE_KILL)
-			goto out_tsk;
-	}
 	ret = ptrace_check_attach(child, request == PTRACE_KILL);
 	if (ret < 0)
 		goto out_tsk;
@@ -376,10 +369,8 @@
 		return;
 	if (!(current->ptrace & PT_PTRACED))
 		return;
-	current->exit_code = SIGTRAP;
-	current->state = TASK_STOPPED;
-	notify_parent(current, SIGCHLD);
-	schedule();
+	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
+				 ? 0x80 : 0));
 	/*
 	 * this isn't the same as continuing with a signal, but it will do
 	 * for normal use.  strace only continues with a signal if the
diff -Nru a/arch/parisc/kernel/ptrace.c b/arch/parisc/kernel/ptrace.c
--- a/arch/parisc/kernel/ptrace.c	Tue Oct 12 10:30:23 2004
+++ b/arch/parisc/kernel/ptrace.c	Tue Oct 12 10:30:23 2004
@@ -404,11 +404,8 @@
 		return;
 	if (!(current->ptrace & PT_PTRACED))
 		return;
-	current->exit_code = SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
-					? 0x80 : 0);
-	current->state = TASK_STOPPED;
-	notify_parent(current, SIGCHLD);
-	schedule();
+	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
+				 ? 0x80 : 0));
 	/*
 	 * this isn't the same as continuing with a signal, but it will do
 	 * for normal use.  strace only continues with a signal if the
diff -Nru a/arch/sh64/kernel/ptrace.c b/arch/sh64/kernel/ptrace.c
--- a/arch/sh64/kernel/ptrace.c	Tue Oct 12 10:30:23 2004
+++ b/arch/sh64/kernel/ptrace.c	Tue Oct 12 10:30:23 2004
@@ -311,11 +311,8 @@
 	if (!(tsk->ptrace & PT_PTRACED))
 		return;
 
-	tsk->exit_code = SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
-				    ? 0x80 : 0);
-	tsk->state = TASK_STOPPED;
-	notify_parent(tsk, SIGCHLD);
-	schedule();
+	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
+				 ? 0x80 : 0));
 	/*
 	 * this isn't the same as continuing with a signal, but it will do
 	 * for normal use.  strace only continues with a signal if the
diff -Nru a/arch/sparc/kernel/ptrace.c b/arch/sparc/kernel/ptrace.c
--- a/arch/sparc/kernel/ptrace.c	Tue Oct 12 10:30:23 2004
+++ b/arch/sparc/kernel/ptrace.c	Tue Oct 12 10:30:23 2004
@@ -614,12 +614,9 @@
 		return;
 	if (!(current->ptrace & PT_PTRACED))
 		return;
-	current->exit_code = SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
-					? 0x80 : 0);
-	current->state = TASK_STOPPED;
 	current->thread.flags ^= MAGIC_CONSTANT;
-	notify_parent(current, SIGCHLD);
-	schedule();
+	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
+				 ? 0x80 : 0));
 	/*
 	 * this isn't the same as continuing with a signal, but it will do
 	 * for normal use.  strace only continues with a signal if the
diff -Nru a/arch/sparc64/kernel/ptrace.c b/arch/sparc64/kernel/ptrace.c
--- a/arch/sparc64/kernel/ptrace.c	Tue Oct 12 10:30:23 2004
+++ b/arch/sparc64/kernel/ptrace.c	Tue Oct 12 10:30:23 2004
@@ -627,11 +627,8 @@
 		return;
 	if (!(current->ptrace & PT_PTRACED))
 		return;
-	current->exit_code = SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
-					? 0x80 : 0);
-	current->state = TASK_STOPPED;
-	notify_parent(current, SIGCHLD);
-	schedule();
+	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
+				 ? 0x80 : 0));
 
 	/*
 	 * this isn't the same as continuing with a signal, but it will do
diff -Nru a/arch/v850/kernel/ptrace.c b/arch/v850/kernel/ptrace.c
--- a/arch/v850/kernel/ptrace.c	Tue Oct 12 10:30:23 2004
+++ b/arch/v850/kernel/ptrace.c	Tue Oct 12 10:30:23 2004
@@ -147,14 +147,8 @@
 		rval = ptrace_attach(child);
 		goto out_tsk;
 	}
-	rval = -ESRCH;
-	if (!(child->ptrace & PT_PTRACED))
-		goto out_tsk;
-	if (child->state != TASK_STOPPED) {
-		if (request != PTRACE_KILL)
-			goto out_tsk;
-	}
-	if (child->parent != current)
+	ret = ptrace_check_attach(child, request == PTRACE_KILL);
+	if (ret < 0)
 		goto out_tsk;
 
 	switch (request) {
@@ -269,11 +263,8 @@
 		return;
 	/* The 0x80 provides a way for the tracing parent to distinguish
 	   between a syscall stop and SIGTRAP delivery */
-	current->exit_code = SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
-					? 0x80 : 0);
-	current->state = TASK_STOPPED;
-	notify_parent(current, SIGCHLD);
-	schedule();
+	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
+				 ? 0x80 : 0));
 	/*
 	 * this isn't the same as continuing with a signal, but it will do
 	 * for normal use.  strace only continues with a signal if the
diff -Nru a/fs/proc/array.c b/fs/proc/array.c
--- a/fs/proc/array.c	Tue Oct 12 10:30:23 2004
+++ b/fs/proc/array.c	Tue Oct 12 10:30:23 2004
@@ -130,8 +130,9 @@
 	"S (sleeping)",		/*  1 */
 	"D (disk sleep)",	/*  2 */
 	"T (stopped)",		/*  4 */
-	"Z (zombie)",		/*  8 */
-	"X (dead)"		/* 16 */
+	"T (tracing stop)",	/*  8 */
+	"Z (zombie)",		/* 16 */
+	"X (dead)"		/* 32 */
 };
 
 static inline const char * get_task_state(struct task_struct *tsk)
@@ -141,7 +142,8 @@
 					   TASK_UNINTERRUPTIBLE |
 					   TASK_ZOMBIE |
 					   TASK_DEAD |
-					   TASK_STOPPED);
+					   TASK_STOPPED |
+					   TASK_TRACED);
 	const char **p = &task_state_array[0];
 
 	while (state) {
diff -Nru a/fs/proc/base.c b/fs/proc/base.c
--- a/fs/proc/base.c	Tue Oct 12 10:30:23 2004
+++ b/fs/proc/base.c	Tue Oct 12 10:30:23 2004
@@ -287,7 +287,8 @@
 #define MAY_PTRACE(task) \
 	(task == current || \
 	(task->parent == current && \
-	(task->ptrace & PT_PTRACED) &&  task->state == TASK_STOPPED && \
+	(task->ptrace & PT_PTRACED) && \
+	 (task->state == TASK_STOPPED || task->state == TASK_TRACED) && \
 	 security_ptrace(current,task) == 0))
 
 static int may_ptrace_attach(struct task_struct *task)
diff -Nru a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	Tue Oct 12 10:30:23 2004
+++ b/include/linux/sched.h	Tue Oct 12 10:30:23 2004
@@ -106,8 +106,9 @@
 #define TASK_INTERRUPTIBLE	1
 #define TASK_UNINTERRUPTIBLE	2
 #define TASK_STOPPED		4
-#define TASK_ZOMBIE		8
-#define TASK_DEAD		16
+#define TASK_TRACED		8
+#define TASK_ZOMBIE		16
+#define TASK_DEAD		32
 
 #define __set_task_state(tsk, state_value)		\
 	do { (tsk)->state = (state_value); } while (0)
@@ -738,7 +739,6 @@
 extern int kill_pg_info(int, struct siginfo *, pid_t);
 extern int kill_sl_info(int, struct siginfo *, pid_t);
 extern int kill_proc_info(int, struct siginfo *, pid_t);
-extern void notify_parent(struct task_struct *, int);
 extern void do_notify_parent(struct task_struct *, int);
 extern void force_sig(int, struct task_struct *);
 extern void force_sig_specific(int, struct task_struct *);
diff -Nru a/kernel/exit.c b/kernel/exit.c
--- a/kernel/exit.c	Tue Oct 12 10:30:23 2004
+++ b/kernel/exit.c	Tue Oct 12 10:30:23 2004
@@ -555,6 +555,14 @@
 		if (p->state == TASK_ZOMBIE && p->exit_signal != -1 &&
 		    thread_group_empty(p))
 			do_notify_parent(p, p->exit_signal);
+		else if (p->state == TASK_TRACED) {
+			/*
+			 * If it was at a trace stop, turn it into
+			 * a normal stop since it's no longer being
+			 * traced.
+			 */
+			p->state = TASK_STOPPED;
+		}
 	}
 
 	/*
@@ -1164,7 +1172,7 @@
 	 * race with the TASK_ZOMBIE case.
 	 */
 	exit_code = xchg(&p->exit_code, 0);
-	if (unlikely(p->state > TASK_STOPPED)) {
+	if (unlikely(p->state >= TASK_ZOMBIE)) {
 		/*
 		 * The task resumed and then died.  Let the next iteration
 		 * catch it in TASK_ZOMBIE.  Note that exit_code might
@@ -1245,6 +1253,10 @@
 			flag = 1;
 
 			switch (p->state) {
+			case TASK_TRACED:
+				if (!(p->ptrace & PT_PTRACED))
+					continue;
+				/*FALLTHROUGH*/
 			case TASK_STOPPED:
 				if (!(options & WUNTRACED) &&
 				    !(p->ptrace & PT_PTRACED))
diff -Nru a/kernel/power/process.c b/kernel/power/process.c
--- a/kernel/power/process.c	Tue Oct 12 10:30:23 2004
+++ b/kernel/power/process.c	Tue Oct 12 10:30:23 2004
@@ -25,7 +25,8 @@
 	    (p->flags & PF_NOFREEZE) ||
 	    (p->state == TASK_ZOMBIE) ||
 	    (p->state == TASK_DEAD) ||
-	    (p->state == TASK_STOPPED))
+	    (p->state == TASK_STOPPED) ||
+	    (p->state == TASK_TRACED))
 		return 0;
 	return 1;
 }
@@ -70,6 +71,7 @@
 			if (!freezeable(p))
 				continue;
 			if ((p->flags & PF_FROZEN) ||
+			    (p->state == TASK_TRACED) ||
 			    (p->state == TASK_STOPPED))
 				continue;
 
diff -Nru a/kernel/ptrace.c b/kernel/ptrace.c
--- a/kernel/ptrace.c	Tue Oct 12 10:30:23 2004
+++ b/kernel/ptrace.c	Tue Oct 12 10:30:23 2004
@@ -55,6 +55,15 @@
 	REMOVE_LINKS(child);
 	child->parent = child->real_parent;
 	SET_LINKS(child);
+
+	if (child->state == TASK_TRACED) {
+		/*
+		 * Turn a tracing stop into a normal stop now,
+		 * since with no tracer there would be no way
+		 * to wake it up with SIGCONT or SIGKILL.
+		 */
+		child->state = TASK_STOPPED;
+	}
 }
 
 /*
@@ -62,20 +71,28 @@
  */
 int ptrace_check_attach(struct task_struct *child, int kill)
 {
-	if (!(child->ptrace & PT_PTRACED))
-		return -ESRCH;
+	int ret = -ESRCH;
 
-	if (child->parent != current)
-		return -ESRCH;
+	/*
+	 * We take the read lock around doing both checks to close a
+	 * possible race where someone else was tracing our child and
+	 * detached between these two checks.  After this locked check,
+	 * we are sure that this is our traced child and that can only
+	 * be changed by us so it's not changing right after this.
+	 */
+	read_lock(&tasklist_lock);
+	if ((child->ptrace & PT_PTRACED) && child->parent == current)
+		ret = 0;
+	read_unlock(&tasklist_lock);
 
-	if (!kill) {
-		if (child->state != TASK_STOPPED)
+	if (!ret && !kill) {
+		if (child->state != TASK_TRACED)
 			return -ESRCH;
 		wait_task_inactive(child);
 	}
 
 	/* All systems go.. */
-	return 0;
+	return ret;
 }
 
 int ptrace_attach(struct task_struct *task)
@@ -281,15 +298,13 @@
 
 static int ptrace_getsiginfo(struct task_struct *child, siginfo_t __user * data)
 {
-	if (child->last_siginfo == NULL)
-		return -EINVAL;
+	BUG_ON(child->last_siginfo == NULL);
 	return copy_siginfo_to_user(data, child->last_siginfo);
 }
 
 static int ptrace_setsiginfo(struct task_struct *child, siginfo_t __user * data)
 {
-	if (child->last_siginfo == NULL)
-		return -EINVAL;
+	BUG_ON(child->last_siginfo == NULL);
 	if (copy_from_user(child->last_siginfo, data, sizeof (siginfo_t)) != 0)
 		return -EFAULT;
 	return 0;
@@ -322,24 +337,3 @@
 
 	return ret;
 }
-
-void ptrace_notify(int exit_code)
-{
-	BUG_ON (!(current->ptrace & PT_PTRACED));
-
-	/* Let the debugger run.  */
-	current->exit_code = exit_code;
-	set_current_state(TASK_STOPPED);
-	notify_parent(current, SIGCHLD);
-	schedule();
-
-	/*
-	 * Signals sent while we were stopped might set TIF_SIGPENDING.
-	 */
-
-	spin_lock_irq(&current->sighand->siglock);
-	recalc_sigpending();
-	spin_unlock_irq(&current->sighand->siglock);
-}
-
-EXPORT_SYMBOL(ptrace_notify);
diff -Nru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Tue Oct 12 10:30:23 2004
+++ b/kernel/sched.c	Tue Oct 12 10:30:23 2004
@@ -1258,7 +1258,7 @@
 
 int fastcall wake_up_process(task_t * p)
 {
-	return try_to_wake_up(p, TASK_STOPPED |
+	return try_to_wake_up(p, TASK_STOPPED | TASK_TRACED |
 		       		 TASK_INTERRUPTIBLE | TASK_UNINTERRUPTIBLE, 0);
 }
 
@@ -3679,7 +3679,7 @@
 	task_t *relative;
 	unsigned state;
 	unsigned long free = 0;
-	static const char *stat_nam[] = { "R", "S", "D", "T", "Z", "W" };
+	static const char *stat_nam[] = { "R", "S", "D", "T", "t", "Z", "X" };
 
 	printk("%-13.13s ", p->comm);
 	state = p->state ? __ffs(p->state) + 1 : 0;
diff -Nru a/kernel/signal.c b/kernel/signal.c
--- a/kernel/signal.c	Tue Oct 12 10:30:23 2004
+++ b/kernel/signal.c	Tue Oct 12 10:30:23 2004
@@ -636,7 +636,8 @@
 
 /* forward decl */
 static void do_notify_parent_cldstop(struct task_struct *tsk,
-				     struct task_struct *parent);
+				     struct task_struct *parent,
+				     int why);
 
 /*
  * Handle magic process-wide effects of stop/continue signals.
@@ -681,11 +682,13 @@
 			p->signal->stop_state = 1;
 			spin_unlock(&p->sighand->siglock);
 			if (p->ptrace & PT_PTRACED)
-				do_notify_parent_cldstop(p, p->parent);
+				do_notify_parent_cldstop(p, p->parent,
+							 CLD_STOPPED);
 			else
 				do_notify_parent_cldstop(
 					p->group_leader,
-					p->group_leader->real_parent);
+					p->group_leader->real_parent,
+							 CLD_STOPPED);
 			spin_lock(&p->sighand->siglock);
 		}
 		rm_from_queue(SIG_KERNEL_STOP_MASK, &p->signal->shared_pending);
@@ -727,11 +730,13 @@
 			p->signal->group_exit_code = 0;
 			spin_unlock(&p->sighand->siglock);
 			if (p->ptrace & PT_PTRACED)
-				do_notify_parent_cldstop(p, p->parent);
+				do_notify_parent_cldstop(p, p->parent,
+							 CLD_CONTINUED);
 			else
 				do_notify_parent_cldstop(
 					p->group_leader,
-					p->group_leader->real_parent);
+					p->group_leader->real_parent,
+							 CLD_CONTINUED);
 			spin_lock(&p->sighand->siglock);
 		}
 	}
@@ -899,11 +904,20 @@
 
 
 static void
-__group_complete_signal(int sig, struct task_struct *p, unsigned int mask)
+__group_complete_signal(int sig, struct task_struct *p)
 {
+	unsigned int mask;
 	struct task_struct *t;
 
 	/*
+	 * Don't bother zombies and stopped tasks (but
+	 * SIGKILL will punch through stopped state)
+	 */
+	mask = TASK_DEAD | TASK_ZOMBIE | TASK_TRACED;
+	if (sig != SIGKILL)
+		mask |= TASK_STOPPED;
+
+	/*
 	 * Now find a thread we can wake up to take the signal off the queue.
 	 *
 	 * If the main thread wants the signal, it gets first crack.
@@ -1004,7 +1018,6 @@
 static int
 __group_send_sig_info(int sig, struct siginfo *info, struct task_struct *p)
 {
-	unsigned int mask;
 	int ret = 0;
 
 #ifdef CONFIG_SMP
@@ -1028,14 +1041,6 @@
 		return ret;
 
 	/*
-	 * Don't bother zombies and stopped tasks (but
-	 * SIGKILL will punch through stopped state)
-	 */
-	mask = TASK_DEAD | TASK_ZOMBIE;
-	if (sig != SIGKILL)
-		mask |= TASK_STOPPED;
-
-	/*
 	 * Put this signal on the shared-pending queue, or fail with EAGAIN.
 	 * We always use the shared queue for process-wide signals,
 	 * to avoid several races.
@@ -1044,7 +1049,7 @@
 	if (unlikely(ret))
 		return ret;
 
-	__group_complete_signal(sig, p, mask);
+	__group_complete_signal(sig, p);
 	return 0;
 }
 
@@ -1401,7 +1406,6 @@
 send_group_sigqueue(int sig, struct sigqueue *q, struct task_struct *p)
 {
 	unsigned long flags;
-	unsigned int mask;
 	int ret = 0;
 
 	BUG_ON(!(q->flags & SIGQUEUE_PREALLOC));
@@ -1426,13 +1430,6 @@
 		q->info.si_overrun++;
 		goto out;
 	} 
-	/*
-	 * Don't bother zombies and stopped tasks (but
-	 * SIGKILL will punch through stopped state)
-	 */
-	mask = TASK_DEAD | TASK_ZOMBIE;
-	if (sig != SIGKILL)
-		mask |= TASK_STOPPED;
 
 	/*
 	 * Put this signal on the shared-pending queue.
@@ -1443,7 +1440,7 @@
 	list_add_tail(&q->list, &p->signal->shared_pending.list);
 	sigaddset(&p->signal->shared_pending.signal, sig);
 
-	__group_complete_signal(sig, p, mask);
+	__group_complete_signal(sig, p);
 out:
 	spin_unlock_irqrestore(&p->sighand->siglock, flags);
 	read_unlock(&tasklist_lock);
@@ -1476,19 +1473,22 @@
 }
 
 /*
- * Let a parent know about a status change of a child.
+ * Let a parent know about the death of a child.
+ * For a stopped/continued status change, use do_notify_parent_cldstop instead.
  */
 
 void do_notify_parent(struct task_struct *tsk, int sig)
 {
 	struct siginfo info;
 	unsigned long flags;
-	int why, status;
 	struct sighand_struct *psig;
 
 	if (sig == -1)
 		BUG();
 
+ 	/* do_notify_parent_cldstop should have been called instead.  */
+ 	BUG_ON(tsk->state & (TASK_STOPPED|TASK_TRACED));
+
 	BUG_ON(!tsk->ptrace &&
 	       (tsk->group_leader != tsk || !thread_group_empty(tsk)));
 
@@ -1502,34 +1502,19 @@
 	info.si_stime = tsk->stime + tsk->signal->stime;
 	k_getrusage(tsk, RUSAGE_BOTH, &info.si_rusage);
 
-	status = tsk->exit_code & 0x7f;
-	why = SI_KERNEL;	/* shouldn't happen */
-	switch (tsk->state) {
-	case TASK_STOPPED:
-		/* FIXME -- can we deduce CLD_TRAPPED or CLD_CONTINUED? */
-		if (tsk->ptrace & PT_PTRACED)
-			why = CLD_TRAPPED;
-		else
-			why = CLD_STOPPED;
-		break;
-
-	default:
-		if (tsk->exit_code & 0x80)
-			why = CLD_DUMPED;
-		else if (tsk->exit_code & 0x7f)
-			why = CLD_KILLED;
-		else {
-			why = CLD_EXITED;
-			status = tsk->exit_code >> 8;
-		}
-		break;
+	info.si_status = tsk->exit_code & 0x7f;
+	if (tsk->exit_code & 0x80)
+		info.si_code = CLD_DUMPED;
+	else if (tsk->exit_code & 0x7f)
+		info.si_code = CLD_KILLED;
+	else {
+		info.si_code = CLD_EXITED;
+		info.si_status = tsk->exit_code >> 8;
 	}
-	info.si_code = why;
-	info.si_status = status;
 
 	psig = tsk->parent->sighand;
 	spin_lock_irqsave(&psig->siglock, flags);
-	if (sig == SIGCHLD && tsk->state != TASK_STOPPED &&
+	if (sig == SIGCHLD &&
 	    (psig->action[SIGCHLD-1].sa.sa_handler == SIG_IGN ||
 	     (psig->action[SIGCHLD-1].sa.sa_flags & SA_NOCLDWAIT))) {
 		/*
@@ -1557,26 +1542,9 @@
 	spin_unlock_irqrestore(&psig->siglock, flags);
 }
 
-
-/*
- * We need the tasklist lock because it's the only
- * thing that protects out "parent" pointer.
- *
- * exit.c calls "do_notify_parent()" directly, because
- * it already has the tasklist lock.
- */
-void
-notify_parent(struct task_struct *tsk, int sig)
-{
-	if (sig != -1) {
-		read_lock(&tasklist_lock);
-		do_notify_parent(tsk, sig);
-		read_unlock(&tasklist_lock);
-	}
-}
-
 static void
-do_notify_parent_cldstop(struct task_struct *tsk, struct task_struct *parent)
+do_notify_parent_cldstop(struct task_struct *tsk, struct task_struct *parent,
+			 int why)
 {
 	struct siginfo info;
 	unsigned long flags;
@@ -1592,14 +1560,20 @@
 	info.si_stime = tsk->stime;
 	k_getrusage(tsk, RUSAGE_BOTH, &info.si_rusage);
 
-	info.si_status = (tsk->signal ? tsk->signal->group_exit_code :
-			  tsk->exit_code) & 0x7f;
-	if (info.si_status == 0) {
-		info.si_status = SIGCONT;
-		info.si_code = CLD_CONTINUED;
-	} else {
-		info.si_code = CLD_STOPPED;
-	}
+ 	info.si_code = why;
+ 	switch (why) {
+ 	case CLD_CONTINUED:
+ 		info.si_status = SIGCONT;
+ 		break;
+ 	case CLD_STOPPED:
+ 		info.si_status = tsk->signal->group_exit_code & 0x7f;
+ 		break;
+ 	case CLD_TRAPPED:
+ 		info.si_status = tsk->exit_code & 0x7f;
+ 		break;
+ 	default:
+ 		BUG();
+ 	}
 
 	sighand = parent->sighand;
 	spin_lock_irqsave(&sighand->siglock, flags);
@@ -1613,6 +1587,68 @@
 	spin_unlock_irqrestore(&sighand->siglock, flags);
 }
 
+/*
+ * This must be called with current->sighand->siglock held.
+ *
+ * This should be the path for all ptrace stops.
+ * We always set current->last_siginfo while stopped here.
+ * That makes it a way to test a stopped process for
+ * being ptrace-stopped vs being job-control-stopped.
+ */
+static void ptrace_stop(int exit_code, siginfo_t *info)
+{
+	BUG_ON(!(current->ptrace & PT_PTRACED));
+
+	/*
+	 * If there is a group stop in progress,
+	 * we must participate in the bookkeeping.
+	 */
+	if (current->signal->group_stop_count > 0)
+		--current->signal->group_stop_count;
+
+	current->last_siginfo = info;
+	current->exit_code = exit_code;
+
+	/* Let the debugger run.  */
+	set_current_state(TASK_TRACED);
+	spin_unlock_irq(&current->sighand->siglock);
+	read_lock(&tasklist_lock);
+	do_notify_parent_cldstop(current, current->parent, CLD_TRAPPED);
+	read_unlock(&tasklist_lock);
+	schedule();
+
+	/*
+	 * We are back.  Now reacquire the siglock before touching
+	 * last_siginfo, so that we are sure to have synchronized with
+	 * any signal-sending on another CPU that wants to examine it.
+	 */
+	spin_lock_irq(&current->sighand->siglock);
+	current->last_siginfo = NULL;
+
+	/*
+	 * Queued signals ignored us while we were stopped for tracing.
+	 * So check for any that we should take before resuming user mode.
+	 */
+	recalc_sigpending();
+}
+
+void ptrace_notify(int exit_code)
+{
+	siginfo_t info;
+
+	BUG_ON((exit_code & (0x7f | ~0xffff)) != SIGTRAP);
+
+	memset(&info, 0, sizeof info);
+	info.si_signo = SIGTRAP;
+	info.si_code = exit_code;
+	info.si_pid = current->pid;
+	info.si_uid = current->uid;
+
+	/* Let the debugger run.  */
+	spin_lock_irq(&current->sighand->siglock);
+	ptrace_stop(exit_code, &info);
+	spin_unlock_irq(&current->sighand->siglock);
+}
 
 #ifndef HAVE_ARCH_GET_SIGNAL_TO_DELIVER
 
@@ -1626,13 +1662,15 @@
 	 */
 	if (stop_count < 0 || (current->ptrace & PT_PTRACED)) {
 		read_lock(&tasklist_lock);
-		do_notify_parent_cldstop(current, current->parent);
+		do_notify_parent_cldstop(current, current->parent,
+					 CLD_STOPPED);
 		read_unlock(&tasklist_lock);
 	}
 	else if (stop_count == 0) {
 		read_lock(&tasklist_lock);
 		do_notify_parent_cldstop(current->group_leader,
-					 current->group_leader->real_parent);
+					 current->group_leader->real_parent,
+					 CLD_STOPPED);
 		read_unlock(&tasklist_lock);
 	}
 
@@ -1815,25 +1853,10 @@
 		if ((current->ptrace & PT_PTRACED) && signr != SIGKILL) {
 			ptrace_signal_deliver(regs, cookie);
 
-			/*
-			 * If there is a group stop in progress,
-			 * we must participate in the bookkeeping.
-			 */
-			if (current->signal->group_stop_count > 0)
-				--current->signal->group_stop_count;
-
 			/* Let the debugger run.  */
-			current->exit_code = signr;
-			current->last_siginfo = info;
-			set_current_state(TASK_STOPPED);
-			spin_unlock_irq(&current->sighand->siglock);
-			notify_parent(current, SIGCHLD);
-			schedule();
-
-			current->last_siginfo = NULL;
+			ptrace_stop(signr, info);
 
 			/* We're back.  Did the debugger cancel the sig?  */
-			spin_lock_irq(&current->sighand->siglock);
 			signr = current->exit_code;
 			if (signr == 0)
 				continue;
@@ -1964,7 +1987,7 @@
 EXPORT_SYMBOL(kill_proc_info);
 EXPORT_SYMBOL(kill_sl);
 EXPORT_SYMBOL(kill_sl_info);
-EXPORT_SYMBOL(notify_parent);
+EXPORT_SYMBOL(ptrace_notify);
 EXPORT_SYMBOL(send_sig);
 EXPORT_SYMBOL(send_sig_info);
 EXPORT_SYMBOL(send_group_sig_info);

--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ptrace.c"

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/ptrace.h>
#include <sys/types.h>
#include <sys/wait.h>

int main(int argc, char *argv[])
{
	int child,rc,status;

	child = fork();
	if (0 == child) {
		fprintf(stderr,"[child] ptrace me ...\n");
		ptrace(PTRACE_TRACEME);
		fprintf(stderr,"[child] exec sleep 10 ...\n");
		execlp("sleep", "sleep", "10", NULL);
		perror("execlp");
		exit(1);
	}

	sleep(1);
	fprintf(stderr,"kill %d,STOP ...\n",child);
	kill(child,SIGSTOP);
	fprintf(stderr,"waitpid %d...\n",child);
	rc = waitpid(child,&status,WUNTRACED);
	fprintf(stderr,"%s: rc=%d status=%s%s%s termsig=%d\n",__FUNCTION__,rc,
		WIFEXITED(status)   ? "exit"    : "",
		WIFSIGNALED(status) ? "signal"  : "",
		WIFSTOPPED(status)  ? "stopped" : "",
		WTERMSIG(status));

	sleep(1);
	fprintf(stderr,"kill %d,KILL ...\n",child);
	kill(child,SIGKILL);
	fprintf(stderr,"waitpid %d...\n",child);
	rc = waitpid(child,&status,WUNTRACED);
	fprintf(stderr,"%s: rc=%d status=%s%s%s termsig=%d\n",__FUNCTION__,rc,
		WIFEXITED(status)   ? "exit"    : "",
		WIFSIGNALED(status) ? "signal"  : "",
		WIFSTOPPED(status)  ? "stopped" : "",
		WTERMSIG(status));

	exit(0);
}

--0F1p//8PRICkK4MW--


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
