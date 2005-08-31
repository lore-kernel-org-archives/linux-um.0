Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EAbf9-0002nv-G9	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 31 Aug 2005 16:06:35 -0700
Received: from rgminet02.oracle.com ([148.87.122.31])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)	id 1EAbf8-0000F9-BS
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 31 Aug 2005 16:06:35 -0700
Received: from rgmsgw300.us.oracle.com (rgmsgw300.us.oracle.com
	[138.1.186.49])j7VN6P1L005187
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 31 Aug 2005 17:06:25 -0600
Received: from rgmsgw300.us.oracle.com (localhost [127.0.0.1])
	j7VN6OIo008967	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 31 Aug 2005 17:06:25 -0600
Received: from [138.2.230.92] (agraves-lnx.us.oracle.com [138.2.230.92])
	j7VN6ONX008959
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 31 Aug 2005 17:06:24 -0600
Message-ID: <431637F9.6030101@oracle.com>
From: Allan Graves <allan.graves@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070201090607060301070508"
Subject: [uml-devel] stack and scheduler patches
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
Date: Wed, 31 Aug 2005 19:06:33 -0400
To: user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------070201090607060301070508
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jeff,
Here's the patches.  Hope these meet your approval!
Allan

--------------070201090607060301070508
Content-Type: text/plain;
 name="sched_um.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched_um.patch"

diff -uNr -x '.dep*' -x '.hdep*' -x '*.[oas]' -x '*~' -x '#*' -x '*CVS*' -x '*.orig' -x '*.rej' -x '*.old' -x '.menu*' -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkaymap.c -x uni_hash.tbl linux-2.6.13/arch/um/kernel/process_kern.c linux-2.6.13-stack/arch/um/kernel/process_kern.c
--- linux-2.6.13/arch/um/kernel/process_kern.c	2005-08-28 19:41:01.000000000 -0400
+++ linux-2.6.13-stack/arch/um/kernel/process_kern.c	2005-08-31 17:50:17.000000000 -0400
@@ -113,8 +113,17 @@
 
 void *_switch_to(void *prev, void *next, void *last)
 {
-	return(CHOOSE_MODE(switch_to_tt(prev, next), 
-			   switch_to_skas(prev, next)));
+        struct task_struct *from=(struct task_struct*)prev;
+        struct task_struct *to=(struct task_struct*)next;
+
+        to->thread.prev_sched = from;
+        set_current(to);
+
+          CHOOSE_MODE(switch_to_tt(prev, next),
+             switch_to_skas(prev, next));
+
+        return(current->thread.prev_sched); 
+
 }
 
 void interrupt_end(void)
diff -uNr -x '.dep*' -x '.hdep*' -x '*.[oas]' -x '*~' -x '#*' -x '*CVS*' -x '*.orig' -x '*.rej' -x '*.old' -x '.menu*' -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkaymap.c -x uni_hash.tbl linux-2.6.13/arch/um/kernel/skas/include/mode_kern-skas.h linux-2.6.13-stack/arch/um/kernel/skas/include/mode_kern-skas.h
--- linux-2.6.13/arch/um/kernel/skas/include/mode_kern-skas.h	2005-08-28 19:41:01.000000000 -0400
+++ linux-2.6.13-stack/arch/um/kernel/skas/include/mode_kern-skas.h	2005-08-30 16:46:17.000000000 -0400
@@ -11,7 +11,7 @@
 #include "asm/ptrace.h"
 
 extern void flush_thread_skas(void);
-extern void *switch_to_skas(void *prev, void *next);
+extern int switch_to_skas(void *prev, void *next);
 extern void start_thread_skas(struct pt_regs *regs, unsigned long eip,
 			      unsigned long esp);
 extern int copy_thread_skas(int nr, unsigned long clone_flags,
diff -uNr -x '.dep*' -x '.hdep*' -x '*.[oas]' -x '*~' -x '#*' -x '*CVS*' -x '*.orig' -x '*.rej' -x '*.old' -x '.menu*' -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkaymap.c -x uni_hash.tbl linux-2.6.13/arch/um/kernel/skas/process_kern.c linux-2.6.13-stack/arch/um/kernel/skas/process_kern.c
--- linux-2.6.13/arch/um/kernel/skas/process_kern.c	2005-08-28 19:41:01.000000000 -0400
+++ linux-2.6.13-stack/arch/um/kernel/skas/process_kern.c	2005-08-31 15:48:35.000000000 -0400
@@ -24,7 +24,7 @@
 #include "proc_mm.h"
 #include "registers.h"
 
-void *switch_to_skas(void *prev, void *next)
+int switch_to_skas(void *prev, void *next)
 {
 	struct task_struct *from, *to;
 
@@ -35,8 +35,6 @@
 	if(current->pid == 0)
 		switch_timers(0);
 
-	to->thread.prev_sched = from;
-	set_current(to);
 
 	switch_threads(&from->thread.mode.skas.switch_buf, 
 		       to->thread.mode.skas.switch_buf);
@@ -44,7 +42,7 @@
 	if(current->pid == 0)
 		switch_timers(1);
 
-	return(current->thread.prev_sched);
+	return(0);
 }
 
 extern void schedule_tail(struct task_struct *prev);
diff -uNr -x '.dep*' -x '.hdep*' -x '*.[oas]' -x '*~' -x '#*' -x '*CVS*' -x '*.orig' -x '*.rej' -x '*.old' -x '.menu*' -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkaymap.c -x uni_hash.tbl linux-2.6.13/arch/um/kernel/tt/include/mode_kern-tt.h linux-2.6.13-stack/arch/um/kernel/tt/include/mode_kern-tt.h
--- linux-2.6.13/arch/um/kernel/tt/include/mode_kern-tt.h	2005-08-28 19:41:01.000000000 -0400
+++ linux-2.6.13-stack/arch/um/kernel/tt/include/mode_kern-tt.h	2005-08-31 11:15:55.000000000 -0400
@@ -11,7 +11,7 @@
 #include "asm/ptrace.h"
 #include "asm/uaccess.h"
 
-extern void *switch_to_tt(void *prev, void *next);
+extern int switch_to_tt(void *prev, void *next);
 extern void flush_thread_tt(void);
 extern void start_thread_tt(struct pt_regs *regs, unsigned long eip,
 			   unsigned long esp);
diff -uNr -x '.dep*' -x '.hdep*' -x '*.[oas]' -x '*~' -x '#*' -x '*CVS*' -x '*.orig' -x '*.rej' -x '*.old' -x '.menu*' -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkaymap.c -x uni_hash.tbl linux-2.6.13/arch/um/kernel/tt/process_kern.c linux-2.6.13-stack/arch/um/kernel/tt/process_kern.c
--- linux-2.6.13/arch/um/kernel/tt/process_kern.c	2005-08-28 19:41:01.000000000 -0400
+++ linux-2.6.13-stack/arch/um/kernel/tt/process_kern.c	2005-08-31 15:48:31.000000000 -0400
@@ -26,7 +26,7 @@
 #include "init.h"
 #include "tt.h"
 
-void *switch_to_tt(void *prev, void *next, void *last)
+int switch_to_tt(void *prev, void *next, void *last)
 {
 	struct task_struct *from, *to, *prev_sched;
 	unsigned long flags;
@@ -36,7 +36,6 @@
 	from = prev;
 	to = next;
 
-	to->thread.prev_sched = from;
 
 	cpu = from->thread_info->cpu;
 	if(cpu == 0)
@@ -53,7 +52,6 @@
 	forward_pending_sigio(to->thread.mode.tt.extern_pid);
 
 	c = 0;
-	set_current(to);
 
 	err = os_write_file(to->thread.mode.tt.switch_pipe[1], &c, sizeof(c));
 	if(err != sizeof(c))
@@ -86,7 +84,7 @@
 	flush_tlb_all();
 	local_irq_restore(flags);
 
-	return(current->thread.prev_sched);
+        return(0);
 }
 
 void release_thread_tt(struct task_struct *task)

--------------070201090607060301070508
Content-Type: text/plain;
 name="stack_trace.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="stack_trace.patch"

diff -uNr -x '.dep*' -x '.hdep*' -x '*.[oas]' -x '*~' -x '#*' -x '*CVS*' -x '*.orig' -x '*.rej' -x '*.old' -x '.menu*' -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkaymap.c -x uni_hash.tbl linux-2.6.13/arch/um/drivers/mconsole_kern.c linux-2.6.13-stack/arch/um/drivers/mconsole_kern.c
--- linux-2.6.13/arch/um/drivers/mconsole_kern.c	2005-08-28 19:41:01.000000000 -0400
+++ linux-2.6.13-stack/arch/um/drivers/mconsole_kern.c	2005-08-31 16:24:51.000000000 -0400
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
@@ -479,6 +481,54 @@
 }
 #endif
 
+/* Mconsole stack trace
+   Added by Allan Graves, Jeff Dike
+   Dumps a stacks registers to the linux console.
+   Usage stack <pid>.  */
+void do_stack(struct mc_request *req)
+{
+        char *ptr = req->request.data; 
+        int pid_requested=-1;
+        struct task_struct *from=NULL;
+	struct task_struct *to=NULL;
+       
+        /* Would be nice:
+           1) Send showregs output to mconsole.
+           2) Add a way to stack dump all pids.
+        */
+
+        ptr += strlen("stack");
+        while(isspace(*ptr)) ptr++;
+
+        /* Should really check for multiple pids or reject bad args here */
+        /* What do the arguments in mconsole_reply mean? */
+        if (0==sscanf(ptr, "%d", &pid_requested) || pid_requested==-1) {
+                mconsole_reply(req, "Please specify a pid", 1, 0);
+                return;
+        }
+
+        from=current;
+        to=find_task_by_pid(pid_requested);
+
+        if((!to) || (pid_requested ==0)) {
+                mconsole_reply(req, "Couldn't find that pid", 1, 0);
+                return;
+        }
+        to->thread.saved_task=current;
+
+        switch_to(from,to,from);
+        mconsole_reply(req, "Stack Dumped to console and message log", 0, 0);
+
+}
+
+void mconsole_stack(struct mc_request *req)
+{
+	/* This command doesn't work in TT mode, so let's check and then get out of here */
+	CHOOSE_MODE(mconsole_reply(req, "Sorry, this doesn't work in TT mode", 1, 0),
+          do_stack(req));
+}
+
+
 /* Changed by mconsole_setup, which is __setup, and called before SMP is
  * active.
  */
diff -uNr -x '.dep*' -x '.hdep*' -x '*.[oas]' -x '*~' -x '#*' -x '*CVS*' -x '*.orig' -x '*.rej' -x '*.old' -x '.menu*' -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkaymap.c -x uni_hash.tbl linux-2.6.13/arch/um/drivers/mconsole_user.c linux-2.6.13-stack/arch/um/drivers/mconsole_user.c
--- linux-2.6.13/arch/um/drivers/mconsole_user.c	2005-08-28 19:41:01.000000000 -0400
+++ linux-2.6.13-stack/arch/um/drivers/mconsole_user.c	2005-08-31 16:59:51.000000000 -0400
@@ -30,6 +30,7 @@
 	{ "go", mconsole_go, MCONSOLE_INTR },
 	{ "log", mconsole_log, MCONSOLE_INTR },
 	{ "proc", mconsole_proc, MCONSOLE_PROC },
+        { "stack", mconsole_stack, MCONSOLE_INTR },
 };
 
 /* Initialized in mconsole_init, which is an initcall */
Binary files linux-2.6.13/arch/um/drivers/.mconsole_user.c.swp and linux-2.6.13-stack/arch/um/drivers/.mconsole_user.c.swp differ
diff -uNr -x '.dep*' -x '.hdep*' -x '*.[oas]' -x '*~' -x '#*' -x '*CVS*' -x '*.orig' -x '*.rej' -x '*.old' -x '.menu*' -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkaymap.c -x uni_hash.tbl linux-2.6.13/arch/um/include/mconsole.h linux-2.6.13-stack/arch/um/include/mconsole.h
--- linux-2.6.13/arch/um/include/mconsole.h	2005-08-28 19:41:01.000000000 -0400
+++ linux-2.6.13-stack/arch/um/include/mconsole.h	2005-08-29 17:09:47.000000000 -0400
@@ -81,6 +81,7 @@
 extern void mconsole_go(struct mc_request *req);
 extern void mconsole_log(struct mc_request *req);
 extern void mconsole_proc(struct mc_request *req);
+extern void mconsole_stack(struct mc_request *req);
 
 extern int mconsole_get_request(int fd, struct mc_request *req);
 extern int mconsole_notify(char *sock_name, int type, const void *data, 
diff -uNr -x '.dep*' -x '.hdep*' -x '*.[oas]' -x '*~' -x '#*' -x '*CVS*' -x '*.orig' -x '*.rej' -x '*.old' -x '.menu*' -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkaymap.c -x uni_hash.tbl linux-2.6.13/arch/um/kernel/process_kern.c linux-2.6.13-stack/arch/um/kernel/process_kern.c
--- linux-2.6.13/arch/um/kernel/process_kern.c	2005-08-31 18:35:52.000000000 -0400
+++ linux-2.6.13-stack/arch/um/kernel/process_kern.c	2005-08-31 18:46:45.000000000 -0400
@@ -119,8 +120,18 @@
         to->thread.prev_sched = from;
         set_current(to);
 
+        do 
+        { 
+          current->thread.saved_task = NULL ;
           CHOOSE_MODE(switch_to_tt(prev, next),
              switch_to_skas(prev, next));
+          if(current->thread.saved_task) 
+            show_regs(&(current->thread.regs));
+            next=(void *)current->thread.saved_task;
+            prev=(void*)current;
+        } while(current->thread.saved_task);
+
+
 
         return(current->thread.prev_sched); 
 
diff -uNr -x '.dep*' -x '.hdep*' -x '*.[oas]' -x '*~' -x '#*' -x '*CVS*' -x '*.orig' -x '*.rej' -x '*.old' -x '.menu*' -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkaymap.c -x uni_hash.tbl linux-2.6.13/include/asm-um/processor-generic.h linux-2.6.13-stack/include/asm-um/processor-generic.h
--- linux-2.6.13/include/asm-um/processor-generic.h	2005-08-28 19:41:01.000000000 -0400
+++ linux-2.6.13-stack/include/asm-um/processor-generic.h	2005-08-30 11:26:03.000000000 -0400
@@ -21,6 +21,7 @@
 	 * copy_thread) to mark that we are begin called from userspace (fork /
 	 * vfork / clone), and reset to 0 after. It is left to 0 when called
 	 * from kernelspace (i.e. kernel_thread() or fork_idle(), as of 2.6.11). */
+	struct task_struct *saved_task;
 	int forking;
 	int nsyscalls;
 	struct pt_regs regs;

--------------070201090607060301070508--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
