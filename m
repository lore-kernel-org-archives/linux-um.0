Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CD2tw-0003BU-Hx for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 30 Sep 2004 08:31:24 -0700
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CD2tu-0005SQ-Db for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 30 Sep 2004 08:31:24 -0700
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Message-ID: <8B6FF516CBA0194AB0996705076B02520F7C3F@ABGEX01E.abg.fsc.net>
From: "Stroesser, Bodo" <Bodo.Stroesser@fujitsu-siemens.com>
Subject: [uml-devel] Signal handling: deliver segfault immediately
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
Date: Thu, 30 Sep 2004 17:29:06 +0200
Content-Transfer-Encoding: 8bit
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, BlaisorBlade <blaisorblade_spam@yahoo.it>

This one covers the fact, that the SIGSEGV signal, which is created by
force_sigsegv() in case of an error in handle_signal(), is not delivered
to the user immediately. In the worst case it even could be masked if a
sigprocmask() systemcall follows immediately after return from kernel.
The patch is relevant for other architectures, too.

As a further consequence of the patch the first instruction of a signal
handler will be checked for a system call, if the process should be
singlestepped (not a big risk, but better close the hole, I think). If
you don't want this, replace the "break" by "return 1".

Bodo


--- arch/um/kernel/signal_kern.c.orig	2004-09-30 16:34:07.610109219
+0200
+++ arch/um/kernel/signal_kern.c	2004-09-30 16:51:51.743255023
+0200
@@ -38,7 +38,7 @@
 /*
  * OK, we're invoking a handler
  */	
-static void handle_signal(struct pt_regs *regs, unsigned long signr, 
+static int  handle_signal(struct pt_regs *regs, unsigned long signr, 
 			  struct k_sigaction *ka, siginfo_t *info, 
 			  sigset_t *oldset)
 {
@@ -103,23 +103,25 @@
 		recalc_sigpending();
 		spin_unlock_irq(&current->sighand->siglock);
 	}
+
+	return err;
 }
 
 static int kern_do_signal(struct pt_regs *regs, sigset_t *oldset)
 {
 	struct k_sigaction ka_copy;
 	siginfo_t info;
-	int sig;
+	int sig, handled_sig = 0;
 
-	sig = get_signal_to_deliver(&info, &ka_copy, regs, NULL);
-	if(sig > 0){
+	while ( (sig = get_signal_to_deliver(&info, &ka_copy, regs,
NULL)) ) {
+		handled_sig = 1;
 		/* Whee!  Actually deliver the signal.  */
-		handle_signal(regs, sig, &ka_copy, &info, oldset);
-		return(1);
+		if ( ! handle_signal(regs, sig, &ka_copy, &info, oldset)
)
+			break;
 	}
 
 	/* Did we come from a system call? */
-	if(PT_REGS_SYSCALL_NR(regs) >= 0){
+	if(!handled_sig && PT_REGS_SYSCALL_NR(regs) >= 0){
 		/* Restart the system call - no handlers present */
 		if(PT_REGS_SYSCALL_RET(regs) == -ERESTARTNOHAND ||
 		   PT_REGS_SYSCALL_RET(regs) == -ERESTARTSYS ||
@@ -143,7 +145,8 @@
 	if((current->ptrace & PT_DTRACE) && 
 	   is_syscall(PT_REGS_IP(&current->thread.regs)))
  		(void)
CHOOSE_MODE(current->thread.mode.tt.singlestep_syscall = 1, 0);
-	return(0);
+
+	return( handled_sig);
 }
 
 int do_signal(void)


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
