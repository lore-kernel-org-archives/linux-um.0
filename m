Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPWr6-0004jw-8U for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 17:56:04 -0800
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]
	helo=zion.localdomain)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CPWr4-0004NL-CA for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 17:56:04 -0800
From: blaisorblade_spam@yahoo.it
Message-Id: <20041103231742.8D7B855C7F@zion.localdomain>
Subject: [uml-devel] [patch 12/20] uml:use kallsyms when dumping stack
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
Date: Thu, 04 Nov 2004 00:17:42 +0100
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, cw@f00f.org, blaisorblade_spam@yahoo.it


This patch makes UML use print_symbol() when dumping the stack. It is not yet
complete (the i386 version uses the frame pointers to walk the stack, for
instance), but should be at least enough.

Also, it uses bust_spinlock() when dumping errors to help them reach the
console. This appears not to be enough - however I analyzed the UML console
code, and it seems that UML console don't get flushed *at all* when exiting.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.9-paolo/arch/um/kernel/sysrq.c   |   13 ++++++-------
 vanilla-linux-2.6.9-paolo/arch/um/kernel/um_arch.c |    6 +++---
 2 files changed, 9 insertions(+), 10 deletions(-)

diff -puN arch/um/kernel/sysrq.c~uml-use-kallsyms arch/um/kernel/sysrq.c
--- vanilla-linux-2.6.9/arch/um/kernel/sysrq.c~uml-use-kallsyms	2004-11-03 23:45:00.242401880 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/sysrq.c	2004-11-03 23:45:00.246401272 +0100
@@ -14,23 +14,23 @@
 
 void show_trace(unsigned long * stack)
 {
-        int i;
+	/* XXX: Copy the CONFIG_FRAME_POINTER stack-walking backtrace from
+	 * arch/i386/kernel/traps.c. */
         unsigned long addr;
 
         if (!stack)
                 stack = (unsigned long*) &stack;
 
-        printk("Call Trace:\n");
-        i = 1;
+        printk("Call Trace: \n");
         while (((long) stack & (THREAD_SIZE-1)) != 0) {
                 addr = *stack++;
 		if (__kernel_text_address(addr)) {
-			printk("[<%08lx>] ", addr);
-			print_symbol("%s", addr);
+			printk(" [<%08lx>]", addr);
+			print_symbol(" %s", addr);
 			printk("\n");
-			i++;
                 }
         }
+        printk("\n");
 }
 
 /*
@@ -48,4 +48,3 @@ void show_stack(struct task_struct *task
 {
 	show_trace(sp);
 }
-
diff -puN arch/um/kernel/um_arch.c~uml-use-kallsyms arch/um/kernel/um_arch.c
--- vanilla-linux-2.6.9/arch/um/kernel/um_arch.c~uml-use-kallsyms	2004-11-03 23:45:00.243401728 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/um_arch.c	2004-11-03 23:45:00.246401272 +0100
@@ -405,9 +405,9 @@ extern int uml_exitcode;
 static int panic_exit(struct notifier_block *self, unsigned long unused1,
 		      void *unused2)
 {
-#ifdef CONFIG_MAGIC_SYSRQ
-	handle_sysrq('p', &current->thread.regs, NULL);
-#endif
+	bust_spinlocks(1);
+	show_regs(&(current->thread.regs));
+	bust_spinlocks(0);
 	uml_exitcode = 1;
 	machine_halt();
 	return(0);
_


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
