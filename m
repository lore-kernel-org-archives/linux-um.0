Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CD75O-0000Cj-9i for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 30 Sep 2004 12:59:30 -0700
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CD75N-0003mG-1w for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 30 Sep 2004 12:59:30 -0700
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Message-ID: <8B6FF516CBA0194AB0996705076B02520F7C40@ABGEX01E.abg.fsc.net>
From: "Stroesser, Bodo" <Bodo.Stroesser@fujitsu-siemens.com>
Subject: [uml-devel] Signal handling: use the kernels restorer
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
Date: Thu, 30 Sep 2004 21:59:08 +0200
Content-Transfer-Encoding: 8bit
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, BlaisorBlade <blaisorblade_spam@yahoo.it>

Normally, with each call to sigaction() glibc set the flag SA_RESTORER
and gives the address of the restorer it wants to use to the kernel. If
the user specifies his own restorer, this one is used instead.
But if a user directly calls sys_sigaction() without glibc being
involved (e.g. via "int 0x80"), he can reset SA_RESTORER. Now the kernel
should use it's own restorer-stub. On i386 it's located in the
vsyscall-page. UML must use the old method of putting it onto the stack.
The patch modifies the signal-stack-setup to get the restorer on the
stack working. It is also a 1st step to enabling the syscall-page in
UML. (Just replace the addresses on the stack with the addresses from
the syscall-page)

While testing that stuff, I could crash UML by using the wrong
systemcall-number in the restorer-stub (has been wrong for
sys_sigreturn). I think, there is no check in sys_(rt_)sigreturn(),
whether the contents of the stack is wrong. But why should this crash
the kernel? Unfortunately at the moment I can't see, what UML prints
out, because messages to console are not displayed (don't know why,
yet). If the system runs, I can use dmesg, but when it is crashed ...

Bodo


--- orig/arch/um/include/frame_kern.h	2004-09-30 21:01:10.101299289
+0200
+++ new/arch/um/include/frame_kern.h	2004-09-30 21:01:54.321991562
+0200
@@ -10,13 +10,11 @@
 #define _BLOCKABLE (~(_S(SIGKILL) | _S(SIGSTOP)))
 
 extern int setup_signal_stack_sc(unsigned long stack_top, int sig, 
-				 unsigned long handler,
-				 void (*restorer)(void), 
+				 struct k_sigaction * ka,
 				 struct pt_regs *regs, 
 				 sigset_t *mask);
 extern int setup_signal_stack_si(unsigned long stack_top, int sig, 
-				 unsigned long handler, 
-				 void (*restorer)(void), 
+				 struct k_sigaction * ka,
 				 struct pt_regs *regs, siginfo_t *info, 
 				 sigset_t *mask);
 
--- orig/arch/um/kernel/signal_kern.c	2004-09-30 20:48:00.055858897
+0200
+++ new/arch/um/kernel/signal_kern.c	2004-09-30 21:07:11.038652291
+0200
@@ -42,7 +42,6 @@
 			  struct k_sigaction *ka, siginfo_t *info, 
 			  sigset_t *oldset)
 {
-	void (*restorer)(void);
 	unsigned long sp;
 	int err;
 
@@ -75,18 +74,10 @@
 	if((ka->sa.sa_flags & SA_ONSTACK) && (sas_ss_flags(sp) == 0))
 		sp = current->sas_ss_sp + current->sas_ss_size;
 
-	if (ka->sa.sa_flags & SA_RESTORER) 
-		restorer = ka->sa.sa_restorer;
-	else restorer = NULL;
-
 	if(ka->sa.sa_flags & SA_SIGINFO)
-		err = setup_signal_stack_si(sp, signr, 
-					    (unsigned long)
ka->sa.sa_handler,
-					    restorer, regs, info,
oldset);
+		err = setup_signal_stack_si(sp, signr, ka, regs, info,
oldset);
 	else
-		err = setup_signal_stack_sc(sp, signr, 
-					    (unsigned long)
ka->sa.sa_handler,
-					    restorer, regs, oldset);
+		err = setup_signal_stack_sc(sp, signr, ka, regs,
oldset);
 
 	if(err) {
 		spin_lock_irq(&current->sighand->siglock);
--- orig/arch/um/sys-i386/signal.c	2004-09-30 20:50:34.493337205
+0200
+++ new/arch/um/sys-i386/signal.c	2004-09-30 21:20:31.572359436
+0200
@@ -201,10 +201,11 @@
 };
 
 int setup_signal_stack_sc(unsigned long stack_top, int sig, 
-			  unsigned long handler, void (*restorer)(void),

+			  struct k_sigaction * ka,
 			  struct pt_regs *regs, sigset_t *mask)
 {
 	struct sigframe __user *frame;
+	void * restorer;
 	int err = 0;
 
 	stack_top &= -8UL;
@@ -212,6 +213,9 @@
 	if(verify_area(VERIFY_WRITE, frame, sizeof(*frame)))
 		return(1);
 	
+	restorer = (void *)frame->retcode;
+	if ( ka->sa.sa_flags & SA_RESTORER )
+		restorer = ka->sa.sa_restorer;
 	err |= __put_user(restorer, &frame->pretcode);
 	err |= __put_user(sig, &frame->sig);
 	err |= copy_sc_to_user(&frame->sc, NULL, regs);
@@ -221,21 +225,21 @@
 				      sizeof(frame->extramask));
 
 	/*
-	 * This is movl $,%eax ; int $0x80
+	 * This is popl %eax ; movl $,%eax ; int $0x80
 	 *
 	 * WE DO NOT USE IT ANY MORE! It's only left here for historical
 	 * reasons and because gdb uses it as a signature to notice
 	 * signal handler stack frames.
 	 */
-	err |= __put_user(0xb8, (char __user *)(frame->retcode+0));
-	err |= __put_user(__NR_rt_sigreturn, (int __user
*)(frame->retcode+1));
-	err |= __put_user(0x80cd, (short __user *)(frame->retcode+5));
+	err |= __put_user(0xb858, (short __user *)(frame->retcode+0));
+	err |= __put_user(__NR_sigreturn, (int __user
*)(frame->retcode+2));
+	err |= __put_user(0x80cd, (short __user *)(frame->retcode+6));
 
 	if(err)
 		return(err);
 
 	PT_REGS_SP(regs) = (unsigned long) frame;
-	PT_REGS_IP(regs) = (unsigned long) handler;
+	PT_REGS_IP(regs) = (unsigned long) ka->sa.sa_handler;
 	PT_REGS_EAX(regs) = (unsigned long) sig;
 	PT_REGS_EDX(regs) = (unsigned long) 0;
 	PT_REGS_ECX(regs) = (unsigned long) 0;
@@ -243,11 +247,12 @@
 }
 
 int setup_signal_stack_si(unsigned long stack_top, int sig, 
-			  unsigned long handler, void (*restorer)(void),

+			  struct k_sigaction * ka,
 			  struct pt_regs *regs, siginfo_t *info, 
 			  sigset_t *mask)
 {
 	struct rt_sigframe __user *frame;
+	void * restorer;
 	int err = 0;
 
 	stack_top &= -8UL;
@@ -255,6 +260,9 @@
 	if(verify_area(VERIFY_WRITE, frame, sizeof(*frame)))
 		return(1);
 	
+	restorer = (void *)frame->retcode;
+	if ( ka->sa.sa_flags & SA_RESTORER )
+		restorer = ka->sa.sa_restorer;
 	err |= __put_user(restorer, &frame->pretcode);
 	err |= __put_user(sig, &frame->sig);
 	err |= __put_user(&frame->info, &frame->pinfo);
@@ -278,7 +286,7 @@
 		return(err);
 
 	PT_REGS_SP(regs) = (unsigned long) frame;
-	PT_REGS_IP(regs) = (unsigned long) handler;
+	PT_REGS_IP(regs) = (unsigned long) ka->sa.sa_handler;
 	PT_REGS_EAX(regs) = (unsigned long) sig;
 	PT_REGS_EDX(regs) = (unsigned long) &frame->info;
 	PT_REGS_ECX(regs) = (unsigned long) &frame->uc;


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
