Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DkRRm-0000kI-4U	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Jun 2005 11:56:38 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DkRRj-0007Jz-QM	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Jun 2005 11:56:38 -0700
Message-Id: <200506201851.j5KIpFiY008483@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 3/8] UML - fork cleanup
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
Date: Mon, 20 Jun 2005 14:51:15 -0400
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it

Fix the do_fork calling convention: normal arch pass the regs and the new sp
value to do_fork instead of NULL.

Currently the arch-independent code ignores these values, while the UML code
(actually it's copy_thread) gets the right values by itself.

With this patch, things are fixed up.

Low-priority.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12/arch/um/kernel/process_kern.c
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/process_kern.c	2005-06-20 11:54:49.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/process_kern.c	2005-06-20 12:02:19.000000000 -0400
@@ -96,8 +96,8 @@ int kernel_thread(int (*fn)(void *), voi
 
 	current->thread.request.u.thread.proc = fn;
 	current->thread.request.u.thread.arg = arg;
-	pid = do_fork(CLONE_VM | CLONE_UNTRACED | flags, 0, NULL, 0, NULL,
-		      NULL);
+	pid = do_fork(CLONE_VM | CLONE_UNTRACED | flags, 0, 
+		      &current->thread.regs, 0, NULL, NULL);
 	if(pid < 0)
 		panic("do_fork failed in kernel_thread, errno = %d", pid);
 	return(pid);
Index: linux-2.6.12/arch/um/kernel/skas/process_kern.c
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/skas/process_kern.c	2005-06-20 11:54:56.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/skas/process_kern.c	2005-06-20 12:02:32.000000000 -0400
@@ -111,8 +111,7 @@ int copy_thread_skas(int nr, unsigned lo
   	void (*handler)(int);
 
 	if(current->thread.forking){
-	  	memcpy(&p->thread.regs.regs.skas, 
-		       &current->thread.regs.regs.skas, 
+	  	memcpy(&p->thread.regs.regs.skas, &regs->regs.skas,
 		       sizeof(p->thread.regs.regs.skas));
 		REGS_SET_SYSCALL_RETURN(p->thread.regs.regs.skas.regs, 0);
 		if(sp != 0) REGS_SP(p->thread.regs.regs.skas.regs) = sp;
@@ -201,14 +200,3 @@ int thread_pid_skas(struct task_struct *
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
Index: linux-2.6.12/arch/um/kernel/syscall_kern.c
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/syscall_kern.c	2005-06-20 11:54:44.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/syscall_kern.c	2005-06-20 12:03:19.000000000 -0400
@@ -31,7 +31,8 @@ long sys_fork(void)
 	long ret;
 
 	current->thread.forking = 1;
-        ret = do_fork(SIGCHLD, 0, NULL, 0, NULL, NULL);
+	ret = do_fork(SIGCHLD, UPT_SP(&current->thread.regs.regs),
+		      &current->thread.regs, 0, NULL, NULL);
 	current->thread.forking = 0;
 	return(ret);
 }
@@ -41,8 +42,9 @@ long sys_vfork(void)
 	long ret;
 
 	current->thread.forking = 1;
-	ret = do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, 0, NULL, 0, NULL,
-		      NULL);
+	ret = do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD,
+		      UPT_SP(&current->thread.regs.regs), 
+		      &current->thread.regs, 0, NULL, NULL);
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
Index: linux-2.6.12/arch/um/kernel/tt/process_kern.c
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/tt/process_kern.c	2005-06-20 11:54:54.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/tt/process_kern.c	2005-06-20 12:03:45.000000000 -0400
@@ -266,10 +266,10 @@ int copy_thread_tt(int nr, unsigned long
 	}
 
 	if(current->thread.forking){
-		sc_to_sc(UPT_SC(&p->thread.regs.regs), 
-			 UPT_SC(&current->thread.regs.regs));
+		sc_to_sc(UPT_SC(&p->thread.regs.regs), UPT_SC(&regs->regs));
 		SC_SET_SYSCALL_RETURN(UPT_SC(&p->thread.regs.regs), 0);
-		if(sp != 0) SC_SP(UPT_SC(&p->thread.regs.regs)) = sp;
+		if(sp != 0) 
+			SC_SP(UPT_SC(&p->thread.regs.regs)) = sp;
 	}
 	p->thread.mode.tt.extern_pid = new_pid;
 
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
Index: linux-2.6.12/arch/um/sys-i386/syscalls.c
===================================================================
--- linux-2.6.12.orig/arch/um/sys-i386/syscalls.c	2005-06-20 11:54:44.000000000 -0400
+++ linux-2.6.12/arch/um/sys-i386/syscalls.c	2005-06-20 12:04:32.000000000 -0400
@@ -69,15 +69,11 @@ long sys_clone(unsigned long clone_flags
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
+	ret = do_fork(clone_flags, newsp, &current->thread.regs, 0, parent_tid,
+		      child_tid);
 	current->thread.forking = 0;
 	return(ret);
 }
@@ -197,14 +193,3 @@ long sys_sigaction(int sig, const struct
 
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
Index: linux-2.6.12/arch/um/sys-x86_64/syscalls.c
===================================================================
--- linux-2.6.12.orig/arch/um/sys-x86_64/syscalls.c	2005-06-20 11:54:52.000000000 -0400
+++ linux-2.6.12/arch/um/sys-x86_64/syscalls.c	2005-06-20 12:04:14.000000000 -0400
@@ -174,26 +174,11 @@ long sys_clone(unsigned long clone_flags
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
+	ret = do_fork(clone_flags, newsp, &current->thread.regs, 0, parent_tid,
+		      child_tid);
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



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
