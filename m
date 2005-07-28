Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DyBLV-0000Tg-Jf	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Jul 2005 09:34:57 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1DyBLV-0000YV-92
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Jul 2005 09:34:57 -0700
Message-Id: <200507281626.j6SGQicv009476@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 2/7] UML - Fix skas0 stub return
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
Date: Thu, 28 Jul 2005 12:26:44 -0400
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

It's wrong to pop a fixed number of words from stack before
calling sigreturn, as the number depends on what code is generated
by the compiler for the start of stub_segv_handler().
What we need is esp containing the address of sigcontext. So we
explicitly load that pointer into esp.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12-rc3-mm2/arch/um/sys-i386/stub_segv.c
===================================================================
--- linux-2.6.12-rc3-mm2.orig/arch/um/sys-i386/stub_segv.c	2005-07-27 17:22:18.000000000 -0400
+++ linux-2.6.12-rc3-mm2/arch/um/sys-i386/stub_segv.c	2005-07-28 10:35:18.000000000 -0400
@@ -21,10 +21,10 @@
 	__asm__("movl %0, %%eax ; int $0x80": : "g" (__NR_getpid));
 	__asm__("movl %%eax, %%ebx ; movl %0, %%eax ; movl %1, %%ecx ;"
 		"int $0x80": : "g" (__NR_kill), "g" (SIGUSR1));
-	/* Pop the frame pointer and return address since we need to leave
+	/* Load pointer to sigcontext into esp, since we need to leave
 	 * the stack in its original form when we do the sigreturn here, by
 	 * hand.
 	 */
-	__asm__("popl %%eax ; popl %%eax ; popl %%eax ; movl %0, %%eax ; "
-		"int $0x80" : : "g" (__NR_sigreturn));
+	__asm__("mov %0,%%esp ; movl %1, %%eax ; "
+		"int $0x80" : : "a" (sc), "g" (__NR_sigreturn));
 }



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
