Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EAxvy-0007Fg-8u	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Sep 2005 15:53:26 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EAxvw-0007Pq-LM
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Sep 2005 15:53:26 -0700
Message-Id: <200509012216.j81MGvcQ011525@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 2/12] UML - x86_64 build fix
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
Date: Thu, 01 Sep 2005 18:16:57 -0400
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

semaphore.c is no longer available from arch/x86_64, so we just pick up the
generic version instead.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.13-mm1/arch/um/sys-x86_64/Makefile
===================================================================
--- linux-2.6.13-mm1.orig/arch/um/sys-x86_64/Makefile	2005-09-01 15:52:25.000000000 -0400
+++ linux-2.6.13-mm1/arch/um/sys-x86_64/Makefile	2005-09-01 15:53:04.000000000 -0400
@@ -6,7 +6,7 @@
 
 #XXX: why into lib-y?
 lib-y = bitops.o bugs.o csum-partial.o delay.o fault.o mem.o memcpy.o \
-	ptrace.o ptrace_user.o semaphore.o sigcontext.o signal.o stub.o \
+	ptrace.o ptrace_user.o sigcontext.o signal.o stub.o \
 	stub_segv.o syscalls.o syscall_table.o sysrq.o thunk.o
 
 obj-y := ksyms.o
@@ -15,7 +15,7 @@
 USER_OBJS := ptrace_user.o sigcontext.o
 
 SYMLINKS = bitops.c csum-copy.S csum-partial.c csum-wrappers.c memcpy.S \
-	semaphore.c thunk.S module.c
+	thunk.S module.c
 
 include arch/um/scripts/Makefile.rules
 
@@ -24,7 +24,6 @@
 csum-partial.c-dir = lib
 csum-wrappers.c-dir = lib
 memcpy.S-dir = lib
-semaphore.c-dir = kernel
 thunk.S-dir = lib
 module.c-dir = kernel



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
