Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CAwex-00040D-KR for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Sep 2004 13:27:15 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1CAwev-0007ns-Oe
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Sep 2004 13:27:15 -0700
Message-Id: <200409242132.i8OLWiZX003946@ccure.user-mode-linux.org>
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
Date: Fri, 24 Sep 2004 17:32:44 -0400
To: "Stroesser, Bodo" <Bodo.Stroesser@fujitsu-siemens.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, BlaisorBlade <blaisorblade_spam@yahoo.it>

Move the signal delivery code around to eliminate a couple of temporary 
variables.

Index: 2.6.9-rc/arch/um/kernel/signal_kern.c
===================================================================
--- 2.6.9-rc.orig/arch/um/kernel/signal_kern.c	2004-09-24 16:17:04.000000000 -0400
+++ 2.6.9-rc/arch/um/kernel/signal_kern.c	2004-09-24 16:17:04.000000000 -0400
@@ -42,10 +42,8 @@
 			  struct k_sigaction *ka, siginfo_t *info, 
 			  sigset_t *oldset)
 {
-        __sighandler_t handler;
 	void (*restorer)(void);
 	unsigned long sp;
-	sigset_t save;
 	int error, err, ret;
 
 	error = PT_REGS_SYSCALL_RET(&current->thread.regs);
@@ -79,8 +77,24 @@
 		break;
 	}
 
-	handler = ka->sa.sa_handler;
-	save = *oldset;
+	sp = PT_REGS_SP(regs);
+	if((ka->sa.sa_flags & SA_ONSTACK) && (sas_ss_flags(sp) == 0))
+		sp = current->sas_ss_sp + current->sas_ss_size;
+
+	if(error != 0) PT_REGS_SET_SYSCALL_RETURN(regs, ret);
+
+	if (ka->sa.sa_flags & SA_RESTORER) 
+		restorer = ka->sa.sa_restorer;
+	else restorer = NULL;
+
+	if(ka->sa.sa_flags & SA_SIGINFO)
+		err = setup_signal_stack_si(sp, signr, 
+					    (unsigned long) ka->sa.sa_handler,
+					    restorer, regs, info, oldset);
+	else
+		err = setup_signal_stack_sc(sp, signr, 
+					    (unsigned long) ka->sa.sa_handler,
+					    restorer, regs, oldset);
 
 	if (ka->sa.sa_flags & SA_ONESHOT)
 		ka->sa.sa_handler = SIG_DFL;
@@ -94,22 +108,6 @@
 		spin_unlock_irq(&current->sighand->siglock);
 	}
 
-	sp = PT_REGS_SP(regs);
-
-	if((ka->sa.sa_flags & SA_ONSTACK) && (sas_ss_flags(sp) == 0))
-		sp = current->sas_ss_sp + current->sas_ss_size;
-	
-	if(error != 0) PT_REGS_SET_SYSCALL_RETURN(regs, ret);
-
-	if (ka->sa.sa_flags & SA_RESTORER) restorer = ka->sa.sa_restorer;
-	else restorer = NULL;
-
-	if(ka->sa.sa_flags & SA_SIGINFO)
-		err = setup_signal_stack_si(sp, signr, (unsigned long) handler,
-					    restorer, regs, info, &save);
-	else
-		err = setup_signal_stack_sc(sp, signr, (unsigned long) handler,
-					    restorer, regs, &save);
 	if(err)
 		force_sigsegv(signr, current);
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
