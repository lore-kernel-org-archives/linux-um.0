Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EL1C6-0007FZ-01	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Sep 2005 09:23:38 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EL1C5-0004eS-Gc
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Sep 2005 09:23:38 -0700
Received: from ccure.user-mode-linux.org (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.11.2) with ESMTP id j8TFIlm04252
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 29 Sep 2005 11:18:47 -0400
Received: from ccure.user-mode-linux.org (localhost.localdomain [127.0.0.1])
	j8TGGI13031039	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 29 Sep 2005 12:16:18 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20050929161617.GA30460@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] [PATCH] Early x86_64 crash
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
Date: Thu, 29 Sep 2005 12:16:17 -0400
To: user-mode-linux-devel@lists.sourceforge.net

If you are running UML/x86_64 and are seeing it crash before starting init,
I'd like you to do the following:
	- make sure that you have CONFIG_FRAME_POINTER disabled
	- enable it and see that UML boots
	- apply the patch below, disable CONFIG_FRAME_POINTER again, and
see if UML still boots
	- report results back to me

				Jeff

Index: test/arch/um/sys-x86_64/stub_segv.c
===================================================================
--- test.orig/arch/um/sys-x86_64/stub_segv.c	2005-09-29 12:19:07.000000000 -0400
+++ test/arch/um/sys-x86_64/stub_segv.c	2005-09-29 12:21:03.000000000 -0400
@@ -11,6 +11,16 @@
 #include "sysdep/sigcontext.h"
 #include "sysdep/faultinfo.h"
 
+/* Copied from sys-x86_64/signal.c - Can't find an equivalent definition
+ * in the libc headers anywhere.
+ */
+struct rt_sigframe
+{
+        char *pretcode;
+        struct ucontext uc;
+        struct siginfo info;
+};
+
 void __attribute__ ((__section__ (".__syscall_stub")))
 stub_segv_handler(int sig)
 {
@@ -22,11 +32,14 @@
 
 	__asm__("movq %0, %%rax ; syscall": : "g" (__NR_getpid));
 	__asm__("movq %%rax, %%rdi ; movq %0, %%rax ; movq %1, %%rsi ;"
-		"syscall": : "g" (__NR_kill), "g" (SIGUSR1));
-	/* Two popqs to restore the stack to the state just before entering
-	 * the handler, one pops the return address, the other pops the frame
-	 * pointer.
+		"syscall": : "g" (__NR_kill), "g" (SIGUSR1) : 
+                "%rdi", "%rax", "%rsi");
+	/* sys_sigreturn expects that the stack pointer will be 8 bytes into
+	 * the signal frame.  So, we use the ucontext pointer, which we know
+	 * already, to get the signal frame pointer, and add 8 to that.
 	 */
-	__asm__("popq %%rax ; popq %%rax ; movq %0, %%rax ; syscall" : : "g"
-		(__NR_rt_sigreturn));
+        __asm__("movq %0, %%rsp": : 
+                "g" ((unsigned long) container_of(uc, struct rt_sigframe, 
+						  uc) + 8));
+	__asm__("movq %0, %%rax ; syscall" : : "g" (__NR_rt_sigreturn));
 }


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
