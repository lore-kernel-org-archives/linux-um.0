Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8Mek-0007Pd-Vw for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Mar 2005 10:08:38 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D8Mej-0002CR-LR for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Mar 2005 10:08:38 -0800
Message-Id: <200503072038.j27Kcnbc004003@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 13/16] UML - Remove mm_indirect reference in
	modify_ldt
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
Date: Mon, 07 Mar 2005 15:38:49 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Spotted by Al Viro, there was some bogosity in the UML/x86_64 modify_ltd.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/sys-x86_64/syscalls.c
===================================================================
--- linux-2.6.11.orig/arch/um/sys-x86_64/syscalls.c	2005-03-05 12:07:31.000000000 -0500
+++ linux-2.6.11/arch/um/sys-x86_64/syscalls.c	2005-03-05 12:21:27.000000000 -0500
@@ -36,15 +36,11 @@
 #endif
 
 #ifdef CONFIG_MODE_SKAS
-extern int userspace_pid;
-
-#ifndef __NR_mm_indirect
-#define __NR_mm_indirect 241
-#endif
+extern int userspace_pid[];
 
 long sys_modify_ldt_skas(int func, void *ptr, unsigned long bytecount)
 {
-	unsigned long args[6];
+	struct ptrace_ldt ldt;
         void *buf;
         int res, n;
 
@@ -66,12 +62,11 @@
                 goto out;
         }
 
-	args[0] = func;
-	args[1] = (unsigned long) buf;
-	args[2] = bytecount;
-	res = syscall(__NR_mm_indirect, &current->mm->context.u,
-		      __NR_modify_ldt, args);
-
+	ldt = ((struct ptrace_ldt) { .func	= func,
+				     .ptr	= buf,
+				     .bytecount = bytecount });
+#warning Need to look up userspace_pid by cpu
+	res = ptrace(PTRACE_LDT, userspace_pid[0], 0, (unsigned long) &ldt);
         if(res < 0)
                 goto out;
 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
