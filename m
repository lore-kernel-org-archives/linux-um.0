Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8Mel-0007Pj-F2 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Mar 2005 10:08:39 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D8Mek-0002Cg-TL for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Mar 2005 10:08:39 -0800
Message-Id: <200503072038.j27Kcrbc004008@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 14/16] UML - Fix a compile failure
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
Date: Mon, 07 Mar 2005 15:38:53 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Remove a UML/x86_64 warning (and build failure if CONFIG_MODE_TT is disabled).

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/sys-x86_64/ptrace_user.c
===================================================================
--- linux-2.6.11.orig/arch/um/sys-x86_64/ptrace_user.c	2005-03-05 12:07:33.000000000 -0500
+++ linux-2.6.11/arch/um/sys-x86_64/ptrace_user.c	2005-03-05 12:23:46.000000000 -0500
@@ -42,23 +42,12 @@
 void arch_leave_kernel(void *task, int pid)
 {
 #ifdef UM_USER_CS
-	if(ptrace(PTRACE_POKEUSER, pid, CS, UM_USER_CS) < 0)
-		tracer_panic("POKEUSER CS failed");
+        if(ptrace(PTRACE_POKEUSER, pid, CS, UM_USER_CS) < 0)
+                printk("POKEUSR CS failed");
 #endif
 
-	if(ptrace(PTRACE_POKEUSER, pid, DS, __USER_DS) < 0)
-		tracer_panic("POKEUSER DS failed");
-	if(ptrace(PTRACE_POKEUSER, pid, ES, __USER_DS) < 0)
-		tracer_panic("POKEUSER ES failed");
+        if(ptrace(PTRACE_POKEUSER, pid, DS, __USER_DS) < 0)
+                printk("POKEUSR DS failed");
+        if(ptrace(PTRACE_POKEUSER, pid, ES, __USER_DS) < 0)
+                printk("POKEUSR ES failed");
 }
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
