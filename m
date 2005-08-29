Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E9q0o-0001bH-UZ	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Aug 2005 13:13:46 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E9q0n-0002yO-6F
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Aug 2005 13:13:46 -0700
Message-Id: <200508292007.j7TK7HmD029954@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 9/9] UML - Remove debugging code
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
Date: Mon, 29 Aug 2005 16:07:17 -0400
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

This removes some long-unused debugging code.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: test/arch/um/kernel/trap_kern.c
===================================================================
--- test.orig/arch/um/kernel/trap_kern.c	2005-06-17 15:48:29.000000000 -0400
+++ test/arch/um/kernel/trap_kern.c	2005-08-29 13:06:43.000000000 -0400
@@ -200,30 +200,3 @@
 void trap_init(void)
 {
 }
-
-DEFINE_SPINLOCK(trap_lock);
-
-static int trap_index = 0;
-
-int next_trap_index(int limit)
-{
-	int ret;
-
-	spin_lock(&trap_lock);
-	ret = trap_index;
-	if(++trap_index == limit)
-		trap_index = 0;
-	spin_unlock(&trap_lock);
-	return(ret);
-}
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
Index: test/arch/um/kernel/trap_user.c
===================================================================
--- test.orig/arch/um/kernel/trap_user.c	2005-06-17 15:48:29.000000000 -0400
+++ test/arch/um/kernel/trap_user.c	2005-08-29 13:06:43.000000000 -0400
@@ -40,35 +40,14 @@
 	} while(1);
 }
 
-/* Unlocked - don't care if this is a bit off */
-int nsegfaults = 0;
-
-struct {
-	unsigned long address;
-	int is_write;
-	int pid;
-	unsigned long sp;
-	int is_user;
-} segfault_record[1024];
-
 void segv_handler(int sig, union uml_pt_regs *regs)
 {
-	int index, max;
         struct faultinfo * fi = UPT_FAULTINFO(regs);
 
         if(UPT_IS_USER(regs) && !SEGV_IS_FIXABLE(fi)){
                 bad_segv(*fi, UPT_IP(regs));
 		return;
 	}
-	max = sizeof(segfault_record)/sizeof(segfault_record[0]);
-	index = next_trap_index(max);
-
-	nsegfaults++;
-        segfault_record[index].address = FAULT_ADDRESS(*fi);
-	segfault_record[index].pid = os_getpid();
-        segfault_record[index].is_write = FAULT_WRITE(*fi);
-	segfault_record[index].sp = UPT_SP(regs);
-	segfault_record[index].is_user = UPT_IS_USER(regs);
         segv(*fi, UPT_IP(regs), UPT_IS_USER(regs), regs);
 }
 



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
