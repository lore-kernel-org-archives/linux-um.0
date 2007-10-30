Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Imutd-0001oz-Eb for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Oct 2007 10:28:59 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Imutc-00051H-Rw
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Oct 2007 10:28:57 -0700
Date: Tue, 30 Oct 2007 13:28:49 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071030172849.GA8367@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 3/4] UML - Implement get_wchan
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

Implement get_wchan - the algorithm is similar to x86.  It starts with
the stack pointer of the process in question and looks above that for
addresses that are kernel text.  The second one which isn't in the
scheduler is the one that's returned.  The first one is ignored
because that will be UML's own context switching routine.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/kernel/process.c           |   37 +++++++++++++++++++++++++++++++++++++
 include/asm-um/processor-generic.h |    2 +-
 2 files changed, 38 insertions(+), 1 deletion(-)

Index: linux-2.6.22/arch/um/kernel/process.c
===================================================================
--- linux-2.6.22.orig/arch/um/kernel/process.c	2007-10-29 15:28:25.000000000 -0400
+++ linux-2.6.22/arch/um/kernel/process.c	2007-10-29 15:49:43.000000000 -0400
@@ -459,3 +459,40 @@ unsigned long arch_align_stack(unsigned 
 	return sp & ~0xf;
 }
 #endif
+
+unsigned long get_wchan(struct task_struct *p)
+{
+	unsigned long stack_page, sp, ip, count = 0;
+
+	if ((p == NULL) || (p == current) || (p->state == TASK_RUNNING))
+		return 0;
+
+	stack_page = (unsigned long) task_stack_page(p);
+	/* Bail if the process has no kernel stack for some reason */
+	if (stack_page == 0)
+		return 0;
+
+	sp = p->thread.switch_buf->JB_SP;
+	/*
+	 * Bail if the stack pointer is below the bottom of the kernel
+	 * stack for some reason
+	 */
+	if (sp < stack_page)
+		return 0;
+
+	while (sp < stack_page + THREAD_SIZE) {
+		ip = *((unsigned long *) sp);
+		if (kernel_text_address(ip) && !in_sched_functions(ip)) {
+			/*
+			 * Skip one valid IP, which will be the low-level UML
+			 * context switcher.
+			 */
+			if (count++ == 1)
+				return ip;
+		}
+
+		sp += sizeof(unsigned long);
+	}
+
+	return 0;
+}
Index: linux-2.6.22/include/asm-um/processor-generic.h
===================================================================
--- linux-2.6.22.orig/include/asm-um/processor-generic.h	2007-10-29 15:28:25.000000000 -0400
+++ linux-2.6.22/include/asm-um/processor-generic.h	2007-10-29 15:28:57.000000000 -0400
@@ -128,6 +128,6 @@ extern struct cpuinfo_um cpu_data[];
 
 
 #define KSTK_REG(tsk, reg) get_thread_reg(reg, &tsk->thread.switch_buf)
-#define get_wchan(p) (0)
+extern unsigned long get_wchan(struct task_struct *p);
 
 #endif

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
