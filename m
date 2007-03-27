Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HWGVs-0001qF-N2 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Mar 2007 11:35:21 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HWGRS-0002ly-K9
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Mar 2007 11:30:48 -0700
Date: Tue, 27 Mar 2007 14:27:47 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070327182747.GA8400@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 2/6] UML - fix compilation problems
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
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

Fix a few miscellaneous compilation problems -
	an assignment with mismatched types in ldt.c
	a missing include in mconsole.h which needs a definition of uml_pt_regs
	when auditing is configured there are some mismatched types in ptrace.c
	I missed removing an include of user_util.h in hostfs	

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/include/mconsole.h |    2 ++
 arch/um/kernel/ptrace.c    |   14 +++++++-------
 arch/um/sys-i386/ldt.c     |    3 ++-
 fs/hostfs/hostfs_kern.c    |    1 -
 4 files changed, 11 insertions(+), 9 deletions(-)

Index: linux-2.6.21-mm/arch/um/sys-i386/ldt.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/sys-i386/ldt.c	2007-03-27 12:25:16.000000000 -0400
+++ linux-2.6.21-mm/arch/um/sys-i386/ldt.c	2007-03-27 12:28:26.000000000 -0400
@@ -394,7 +394,8 @@ static short * host_ldt_entries = NULL;
 static void ldt_get_host_info(void)
 {
 	long ret;
-	struct ldt_entry * ldt, *tmp;
+	struct ldt_entry * ldt;
+	short *tmp;
 	int i, size, k, order;
 
 	spin_lock(&host_ldt_lock);
Index: linux-2.6.21-mm/arch/um/include/mconsole.h
===================================================================
--- linux-2.6.21-mm.orig/arch/um/include/mconsole.h	2007-03-27 12:25:10.000000000 -0400
+++ linux-2.6.21-mm/arch/um/include/mconsole.h	2007-03-27 12:29:28.000000000 -0400
@@ -12,6 +12,8 @@
 #define u32 uint32_t
 #endif
 
+#include "sysdep/ptrace.h"
+
 #define MCONSOLE_MAGIC (0xcafebabe)
 #define MCONSOLE_MAX_DATA (512)
 #define MCONSOLE_VERSION 2
Index: linux-2.6.21-mm/arch/um/kernel/ptrace.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/kernel/ptrace.c	2007-03-27 12:25:18.000000000 -0400
+++ linux-2.6.21-mm/arch/um/kernel/ptrace.c	2007-03-27 12:34:43.000000000 -0400
@@ -53,8 +53,8 @@ void do_syscall_trace(struct pt_regs *re
 		secure_computing(PT_REGS_SYSCALL_NR(regs));
 
 	if (unlikely(current->audit_context) && entryexit)
-		audit_syscall_exit(AUDITSC_RESULT(UPT_SYSCALL_RET(regs)),
-				   UPT_SYSCALL_RET(regs));
+		audit_syscall_exit(AUDITSC_RESULT(UPT_SYSCALL_RET(&regs->regs)),
+				   UPT_SYSCALL_RET(&regs->regs));
 
 	if (test_thread_flag(TIF_SYSCALL_TRACE))
 		tracehook_report_syscall(regs, entryexit);
@@ -66,9 +66,9 @@ void do_syscall_trace(struct pt_regs *re
 
 	if (unlikely(current->audit_context) && !entryexit)
 		audit_syscall_entry(HOST_AUDIT_ARCH,
-					    UPT_SYSCALL_NR(regs),
-					    UPT_SYSCALL_ARG1(regs),
-					    UPT_SYSCALL_ARG2(regs),
-					    UPT_SYSCALL_ARG3(regs),
-					    UPT_SYSCALL_ARG4(regs));
+				    UPT_SYSCALL_NR(&regs->regs),
+				    UPT_SYSCALL_ARG1(&regs->regs),
+				    UPT_SYSCALL_ARG2(&regs->regs),
+				    UPT_SYSCALL_ARG3(&regs->regs),
+				    UPT_SYSCALL_ARG4(&regs->regs));
 }
Index: linux-2.6.21-mm/fs/hostfs/hostfs_kern.c
===================================================================
--- linux-2.6.21-mm.orig/fs/hostfs/hostfs_kern.c	2007-03-27 12:25:11.000000000 -0400
+++ linux-2.6.21-mm/fs/hostfs/hostfs_kern.c	2007-03-27 12:34:31.000000000 -0400
@@ -20,7 +20,6 @@
 #include "hostfs.h"
 #include "kern_util.h"
 #include "kern.h"
-#include "user_util.h"
 #include "init.h"
 
 struct hostfs_inode_info {

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
