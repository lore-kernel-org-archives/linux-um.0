Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CD2De-00031D-2Z for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 30 Sep 2004 07:47:42 -0700
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CD2Dc-0007ZV-P8 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 30 Sep 2004 07:47:41 -0700
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Message-ID: <8B6FF516CBA0194AB0996705076B02520F7C3E@ABGEX01E.abg.fsc.net>
From: "Stroesser, Bodo" <Bodo.Stroesser@fujitsu-siemens.com>
Subject: [uml-devel] Signal handling: signal mask incorrect after segfault
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
Date: Thu, 30 Sep 2004 16:31:37 +0200
Content-Transfer-Encoding: 8bit
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, BlaisorBlade <blaisorblade_spam@yahoo.it>

A new patch:

If the user stack limit is reached or the signal stack assigned with
sigaltstack() is invalid when a user signal handler with SA_ONSTACK has
to be started, the signal mask of the interrupted user program is
modified. This happens because the mask, that should be used with the
handler only, is written to "current->blocked" even if the handler could
not be started. But without a handler, no rewrite of the original mask
at sys_sigreturn will be done.
A slightly different case is sys_sigsuspend(), where the mask is already
modified when kern_do_signal() is started. "*oldset" and
"current->blocked" are not equal here and thus current->blocked has to
be set to *oldset, if an error occurs in handle_signal().
For both cases I've written small tests, and with the patch the result
is OK.
This issue is relevant for other architectures too (e.g. i386, I've
seen).

The last two hunks are for simplification in do_signal() and
kern_do_signal() only.

Bodo


--- arch/um/kernel/signal_kern.c.orig	2004-09-30 15:13:49.488331887
+0200
+++ arch/um/kernel/signal_kern.c	2004-09-30 16:06:43.918738785
+0200
@@ -88,7 +88,14 @@
 					    (unsigned long)
ka->sa.sa_handler,
 					    restorer, regs, oldset);
 
-	if (!(ka->sa.sa_flags & SA_NODEFER)) {
+	if(err) {
+		spin_lock_irq(&current->sighand->siglock);
+		current->blocked = *oldset;
+		recalc_sigpending();
+		spin_unlock_irq(&current->sighand->siglock);
+		force_sigsegv(signr, current);
+	}
+	else if (!(ka->sa.sa_flags & SA_NODEFER)) {
 		spin_lock_irq(&current->sighand->siglock);
 		sigorsets(&current->blocked, &current->blocked, 
 			  &ka->sa.sa_mask);
@@ -96,9 +103,6 @@
 		recalc_sigpending();
 		spin_unlock_irq(&current->sighand->siglock);
 	}
-
-	if(err)
-		force_sigsegv(signr, current);
 }
 
 static int kern_do_signal(struct pt_regs *regs, sigset_t *oldset)
@@ -107,9 +111,6 @@
 	siginfo_t info;
 	int sig;
 
-	if (!oldset)
-		oldset = &current->blocked;
-
 	sig = get_signal_to_deliver(&info, &ka_copy, regs, NULL);
 	if(sig > 0){
 		/* Whee!  Actually deliver the signal.  */
@@ -147,7 +148,7 @@
 
 int do_signal(void)
 {
-	return(kern_do_signal(&current->thread.regs, NULL));
+	return(kern_do_signal(&current->thread.regs,
&current->blocked));
 }
 
 /*


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
