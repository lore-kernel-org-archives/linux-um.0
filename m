Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CDSHv-0001rz-L5 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Oct 2004 11:37:51 -0700
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CDSHu-0001XW-Cx for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Oct 2004 11:37:51 -0700
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Message-ID: <8B6FF516CBA0194AB0996705076B02520F7C47@ABGEX01E.abg.fsc.net>
From: "Stroesser, Bodo" <Bodo.Stroesser@fujitsu-siemens.com>
Subject: [uml-devel] Security patch 3 of 3
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
Date: Fri, 1 Oct 2004 20:26:47 +0200
Content-Transfer-Encoding: 8bit
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, BlaisorBlade <blaisorblade_spam@yahoo.it>

This one removes singlestepping_tt() and singlestepping_skas() and
Inserts singlestepping() instead.
Now SKAS mode should be OK, with the exception of the vsyscall page.

I have tested in tt and skas mode.

Bodo


--- linux-2.6.9-rc2-orig/arch/um/kernel/skas/process.c	2004-10-01
15:34:49.000000000 +0200
+++ linux-2.6.9-rc2/arch/um/kernel/skas/process.c	2004-10-01
18:23:35.481627322 +0200
@@ -185,10 +185,10 @@
 		local_using_sysemu = get_using_sysemu();
 
 		if (local_using_sysemu)
-			op = singlestepping_skas() ? PTRACE_SINGLESTEP :
+			op = singlestepping(NULL) ? PTRACE_SINGLESTEP :
 				PTRACE_SYSEMU;
 		else
-			op = singlestepping_skas() ? PTRACE_SINGLESTEP :
+			op = singlestepping(NULL) ? PTRACE_SINGLESTEP :
 				PTRACE_SYSCALL;
 
 		err = ptrace(op, pid, 0, 0);
--- linux-2.6.9-rc2-orig/arch/um/kernel/skas/include/skas.h
2004-10-01 15:34:49.000000000 +0200
+++ linux-2.6.9-rc2/arch/um/kernel/skas/include/skas.h	2004-10-01
18:25:13.728391472 +0200
@@ -28,7 +28,6 @@
 extern int protect(int fd, unsigned long addr, unsigned long len, 
 		   int r, int w, int x, int must_succeed);
 extern void user_signal(int sig, union uml_pt_regs *regs);
-extern int singlestepping_skas(void);
 extern int new_mm(int from);
 extern void start_userspace(int cpu);
 
--- linux-2.6.9-rc2-orig/arch/um/kernel/skas/syscall_kern.c
2004-09-13 07:32:54.000000000 +0200
+++ linux-2.6.9-rc2/arch/um/kernel/skas/syscall_kern.c	2004-10-01
18:28:35.139107179 +0200
@@ -4,6 +4,7 @@
  */
 
 #include "linux/sys.h"
+#include "linux/ptrace.h"
 #include "asm/errno.h"
 #include "asm/unistd.h"
 #include "asm/ptrace.h"
@@ -27,6 +28,12 @@
 		res = -ENOSYS;
 	else res = EXECUTE_SYSCALL(syscall, regs);
 
+	if(current->thread.singlestep_syscall){
+		current->thread.singlestep_syscall = 0;
+		current->ptrace &= ~PT_DTRACE;
+		force_sig(SIGTRAP, current);
+	}
+
 	return(res);
 }
 
--- linux-2.6.9-rc2-orig/arch/um/kernel/skas/process_kern.c
2004-10-01 15:34:49.000000000 +0200
+++ linux-2.6.9-rc2/arch/um/kernel/skas/process_kern.c	2004-10-01
18:30:21.989449538 +0200
@@ -79,14 +79,6 @@
 
 late_initcall(make_proc_sysemu);
 
-int singlestepping_skas(void)
-{
-	int ret = current->ptrace & PT_DTRACE;
-
-	current->ptrace &= ~PT_DTRACE;
-	return(ret);
-}
-
 void *switch_to_skas(void *prev, void *next)
 {
 	struct task_struct *from, *to;
--- linux-2.6.9-rc2-orig/arch/um/kernel/tt/tracer.c	2004-09-29
14:49:59.000000000 +0200
+++ linux-2.6.9-rc2/arch/um/kernel/tt/tracer.c	2004-10-01
18:33:30.732258690 +0200
@@ -367,7 +367,7 @@
 			}
 
 			if(tracing){
-				if(singlestepping_tt(task))
+				if(singlestepping(task))
 					cont_type = PTRACE_SINGLESTEP;
 				else cont_type = PTRACE_SYSCALL;
 			}
--- linux-2.6.9-rc2-orig/arch/um/kernel/tt/include/tt.h	2004-09-13
07:32:54.000000000 +0200
+++ linux-2.6.9-rc2/arch/um/kernel/tt/include/tt.h	2004-10-01
18:34:01.584160234 +0200
@@ -24,7 +24,6 @@
 extern int set_user_mode(void *task);
 extern void set_tracing(void *t, int tracing);
 extern int is_tracing(void *task);
-extern int singlestepping_tt(void *t);
 extern void clear_singlestep(void *t);
 extern void syscall_handler(int sig, union uml_pt_regs *regs);
 extern void exit_kernel(int pid, void *task);
--- linux-2.6.9-rc2-orig/arch/um/kernel/tt/process_kern.c
2004-10-01 18:17:49.961726497 +0200
+++ linux-2.6.9-rc2/arch/um/kernel/tt/process_kern.c	2004-10-01
18:36:17.124761361 +0200
@@ -524,15 +524,6 @@
 		      -err);
 }
 
-int singlestepping_tt(void *t)
-{
-	struct task_struct *task = t;
-
-	if(task->thread.singlestep_syscall)
-		return(0);
-	return(task->ptrace & PT_DTRACE);
-}
-
 void clear_singlestep(void *t)
 {
 	struct task_struct *task = t;
--- linux-2.6.9-rc2-orig/arch/um/kernel/process_kern.c	2004-09-29
14:49:59.000000000 +0200
+++ linux-2.6.9-rc2/arch/um/kernel/process_kern.c	2004-10-01
18:42:27.756512307 +0200
@@ -19,6 +19,7 @@
 #include "linux/capability.h"
 #include "linux/vmalloc.h"
 #include "linux/spinlock.h"
+#include "linux/ptrace.h"
 #include "asm/unistd.h"
 #include "asm/mman.h"
 #include "asm/segment.h"
@@ -400,6 +401,15 @@
 	return(current_thread->cpu);
 }
 
+int singlestepping(void * t)
+{
+	struct task_struct *task = t ? t : current;
+
+	if (task->thread.singlestep_syscall)
+		return(0);
+	return(task->ptrace & PT_DTRACE);
+}
+
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and
automatically


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
