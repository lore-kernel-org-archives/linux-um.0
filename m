Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CUUlH-00014h-KY for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 Nov 2004 10:42:35 -0800
Received: from pool-151-203-245-3.bos.east.verizon.net ([151.203.245.3]
	helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1CUUlD-0007Bt-9z
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 Nov 2004 10:42:35 -0800
Message-Id: <200411172056.iAHKu9Q3004642@ccure.user-mode-linux.org>
In-Reply-To: Your message of "Tue, 16 Nov 2004 13:38:27 GMT."
	<1100612306.24599.37.camel@imp.csi.cam.ac.uk> 
References: <1100612306.24599.37.camel@imp.csi.cam.ac.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] Re: Bug report for UML in latest Linus 2.6-BK repository.
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
Date: Wed, 17 Nov 2004 15:56:09 -0500
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>

aia21@cam.ac.uk said:
> I get millions of these on the UML guest as soon as I start UML
> (.config is below), notably HIGHMEM is not enabled in the .config.
> They only stop when I shutdown.

The patch below fixes those for me.

				Jeff

Index: 2.6.9/arch/um/sys-i386/signal.c
===================================================================
--- 2.6.9.orig/arch/um/sys-i386/signal.c	2004-11-16 23:19:45.000000000 -0500
+++ 2.6.9/arch/um/sys-i386/signal.c	2004-11-16 23:27:54.000000000 -0500
@@ -305,35 +305,58 @@
 {
 	unsigned long __user sp = PT_REGS_SP(&current->thread.regs);
 	struct sigframe __user *frame = (struct sigframe *)(sp - 8);
+	sigset_t set;
 	struct sigcontext __user *sc = &frame->sc;
 	unsigned long __user *mask = &sc->oldmask;
 	int sig_size = (_NSIG_WORDS - 1) * sizeof(unsigned long);
 
+	if(copy_from_user(&set.sig[0], mask, sizeof(&set.sig[0])) ||
+	   copy_from_user(&set.sig[1], mask, sig_size))
+		goto segfault;
+
+	sigdelsetmask(&set, ~_BLOCKABLE);
+
 	spin_lock_irq(&current->sighand->siglock);
-	copy_from_user(&current->blocked.sig[0], mask,
-		       sizeof(current->blocked.sig[0]));
-	copy_from_user(&current->blocked.sig[1], mask, sig_size);
-	sigdelsetmask(&current->blocked, ~_BLOCKABLE);
+	current->blocked = set;
 	recalc_sigpending();
 	spin_unlock_irq(&current->sighand->siglock);
-	copy_sc_from_user(&current->thread.regs, sc);
+
+	if(copy_sc_from_user(&current->thread.regs, sc))
+		goto segfault;
+
 	return(PT_REGS_SYSCALL_RET(&current->thread.regs));
+
+ segfault:
+	force_sig(SIGSEGV, current);
+	return 0;
 }
 
 long sys_rt_sigreturn(struct pt_regs regs)
 {
 	unsigned long __user sp = PT_REGS_SP(&current->thread.regs);
 	struct rt_sigframe __user *frame = (struct rt_sigframe *) (sp - 4);
+	sigset_t set;
 	struct ucontext __user *uc = &frame->uc;
 	int sig_size = _NSIG_WORDS * sizeof(unsigned long);
 
+	if(copy_from_user(&set, &uc->uc_sigmask, sig_size))
+		goto segfault;
+
+	sigdelsetmask(&set, ~_BLOCKABLE);
+
 	spin_lock_irq(&current->sighand->siglock);
-	copy_from_user(&current->blocked, &uc->uc_sigmask, sig_size);
-	sigdelsetmask(&current->blocked, ~_BLOCKABLE);
+	current->blocked = set;
 	recalc_sigpending();
 	spin_unlock_irq(&current->sighand->siglock);
-	copy_sc_from_user(&current->thread.regs, &uc->uc_mcontext);
+
+	if(copy_sc_from_user(&current->thread.regs, &uc->uc_mcontext))
+		goto segfault;
+
 	return(PT_REGS_SYSCALL_RET(&current->thread.regs));
+
+ segfault:
+	force_sig(SIGSEGV, current);
+	return 0;
 }
 
 /*



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
