Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IsNnM-0001rV-6L for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Nov 2007 11:21:04 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IsNnG-0000lr-65
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Nov 2007 11:21:00 -0800
Date: Wed, 14 Nov 2007 14:20:49 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071114192049.GA9083@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 2/4] UML - Remove unused variables in the
	context switcher
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

This patch removes a variable which was not used in two functions.
Yet another code cleanup, nothing really significant.

Please note that I could not test this on x86_64. I don't have the
hardware for it.

[ jdike - Bits of tidying around the affected code.  Also, it's fine on
x86_64 ]

Signed-off-by: Karol Swietlicki <magotari@gmail.com>
Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/kernel/process.c      |   19 ++++++++-----------
 arch/um/sys-i386/ptrace.c     |    6 +++---
 arch/um/sys-i386/tls.c        |    2 +-
 arch/um/sys-x86_64/syscalls.c |    2 +-
 4 files changed, 13 insertions(+), 16 deletions(-)

Index: linux-2.6.22/arch/um/kernel/process.c
===================================================================
--- linux-2.6.22.orig/arch/um/kernel/process.c	2007-11-14 13:29:51.000000000 -0500
+++ linux-2.6.22/arch/um/kernel/process.c	2007-11-14 13:38:36.000000000 -0500
@@ -82,12 +82,12 @@ static inline void set_current(struct ta
 		{ external_pid(task), task });
 }
 
-extern void arch_switch_to(struct task_struct *from, struct task_struct *to);
+extern void arch_switch_to(struct task_struct *to);
 
 void *_switch_to(void *prev, void *next, void *last)
 {
 	struct task_struct *from = prev;
-	struct task_struct *to= next;
+	struct task_struct *to = next;
 
 	to->thread.prev_sched = from;
 	set_current(to);
@@ -95,16 +95,15 @@ void *_switch_to(void *prev, void *next,
 	do {
 		current->thread.saved_task = NULL;
 
-		switch_threads(&from->thread.switch_buf,
-			       &to->thread.switch_buf);
+		switch_threads(&from->thread.switch_buf, &to->thread.switch_buf);
 
-		arch_switch_to(current->thread.prev_sched, current);
+		arch_switch_to(current);
 
 		if (current->thread.saved_task)
 			show_regs(&(current->thread.regs));
-		next= current->thread.saved_task;
-		prev= current;
-	} while(current->thread.saved_task);
+		next = current->thread.saved_task;
+		prev = current;
+	} while (current->thread.saved_task);
 
 	return current->thread.prev_sched;
 
@@ -162,8 +161,6 @@ void new_thread_handler(void)
 void fork_handler(void)
 {
 	force_flush_all();
-	if (current->thread.prev_sched == NULL)
-		panic("blech");
 
 	schedule_tail(current->thread.prev_sched);
 
@@ -172,7 +169,7 @@ void fork_handler(void)
 	 * arch_switch_to isn't needed. We could want to apply this to
 	 * improve performance. -bb
 	 */
-	arch_switch_to(current->thread.prev_sched, current);
+	arch_switch_to(current);
 
 	current->thread.prev_sched = NULL;
 
Index: linux-2.6.22/arch/um/sys-i386/ptrace.c
===================================================================
--- linux-2.6.22.orig/arch/um/sys-i386/ptrace.c	2007-11-14 13:29:51.000000000 -0500
+++ linux-2.6.22/arch/um/sys-i386/ptrace.c	2007-11-14 13:37:30.000000000 -0500
@@ -8,11 +8,11 @@
 #include "asm/uaccess.h"
 #include "skas.h"
 
-extern int arch_switch_tls(struct task_struct *from, struct task_struct *to);
+extern int arch_switch_tls(struct task_struct *to);
 
-void arch_switch_to(struct task_struct *from, struct task_struct *to)
+void arch_switch_to(struct task_struct *to)
 {
-	int err = arch_switch_tls(from, to);
+	int err = arch_switch_tls(to);
 	if (!err)
 		return;
 
Index: linux-2.6.22/arch/um/sys-i386/tls.c
===================================================================
--- linux-2.6.22.orig/arch/um/sys-i386/tls.c	2007-11-14 13:29:51.000000000 -0500
+++ linux-2.6.22/arch/um/sys-i386/tls.c	2007-11-14 13:37:30.000000000 -0500
@@ -172,7 +172,7 @@ void clear_flushed_tls(struct task_struc
  * SKAS patch.
  */
 
-int arch_switch_tls(struct task_struct *from, struct task_struct *to)
+int arch_switch_tls(struct task_struct *to)
 {
 	if (!host_supports_tls)
 		return 0;
Index: linux-2.6.22/arch/um/sys-x86_64/syscalls.c
===================================================================
--- linux-2.6.22.orig/arch/um/sys-x86_64/syscalls.c	2007-11-14 13:29:51.000000000 -0500
+++ linux-2.6.22/arch/um/sys-x86_64/syscalls.c	2007-11-14 13:37:30.000000000 -0500
@@ -105,7 +105,7 @@ long sys_clone(unsigned long clone_flags
 	return ret;
 }
 
-void arch_switch_to(struct task_struct *from, struct task_struct *to)
+void arch_switch_to(struct task_struct *to)
 {
 	if ((to->thread.arch.fs == 0) || (to->mm == NULL))
 		return;

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
