Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CAwes-0003yn-3Q for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Sep 2004 13:27:10 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1CAwep-0008H9-TO
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Sep 2004 13:27:09 -0700
Message-Id: <200409242132.i8OLWaZX003940@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Minor problems with interrupted systemcalls 
In-Reply-To: Your message of "Wed, 22 Sep 2004 19:12:37 +0200."
	<8B6FF516CBA0194AB0996705076B02520F7C38@ABGEX01E.abg.fsc.net> 
References: <8B6FF516CBA0194AB0996705076B02520F7C38@ABGEX01E.abg.fsc.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Fri, 24 Sep 2004 17:32:36 -0400
To: "Stroesser, Bodo" <Bodo.Stroesser@fujitsu-siemens.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, BlaisorBlade <blaisorblade_spam@yahoo.it>

Change the interface to handle_signal so that it doesn't take the system call
return value as an argument and eliminate its return value.
kern_do_signal also now doesn't return immediately after determining that
there is no signal to deliver.

Index: 2.6.9-rc/arch/um/kernel/signal_kern.c
===================================================================
--- 2.6.9-rc.orig/arch/um/kernel/signal_kern.c	2004-09-24 16:04:00.000000000 -0400
+++ 2.6.9-rc/arch/um/kernel/signal_kern.c	2004-09-24 16:17:04.000000000 -0400
@@ -38,16 +38,17 @@
 /*
  * OK, we're invoking a handler
  */	
-static int handle_signal(struct pt_regs *regs, unsigned long signr, 
-			 struct k_sigaction *ka, siginfo_t *info, 
-			 sigset_t *oldset, int error)
+static void handle_signal(struct pt_regs *regs, unsigned long signr, 
+			  struct k_sigaction *ka, siginfo_t *info, 
+			  sigset_t *oldset)
 {
         __sighandler_t handler;
 	void (*restorer)(void);
 	unsigned long sp;
 	sigset_t save;
-	int err, ret;
+	int error, err, ret;
 
+	error = PT_REGS_SYSCALL_RET(&current->thread.regs);
 	ret = 0;
 	/* Always make any pending restarted system calls return -EINTR */
 	current_thread_info()->restart_block.fn = do_no_restart_syscall;
@@ -109,31 +110,25 @@
 	else
 		err = setup_signal_stack_sc(sp, signr, (unsigned long) handler,
 					    restorer, regs, &save);
-	if(err) goto segv;
-
-	return(0);
- segv:
-	force_sigsegv(signr, current);
-	return(1);
+	if(err)
+		force_sigsegv(signr, current);
 }
 
-static int kern_do_signal(struct pt_regs *regs, sigset_t *oldset, int error)
+static int kern_do_signal(struct pt_regs *regs, sigset_t *oldset)
 {
 	struct k_sigaction ka_copy;
 	siginfo_t info;
-	int err, sig;
+	int sig;
 
 	if (!oldset)
 		oldset = &current->blocked;
 
 	sig = get_signal_to_deliver(&info, &ka_copy, regs, NULL);
-	if(sig == 0)
-		return(0);
-
-	/* Whee!  Actually deliver the signal.  */
-	err = handle_signal(regs, sig, &ka_copy, &info, oldset, error);
-	if(!err)
+	if(sig > 0){
+		/* Whee!  Actually deliver the signal.  */
+		handle_signal(regs, sig, &ka_copy, &info, oldset);
 		return(1);
+	}
 
 	/* Did we come from a system call? */
 	if(PT_REGS_SYSCALL_NR(regs) >= 0){
@@ -165,8 +160,7 @@
 
 int do_signal(void)
 {
-	return(kern_do_signal(&current->thread.regs, NULL,
-			      PT_REGS_SYSCALL_RET(&current->thread.regs)));
+	return(kern_do_signal(&current->thread.regs, NULL));
 }
 
 /*
@@ -183,10 +177,11 @@
 	recalc_sigpending();
 	spin_unlock_irq(&current->sighand->siglock);
 
+	PT_REGS_SYSCALL_RET(&current->thread.regs) = -EINTR;
 	while (1) {
 		current->state = TASK_INTERRUPTIBLE;
 		schedule();
-		if(kern_do_signal(&current->thread.regs, &saveset, -EINTR))
+		if(kern_do_signal(&current->thread.regs, &saveset))
 			return(-EINTR);
 	}
 }
@@ -209,10 +204,11 @@
 	recalc_sigpending();
 	spin_unlock_irq(&current->sighand->siglock);
 
+	PT_REGS_SYSCALL_RET(&current->thread.regs) = -EINTR;
 	while (1) {
 		current->state = TASK_INTERRUPTIBLE;
 		schedule();
-		if (kern_do_signal(&current->thread.regs, &saveset, -EINTR))
+		if (kern_do_signal(&current->thread.regs, &saveset))
 			return(-EINTR);
 	}
 }




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
