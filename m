Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IGhqh-0003as-Us for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 02 Aug 2007 14:04:47 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IGhqh-0000cH-4u
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 02 Aug 2007 14:04:47 -0700
Date: Thu, 2 Aug 2007 17:04:38 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070802210438.GA11184@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 4/6] UML - Stop specially protecting kernel stacks
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

Map all of physical memory as executable to avoid having to change
stack protections during fork and exit.

unprotect_stack is now called only from MODE_TT code, so it is marked
as such.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/include/kern_util.h |    2 ++
 arch/um/kernel/init_task.c  |    2 ++
 arch/um/kernel/physmem.c    |    2 +-
 arch/um/kernel/process.c    |    5 ++---
 4 files changed, 7 insertions(+), 4 deletions(-)

Index: linux-2.6.21-mm/arch/um/kernel/physmem.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/kernel/physmem.c	2007-08-02 16:43:17.000000000 -0400
+++ linux-2.6.21-mm/arch/um/kernel/physmem.c	2007-08-02 16:43:25.000000000 -0400
@@ -105,7 +105,7 @@ void __init setup_physmem(unsigned long 
 
 	offset = uml_reserved - uml_physmem;
 	err = os_map_memory((void *) uml_reserved, physmem_fd, offset,
-			    len - offset, 1, 1, 0);
+			    len - offset, 1, 1, 1);
 	if(err < 0){
 		os_print_error(err, "Mapping memory");
 		exit(1);
Index: linux-2.6.21-mm/arch/um/kernel/process.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/kernel/process.c	2007-08-02 16:43:17.000000000 -0400
+++ linux-2.6.21-mm/arch/um/kernel/process.c	2007-08-02 16:43:25.000000000 -0400
@@ -82,9 +82,9 @@ unsigned long alloc_stack(int order, int
 	if (atomic)
 		flags = GFP_ATOMIC;
 	page = __get_free_pages(flags, order);
-	if(page == 0)
+	if (page == 0)
 		return 0;
-	stack_protections(page);
+
 	return page;
 }
 
@@ -141,7 +141,6 @@ void release_thread(struct task_struct *
 
 void exit_thread(void)
 {
-	unprotect_stack((unsigned long) current_thread);
 }
 
 void *get_current(void)
Index: linux-2.6.21-mm/arch/um/include/kern_util.h
===================================================================
--- linux-2.6.21-mm.orig/arch/um/include/kern_util.h	2007-08-02 16:43:17.000000000 -0400
+++ linux-2.6.21-mm/arch/um/include/kern_util.h	2007-08-02 16:43:25.000000000 -0400
@@ -82,7 +82,9 @@ extern void check_stack_overflow(void *p
 extern void relay_signal(int sig, union uml_pt_regs *regs);
 extern int user_context(unsigned long sp);
 extern void timer_irq(union uml_pt_regs *regs);
+#ifdef CONFIG_MODE_TT
 extern void unprotect_stack(unsigned long stack);
+#endif
 extern void do_uml_exitcalls(void);
 extern int attach_debugger(int idle_pid, int pid, int stop);
 extern int config_gdb(char *str);
Index: linux-2.6.21-mm/arch/um/kernel/init_task.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/kernel/init_task.c	2007-08-02 16:43:17.000000000 -0400
+++ linux-2.6.21-mm/arch/um/kernel/init_task.c	2007-08-02 16:43:25.000000000 -0400
@@ -47,7 +47,9 @@ union thread_union cpu0_irqstack
 	__attribute__((__section__(".data.init_irqstack"))) =
 		{ INIT_THREAD_INFO(init_task) };
 
+#ifdef CONFIG_MODE_TT
 void unprotect_stack(unsigned long stack)
 {
 	os_protect_memory((void *) stack, THREAD_SIZE, 1, 1, 0);
 }
+#endif

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
