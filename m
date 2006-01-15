Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ey0e7-0002ky-RV for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 14 Jan 2006 21:41:43 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ey0e5-0004V9-Cx
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 14 Jan 2006 21:41:44 -0800
Message-Id: <200601150633.k0F6XWcn015460@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 1/3] UML - Add TIF_RESTORE_SIGMASK support
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
Date: Sun, 15 Jan 2006 01:33:31 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Miklos Szeredi <miklos@szeredi.hu>, dwmw2@infradead.org, David Howells <dhowells@redhat.com>, Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>, Linus Torvalds <torvalds@osdl.org>

Add support for TIF_RESTORE_SIGMASK.  I copy the i386 handling of the flag.
sys_sigsuspend is also changed to follow i386.
Also a bit of cleanup -
   turn an if into a switch
   get rid of a couple more emacs formatting comments

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15-mm/arch/um/kernel/signal_kern.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/kernel/signal_kern.c	2006-01-14 18:50:04.000000000 -0500
+++ linux-2.6.15-mm/arch/um/kernel/signal_kern.c	2006-01-14 18:56:57.000000000 -0500
@@ -99,31 +99,46 @@ static int handle_signal(struct pt_regs 
 	return err;
 }
 
-static int kern_do_signal(struct pt_regs *regs, sigset_t *oldset)
+static int kern_do_signal(struct pt_regs *regs)
 {
 	struct k_sigaction ka_copy;
 	siginfo_t info;
+	sigset_t *oldset;
 	int sig, handled_sig = 0;
 
+	if (test_thread_flag(TIF_RESTORE_SIGMASK))
+		oldset = &current->saved_sigmask;
+	else
+		oldset = &current->blocked;
+
 	while((sig = get_signal_to_deliver(&info, &ka_copy, regs, NULL)) > 0){
 		handled_sig = 1;
 		/* Whee!  Actually deliver the signal.  */
-		if(!handle_signal(regs, sig, &ka_copy, &info, oldset))
+		if(!handle_signal(regs, sig, &ka_copy, &info, oldset)){
+			/* a signal was successfully delivered; the saved
+			 * sigmask will have been stored in the signal frame,
+			 * and will be restored by sigreturn, so we can simply
+			 * clear the TIF_RESTORE_SIGMASK flag */
+			if (test_thread_flag(TIF_RESTORE_SIGMASK))
+				clear_thread_flag(TIF_RESTORE_SIGMASK);
 			break;
+		}
 	}
 
 	/* Did we come from a system call? */
 	if(!handled_sig && (PT_REGS_SYSCALL_NR(regs) >= 0)){
 		/* Restart the system call - no handlers present */
-		if(PT_REGS_SYSCALL_RET(regs) == -ERESTARTNOHAND ||
-		   PT_REGS_SYSCALL_RET(regs) == -ERESTARTSYS ||
-		   PT_REGS_SYSCALL_RET(regs) == -ERESTARTNOINTR){
+		switch(PT_REGS_SYSCALL_RET(regs)){
+		case -ERESTARTNOHAND:
+		case -ERESTARTSYS:
+		case -ERESTARTNOINTR:
 			PT_REGS_ORIG_SYSCALL(regs) = PT_REGS_SYSCALL_NR(regs);
 			PT_REGS_RESTART_SYSCALL(regs);
-		}
-		else if(PT_REGS_SYSCALL_RET(regs) == -ERESTART_RESTARTBLOCK){
+			break;
+		case -ERESTART_RESTARTBLOCK:
 			PT_REGS_SYSCALL_RET(regs) = __NR_restart_syscall;
 			PT_REGS_RESTART_SYSCALL(regs);
+			break;
  		}
 	}
 
@@ -137,12 +152,19 @@ static int kern_do_signal(struct pt_regs
 	if(current->ptrace & PT_DTRACE)
 		current->thread.singlestep_syscall =
 			is_syscall(PT_REGS_IP(&current->thread.regs));
+
+	/* if there's no signal to deliver, we just put the saved sigmask
+	 * back */
+	if (!handled_sig && test_thread_flag(TIF_RESTORE_SIGMASK)) {
+		clear_thread_flag(TIF_RESTORE_SIGMASK);
+		sigprocmask(SIG_SETMASK, &current->saved_sigmask, NULL);
+	}
 	return(handled_sig);
 }
 
 int do_signal(void)
 {
-	return(kern_do_signal(&current->thread.regs, &current->blocked));
+	return(kern_do_signal(&current->thread.regs));
 }
 
 /*
@@ -150,27 +172,22 @@ int do_signal(void)
  */
 long sys_sigsuspend(int history0, int history1, old_sigset_t mask)
 {
-	sigset_t saveset;
-
 	mask &= _BLOCKABLE;
 	spin_lock_irq(&current->sighand->siglock);
-	saveset = current->blocked;
+	current->saved_sigmask = current->blocked;
 	siginitset(&current->blocked, mask);
 	recalc_sigpending();
 	spin_unlock_irq(&current->sighand->siglock);
 
-	PT_REGS_SYSCALL_RET(&current->thread.regs) = -EINTR;
-	while (1) {
-		current->state = TASK_INTERRUPTIBLE;
-		schedule();
-		if(kern_do_signal(&current->thread.regs, &saveset))
-			return(-EINTR);
-	}
+	current->state = TASK_INTERRUPTIBLE;
+	schedule();
+	set_thread_flag(TIF_RESTORE_SIGMASK);
+	return -ERESTARTNOHAND;
 }
 
 long sys_rt_sigsuspend(sigset_t __user *unewset, size_t sigsetsize)
 {
-	sigset_t saveset, newset;
+	sigset_t newset;
 
 	/* XXX: Don't preclude handling different sized sigset_t's.  */
 	if (sigsetsize != sizeof(sigset_t))
@@ -181,32 +198,18 @@ long sys_rt_sigsuspend(sigset_t __user *
 	sigdelsetmask(&newset, ~_BLOCKABLE);
 
 	spin_lock_irq(&current->sighand->siglock);
-	saveset = current->blocked;
+	current->saved_sigmask = current->blocked;
 	current->blocked = newset;
 	recalc_sigpending();
 	spin_unlock_irq(&current->sighand->siglock);
 
-	PT_REGS_SYSCALL_RET(&current->thread.regs) = -EINTR;
-	while (1) {
-		current->state = TASK_INTERRUPTIBLE;
-		schedule();
-		if (kern_do_signal(&current->thread.regs, &saveset))
-			return(-EINTR);
-	}
+	current->state = TASK_INTERRUPTIBLE;
+	schedule();
+	set_thread_flag(TIF_RESTORE_SIGMASK);
+	return -ERESTARTNOHAND;
 }
 
 long sys_sigaltstack(const stack_t __user *uss, stack_t __user *uoss)
 {
 	return(do_sigaltstack(uss, uoss, PT_REGS_SP(&current->thread.regs)));
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
Index: linux-2.6.15-mm/include/asm-um/thread_info.h
===================================================================
--- linux-2.6.15-mm.orig/include/asm-um/thread_info.h	2006-01-14 18:14:20.000000000 -0500
+++ linux-2.6.15-mm/include/asm-um/thread_info.h	2006-01-14 18:58:15.000000000 -0500
@@ -69,6 +69,7 @@ static inline struct thread_info *curren
 #define TIF_RESTART_BLOCK 	4
 #define TIF_MEMDIE	 	5
 #define TIF_SYSCALL_AUDIT	6
+#define TIF_RESTORE_SIGMASK	7
 
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
@@ -76,16 +77,6 @@ static inline struct thread_info *curren
 #define _TIF_POLLING_NRFLAG     (1 << TIF_POLLING_NRFLAG)
 #define _TIF_MEMDIE		(1 << TIF_MEMDIE)
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
+#define _TIF_RESTORE_SIGMASK	(1 << TIF_RESTORE_SIGMASK)
 
 #endif
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
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
