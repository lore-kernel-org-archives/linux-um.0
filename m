Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J2YVC-0001br-9i for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Dec 2007 12:48:22 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1J2YV7-0006rc-Kg
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Dec 2007 12:48:22 -0800
Date: Wed, 12 Dec 2007 15:47:58 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071212204758.GA9129@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 3/6] UML - Get rid of syscall counters
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Get rid of some syscall counters which haven't been useful in ages.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/include/kern_util.h        |    1 -
 arch/um/kernel/skas/syscall.c      |    3 ---
 arch/um/kernel/syscall.c           |    3 ---
 include/asm-um/processor-generic.h |    2 --
 4 files changed, 9 deletions(-)

Index: linux-2.6-git/arch/um/include/kern_util.h
===================================================================
--- linux-2.6-git.orig/arch/um/include/kern_util.h	2007-12-12 13:28:42.000000000 -0500
+++ linux-2.6-git/arch/um/include/kern_util.h	2007-12-12 13:36:57.000000000 -0500
@@ -13,7 +13,6 @@ extern int uml_exitcode;
 
 extern int ncpus;
 extern int kmalloc_ok;
-extern int nsyscalls;
 
 #define UML_ROUND_UP(addr) \
 	((((unsigned long) addr) + PAGE_SIZE - 1) & PAGE_MASK)
Index: linux-2.6-git/arch/um/kernel/skas/syscall.c
===================================================================
--- linux-2.6-git.orig/arch/um/kernel/skas/syscall.c	2007-12-03 23:56:34.000000000 -0500
+++ linux-2.6-git/arch/um/kernel/skas/syscall.c	2007-12-12 13:36:58.000000000 -0500
@@ -17,9 +17,6 @@ void handle_syscall(struct uml_pt_regs *
 
 	syscall_trace(r, 0);
 
-	current->thread.nsyscalls++;
-	nsyscalls++;
-
 	/*
 	 * This should go in the declaration of syscall, but when I do that,
 	 * strace -f -c bash -c 'ls ; ls' breaks, sometimes not tracing
Index: linux-2.6-git/arch/um/kernel/syscall.c
===================================================================
--- linux-2.6-git.orig/arch/um/kernel/syscall.c	2007-12-03 23:56:34.000000000 -0500
+++ linux-2.6-git/arch/um/kernel/syscall.c	2007-12-12 13:36:58.000000000 -0500
@@ -13,9 +13,6 @@
 #include "asm/uaccess.h"
 #include "asm/unistd.h"
 
-/*  Unlocked, I don't care if this is a bit off */
-int nsyscalls = 0;
-
 long sys_fork(void)
 {
 	long ret;
Index: linux-2.6-git/include/asm-um/processor-generic.h
===================================================================
--- linux-2.6-git.orig/include/asm-um/processor-generic.h	2007-12-12 13:28:42.000000000 -0500
+++ linux-2.6-git/include/asm-um/processor-generic.h	2007-12-12 13:51:08.000000000 -0500
@@ -26,7 +26,6 @@ struct thread_struct {
 	 * as of 2.6.11).
 	 */
 	int forking;
-	int nsyscalls;
 	struct pt_regs regs;
 	int singlestep_syscall;
 	void *fault_addr;
@@ -58,7 +57,6 @@ struct thread_struct {
 #define INIT_THREAD \
 { \
 	.forking		= 0, \
-	.nsyscalls		= 0, \
 	.regs		   	= EMPTY_REGS,	\
 	.fault_addr		= NULL, \
 	.prev_sched		= NULL, \

-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services
for just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
