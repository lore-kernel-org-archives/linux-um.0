Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FT6u7-0008FV-VP for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Apr 2006 17:38:47 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FT6u7-0004KM-Kd
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Apr 2006 17:38:48 -0700
Message-Id: <200604102340.k3ANe2TW006880@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 4/3] UML - Add missing __volatile__
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
Date: Mon, 10 Apr 2006 19:40:02 -0400
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, S A <sagarwal10@hotmail.com>

We were missing __volatile__ on some bits of asm in the segfault
handlers.  On x86_64, this was messing up the move from %rdx to uc
because that was moved to after the GET_FAULTINFO_FROM_SC, which
changed %rdx.

Also changed the other bit of asm and the one in the i386 handler to
prevent any similar occurrences.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16-mm/arch/um/sys-x86_64/stub_segv.c
===================================================================
--- linux-2.6.16-mm.orig/arch/um/sys-x86_64/stub_segv.c	2006-01-03 17:39:46.000000000 -0500
+++ linux-2.6.16-mm/arch/um/sys-x86_64/stub_segv.c	2006-04-10 19:56:10.000000000 -0400
@@ -33,7 +33,7 @@ stub_segv_handler(int sig)
 	struct ucontext *uc;
         int pid;
 
-	__asm__("movq %%rdx, %0" : "=g" (uc) :);
+	__asm__ __volatile__("movq %%rdx, %0" : "=g" (uc) :);
 	GET_FAULTINFO_FROM_SC(*((struct faultinfo *) UML_CONFIG_STUB_DATA),
 			      &uc->uc_mcontext);
 
@@ -44,8 +44,8 @@ stub_segv_handler(int sig)
 	 * the signal frame.  So, we use the ucontext pointer, which we know
 	 * already, to get the signal frame pointer, and add 8 to that.
 	 */
-	__asm__("movq %0, %%rsp; movq %1, %%rax ; syscall": :
-		"g" ((unsigned long) container_of(uc, struct rt_sigframe, 
-						  uc) + 8),
-                "g" (__NR_rt_sigreturn));
+	__asm__ __volatile__("movq %0, %%rsp; movq %1, %%rax ; syscall": :
+                             "g" ((unsigned long)
+                                  container_of(uc, struct rt_sigframe, uc) + 8),
+                             "g" (__NR_rt_sigreturn));
 }
Index: linux-2.6.16-mm/arch/um/sys-i386/stub_segv.c
===================================================================
--- linux-2.6.16-mm.orig/arch/um/sys-i386/stub_segv.c	2006-01-03 17:39:46.000000000 -0500
+++ linux-2.6.16-mm/arch/um/sys-i386/stub_segv.c	2006-04-10 19:55:53.000000000 -0400
@@ -27,6 +27,6 @@ stub_segv_handler(int sig)
 	 * the stack in its original form when we do the sigreturn here, by
 	 * hand.
 	 */
-	__asm__("mov %0,%%esp ; movl %1, %%eax ; "
-		"int $0x80" : : "a" (sc), "g" (__NR_sigreturn));
+	__asm__ __volatile__("mov %0,%%esp ; movl %1, %%eax ; "
+			     "int $0x80" : : "a" (sc), "g" (__NR_sigreturn));
 }



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
