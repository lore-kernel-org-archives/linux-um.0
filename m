Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1InydJ-0000CZ-TT for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Nov 2007 08:40:30 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1InydH-0005Ue-9R
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Nov 2007 08:40:29 -0700
Date: Fri, 2 Nov 2007 11:40:14 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071102154014.GA10263@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 3/6] UML - Improve detection of host cmov
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
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Karol Swietlicki <magotari@gmail.com>

From: Karol Swietlicki <magotari@gmail.com>

This patch introduces a new way of checking for the cmov instruction.
I use signal handling instead of reading /proc/cpuinfo.

[ jdike - Fiddled the asm to make it obvious that it didn't mess with
any in-use registers and made test_for_host_cmov void ]

Signed-off-by: Karol Swietlicki <magotari@gmail.com>
Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/sys-i386/bugs.c |   41 ++++++++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 9 deletions(-)

Index: linux-2.6.22/arch/um/sys-i386/bugs.c
===================================================================
--- linux-2.6.22.orig/arch/um/sys-i386/bugs.c	2007-10-30 12:31:35.000000000 -0400
+++ linux-2.6.22/arch/um/sys-i386/bugs.c	2007-10-31 11:24:45.000000000 -0400
@@ -10,11 +10,42 @@
 #include "os.h"
 #include "task.h"
 #include "user.h"
+#include "sysdep/archsetjmp.h"
 
 #define MAXTOKEN 64
 
 /* Set during early boot */
 int host_has_cmov = 1;
+static jmp_buf cmov_test_return;
+
+static void cmov_sigill_test_handler(int sig)
+{
+	host_has_cmov = 0;
+	longjmp(cmov_test_return, 1);
+}
+
+static void test_for_host_cmov(void)
+{
+	struct sigaction old, new;
+
+	printk(UM_KERN_INFO "Checking for host processor cmov support...");
+	new.sa_handler = cmov_sigill_test_handler;
+
+	/* Make sure that SIGILL is enabled after the handler longjmps back */
+	new.sa_flags = SA_NODEFER;
+	sigemptyset(&new.sa_mask);
+	sigaction(SIGILL, &new, &old);
+
+	if (setjmp(cmov_test_return) == 0) {
+		unsigned long foo = 0;
+		__asm__ __volatile__("cmovz %0, %1" : "=r" (foo) : "0" (foo));
+		printk("Yes\n");
+	}
+	else
+		printk("No\n");
+
+	sigaction(SIGILL, &old, &new);
+}
 
 static char token(int fd, char *buf, int len, char stop)
 {
@@ -153,15 +184,7 @@ void arch_init_thread(void)
 
 void arch_check_bugs(void)
 {
-	int have_it;
-
-	if (os_access("/proc/cpuinfo", OS_ACC_R_OK) < 0) {
-		printk(UM_KERN_ERR "/proc/cpuinfo not available - skipping CPU "
-		       "capability checks\n");
-		return;
-	}
-	if (check_cpu_flag("cmov", &have_it))
-		host_has_cmov = have_it;
+	test_for_host_cmov();
 }
 
 int arch_handle_signal(int sig, struct uml_pt_regs *regs)

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
