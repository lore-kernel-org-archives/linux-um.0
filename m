Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EFfL7-0003hj-5V	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Sep 2005 15:02:49 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EFfL6-0004Cn-2x
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Sep 2005 15:02:49 -0700
Message-Id: <200509142155.j8ELtsQG012132@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 2/10] UML - breakpoint an arbitrary thread
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
Date: Wed, 14 Sep 2005 17:55:54 -0400
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Allan Graves <allan.graves@gmail.com>

This patch implements a stack trace for a thread, not unlike sysrq-t
does.  The advantage to this is that a break point can be placed on
showreqs, so that upon showing the stack, you jump immediately into
the debugger.
While sysrq-t does the same thing, sysrq-t shows *all* threads
stacks.  It also doesn't work right now.  In the future, I thought
it might be acceptable to make this show all pids stacks, but
perhaps leaving well enough alone and just using sysrq-t would be
okay.  For now, upon receiving the stack command, UML switches
context to that thread, dumps its registers, and then switches
context back to the original thread.  Since UML compacts all threads
into one of 4 host threads, this sort of mechanism could be expanded
in the future to include other debugging helpers that sysrq does not cover.

Note by jdike - The main benefit to this is that it brings an
arbitrary thread back into context, where it can be examined by
gdb.  The fact that it dumps it stack is secondary.  This provides
the capability to examine a sleeping thread, which has existed in tt
mode, but not in skas mode until now.
Also, the other threads, that sysrq doesn't cover, can be gdb-ed
directly anyway.

Signed-off-by: Allan Graves<allan.graves@gmail.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: test/arch/um/drivers/mconsole_kern.c
===================================================================
--- test.orig/arch/um/drivers/mconsole_kern.c	2005-09-02 12:50:26.000000000 -0400
+++ test/arch/um/drivers/mconsole_kern.c	2005-09-02 13:03:31.000000000 -0400
@@ -32,6 +32,7 @@
 #include "os.h"
 #include "umid.h"
 #include "irq_kern.h"
+#include "choose-mode.h"
 
 static int do_unlink_socket(struct notifier_block *notifier, 
 			    unsigned long what, void *data)
@@ -276,6 +277,7 @@
     go - continue the UML after a 'stop' \n\
     log <string> - make UML enter <string> into the kernel log\n\
     proc <file> - returns the contents of the UML's /proc/<file>\n\
+    stack <pid> - returns the stack of the specified pid\n\
 "
 
 void mconsole_help(struct mc_request *req)
@@ -479,6 +481,56 @@
 }
 #endif
 
+/* Mconsole stack trace
+ *  Added by Allan Graves, Jeff Dike
+ *  Dumps a stacks registers to the linux console.
+ *  Usage stack <pid>.  
+ */
+void do_stack(struct mc_request *req)
+{
+        char *ptr = req->request.data; 
+        int pid_requested= -1;
+        struct task_struct *from = NULL;
+	struct task_struct *to = NULL;
+       
+        /* Would be nice:
+         * 1) Send showregs output to mconsole.
+	 * 2) Add a way to stack dump all pids.
+	 */
+
+        ptr += strlen("stack");
+        while(isspace(*ptr)) ptr++;
+
+        /* Should really check for multiple pids or reject bad args here */
+        /* What do the arguments in mconsole_reply mean? */
+        if(sscanf(ptr, "%d", &pid_requested) == 0){
+                mconsole_reply(req, "Please specify a pid", 1, 0);
+                return;
+        }
+
+        from = current;
+        to = find_task_by_pid(pid_requested);
+
+        if((to == NULL) || (pid_requested == 0)) {
+                mconsole_reply(req, "Couldn't find that pid", 1, 0);
+                return;
+        }
+        to->thread.saved_task = current;
+
+        switch_to(from, to, from);
+        mconsole_reply(req, "Stack Dumped to console and message log", 0, 0);
+}
+
+void mconsole_stack(struct mc_request *req)
+{
+	/* This command doesn't work in TT mode, so let's check and then 
+	 * get out of here 
+	 */
+	CHOOSE_MODE(mconsole_reply(req, "Sorry, this doesn't work in TT mode", 
+				   1, 0),
+		    do_stack(req));
+}
+
 /* Changed by mconsole_setup, which is __setup, and called before SMP is
  * active.
  */
Index: test/arch/um/drivers/mconsole_user.c
===================================================================
--- test.orig/arch/um/drivers/mconsole_user.c	2005-09-02 12:50:26.000000000 -0400
+++ test/arch/um/drivers/mconsole_user.c	2005-09-02 12:56:59.000000000 -0400
@@ -30,6 +30,7 @@
 	{ "go", mconsole_go, MCONSOLE_INTR },
 	{ "log", mconsole_log, MCONSOLE_INTR },
 	{ "proc", mconsole_proc, MCONSOLE_PROC },
+        { "stack", mconsole_stack, MCONSOLE_INTR },
 };
 
 /* Initialized in mconsole_init, which is an initcall */
Index: test/arch/um/include/mconsole.h
===================================================================
--- test.orig/arch/um/include/mconsole.h	2005-09-02 12:50:26.000000000 -0400
+++ test/arch/um/include/mconsole.h	2005-09-02 12:56:59.000000000 -0400
@@ -81,6 +81,7 @@
 extern void mconsole_go(struct mc_request *req);
 extern void mconsole_log(struct mc_request *req);
 extern void mconsole_proc(struct mc_request *req);
+extern void mconsole_stack(struct mc_request *req);
 
 extern int mconsole_get_request(int fd, struct mc_request *req);
 extern int mconsole_notify(char *sock_name, int type, const void *data, 
Index: test/arch/um/kernel/process_kern.c
===================================================================
--- test.orig/arch/um/kernel/process_kern.c	2005-09-02 12:53:20.000000000 -0400
+++ test/arch/um/kernel/process_kern.c	2005-09-02 13:04:47.000000000 -0400
@@ -119,7 +119,14 @@
         to->thread.prev_sched = from;
         set_current(to);
 
-	CHOOSE_MODE_PROC(switch_to_tt, switch_to_skas, prev, next);
+	do { 
+		current->thread.saved_task = NULL ;
+		CHOOSE_MODE_PROC(switch_to_tt, switch_to_skas, prev, next);
+		if(current->thread.saved_task) 
+			show_regs(&(current->thread.regs));
+		next= current->thread.saved_task;
+		prev= current;
+	} while(current->thread.saved_task);
 
         return(current->thread.prev_sched); 
 
Index: test/include/asm-um/processor-generic.h
===================================================================
--- test.orig/include/asm-um/processor-generic.h	2005-09-02 12:50:26.000000000 -0400
+++ test/include/asm-um/processor-generic.h	2005-09-02 12:56:59.000000000 -0400
@@ -21,6 +21,7 @@
 	 * copy_thread) to mark that we are begin called from userspace (fork /
 	 * vfork / clone), and reset to 0 after. It is left to 0 when called
 	 * from kernelspace (i.e. kernel_thread() or fork_idle(), as of 2.6.11). */
+	struct task_struct *saved_task;
 	int forking;
 	int nsyscalls;
 	struct pt_regs regs;



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
