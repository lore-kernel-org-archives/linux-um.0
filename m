Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CAwf6-00042S-Rt for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Sep 2004 13:27:24 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1CAwf5-0008LD-7d
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Sep 2004 13:27:24 -0700
Message-Id: <200409242132.i8OLWoZX003951@ccure.user-mode-linux.org>
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
Date: Fri, 24 Sep 2004 17:32:50 -0400
To: "Stroesser, Bodo" <Bodo.Stroesser@fujitsu-siemens.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, BlaisorBlade <blaisorblade_spam@yahoo.it>

handle_signal now checks whether it is being called from a system call 
invocation.

Index: 2.6.9-rc/arch/um/kernel/signal_kern.c
===================================================================
--- 2.6.9-rc.orig/arch/um/kernel/signal_kern.c	2004-09-24 16:17:04.000000000 -0400
+++ 2.6.9-rc/arch/um/kernel/signal_kern.c	2004-09-24 16:17:07.000000000 -0400
@@ -44,45 +44,37 @@
 {
 	void (*restorer)(void);
 	unsigned long sp;
-	int error, err, ret;
+	int err;
 
-	error = PT_REGS_SYSCALL_RET(&current->thread.regs);
-	ret = 0;
 	/* Always make any pending restarted system calls return -EINTR */
 	current_thread_info()->restart_block.fn = do_no_restart_syscall;
-	switch(error){
-	case -ERESTART_RESTARTBLOCK:
-	case -ERESTARTNOHAND:
-		ret = -EINTR;
-		break;
-
-	case -ERESTARTSYS:
-		if (!(ka->sa.sa_flags & SA_RESTART)) {
-			ret = -EINTR;
+
+	/* Did we come from a system call? */
+	if(PT_REGS_SYSCALL_NR(regs) >= 0){
+		/* If so, check system call restarting.. */
+		switch(PT_REGS_SYSCALL_RET(regs)){
+		case -ERESTART_RESTARTBLOCK:
+		case -ERESTARTNOHAND:
+			PT_REGS_SYSCALL_RET(regs) = -EINTR;
 			break;
-		}
+
+		case -ERESTARTSYS:
+			if (!(ka->sa.sa_flags & SA_RESTART)) {
+				PT_REGS_SYSCALL_RET(regs) = -EINTR;
+				break;
+			}
 		/* fallthrough */
-	case -ERESTARTNOINTR:
-		PT_REGS_RESTART_SYSCALL(regs);
-		PT_REGS_ORIG_SYSCALL(regs) = PT_REGS_SYSCALL_NR(regs);
-
-		/* This is because of the UM_SET_SYSCALL_RETURN and the fact
-		 * that on i386 the system call number and return value are
-		 * in the same register.  When the system call restarts, %eax
-		 * had better have the system call number in it.  Since the
-		 * return value doesn't matter (except that it shouldn't be
-		 * -ERESTART*), we'll stick the system call number there.
-		 */
-		ret = PT_REGS_SYSCALL_NR(regs);
-		break;
+		case -ERESTARTNOINTR:
+			PT_REGS_RESTART_SYSCALL(regs);
+			PT_REGS_ORIG_SYSCALL(regs) = PT_REGS_SYSCALL_NR(regs);
+			break;
+		}
 	}
 
 	sp = PT_REGS_SP(regs);
 	if((ka->sa.sa_flags & SA_ONSTACK) && (sas_ss_flags(sp) == 0))
 		sp = current->sas_ss_sp + current->sas_ss_size;
 
-	if(error != 0) PT_REGS_SET_SYSCALL_RETURN(regs, ret);
-
 	if (ka->sa.sa_flags & SA_RESTORER) 
 		restorer = ka->sa.sa_restorer;
 	else restorer = NULL;




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
