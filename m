Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <inguin@gmx.de>) id 1LvCes-00010q-OD
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 18 Apr 2009 15:40:46 +0000
Received: from mail.gmx.net ([213.165.64.20])
	by 3b2kzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1LvCej-0004n2-6y for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 18 Apr 2009 15:40:46 +0000
Date: Sat, 18 Apr 2009 17:40:21 +0200
From: Ingo van Lil <inguin@gmx.de>
Message-ID: <20090418154021.GA14617@ivl.dyndns.org>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [Patch] Save FPU registers between task switches
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

Hello there,

some time ago Jeff prepared a patch [1] for UML to stop saving the
process FP state between task switches. The assumption was that since
with SKAS0 every guest process runs inside a host process context the
host OS will take care of keeping the proper FP state. Unfortunately
this is not true for multi-threaded applications, where all guest
threads share a single host process context yet all may use the FPU on
their own. Although I haven't verified it I suspect things to be even
worse in SKAS3 mode where all guest processes run inside a single host
process.

I have written a simple test program to demostrate the issue. It can be
found in my mail at [2].

The patch below reintroduces the saving and restoring of the FP context
between task switches. Stanislav, the patch might also fix the problems
you experienced in SKAS3 mode. I'd be grateful if you could give it a
try.

Of course the additional ptrace calls adds some overhead to context
switches. It might be possible to optimize things by remembering the
last running task for each mm_context and only save/restore the FP state
if a different task is scheduled to run in a context.

Regards,
Ingo

[1]
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=42daba316557e597a90a730f61c762602b7f0e0c

[2] http://marc.info/?l=user-mode-linux-devel&m=123912656515459&w=2



Signed-off-by: Ingo van Lil <inguin@gmx.de>
Cc: Jeff Dike <jdike@addtoit.com>

--
diff -ur a/arch/um/include/shared/registers.h b/arch/um/include/shared/registers.h
--- a/arch/um/include/shared/registers.h	2009-04-02 22:55:27.000000000 +0200
+++ b/arch/um/include/shared/registers.h	2009-04-18 17:06:30.000000000 +0200
@@ -16,7 +16,7 @@
 extern int save_registers(int pid, struct uml_pt_regs *regs);
 extern int restore_registers(int pid, struct uml_pt_regs *regs);
 extern int init_registers(int pid);
-extern void get_safe_registers(unsigned long *regs);
+extern void get_safe_registers(unsigned long *regs, unsigned long *fp_regs);
 extern unsigned long get_thread_reg(int reg, jmp_buf *buf);
 extern int get_fp_registers(int pid, unsigned long *regs);
 extern int put_fp_registers(int pid, unsigned long *regs);
diff -ur a/arch/um/kernel/process.c b/arch/um/kernel/process.c
--- a/arch/um/kernel/process.c	2009-04-02 22:55:27.000000000 +0200
+++ b/arch/um/kernel/process.c	2009-04-18 17:06:30.000000000 +0200
@@ -200,7 +200,7 @@
 		arch_copy_thread(&current->thread.arch, &p->thread.arch);
 	}
 	else {
-		get_safe_registers(p->thread.regs.regs.gp);
+		get_safe_registers(p->thread.regs.regs.gp, p->thread.regs.regs.fp);
 		p->thread.request.u.thread = current->thread.request.u.thread;
 		handler = new_thread_handler;
 	}
diff -ur a/arch/um/os-Linux/registers.c b/arch/um/os-Linux/registers.c
--- a/arch/um/os-Linux/registers.c	2009-04-02 22:55:27.000000000 +0200
+++ b/arch/um/os-Linux/registers.c	2009-04-18 17:06:30.000000000 +0200
@@ -8,6 +8,8 @@
 #include <string.h>
 #include <sys/ptrace.h>
 #include "sysdep/ptrace.h"
+#include "ptrace_user.h"
+#include "registers.h"
 
 int save_registers(int pid, struct uml_pt_regs *regs)
 {
@@ -32,6 +34,7 @@
 /* This is set once at boot time and not changed thereafter */
 
 static unsigned long exec_regs[MAX_REG_NR];
+static unsigned long exec_fp_regs[FP_SIZE];
 
 int init_registers(int pid)
 {
@@ -42,10 +45,13 @@
 		return -errno;
 
 	arch_init_registers(pid);
+	get_fp_registers(pid, exec_fp_regs);
 	return 0;
 }
 
-void get_safe_registers(unsigned long *regs)
+void get_safe_registers(unsigned long *regs, unsigned long *fp_regs)
 {
 	memcpy(regs, exec_regs, sizeof(exec_regs));
+	if (fp_regs != NULL)
+		memcpy(fp_regs, exec_fp_regs, sizeof(exec_fp_regs));
 }
diff -ur a/arch/um/os-Linux/skas/mem.c b/arch/um/os-Linux/skas/mem.c
--- a/arch/um/os-Linux/skas/mem.c	2009-04-02 22:55:27.000000000 +0200
+++ b/arch/um/os-Linux/skas/mem.c	2009-04-18 17:06:30.000000000 +0200
@@ -39,7 +39,7 @@
 
 static int __init init_syscall_regs(void)
 {
-	get_safe_registers(syscall_regs);
+	get_safe_registers(syscall_regs, NULL);
 	syscall_regs[REGS_IP_INDEX] = STUB_CODE +
 		((unsigned long) &batch_syscall_stub -
 		 (unsigned long) &__syscall_stub_start);
diff -ur a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
--- a/arch/um/os-Linux/skas/process.c	2009-04-02 22:55:27.000000000 +0200
+++ b/arch/um/os-Linux/skas/process.c	2009-04-18 17:06:30.000000000 +0200
@@ -372,6 +372,8 @@
 		 */
 		if (ptrace(PTRACE_SETREGS, pid, 0, regs->gp))
 			fatal_sigsegv();
+		if (put_fp_registers(pid, regs->fp))
+			fatal_sigsegv();
 
 		/* Now we set local_using_sysemu to be used for one loop */
 		local_using_sysemu = get_using_sysemu();
@@ -398,6 +400,11 @@
 			       "errno = %d\n", errno);
 			fatal_sigsegv();
 		}
+		if (get_fp_registers(pid, regs->fp)) {
+			printk(UM_KERN_ERR "userspace - get_fp_registers failed, "
+			       "errno = %d\n", errno);
+			fatal_sigsegv();
+		}
 
 		UPT_SYSCALL_NR(regs) = -1; /* Assume: It's not a syscall */
 
@@ -457,10 +464,11 @@
 }
 
 static unsigned long thread_regs[MAX_REG_NR];
+static unsigned long thread_fp_regs[FP_SIZE];
 
 static int __init init_thread_regs(void)
 {
-	get_safe_registers(thread_regs);
+	get_safe_registers(thread_regs, thread_fp_regs);
 	/* Set parent's instruction pointer to start of clone-stub */
 	thread_regs[REGS_IP_INDEX] = STUB_CODE +
 				(unsigned long) stub_clone_handler -
@@ -503,6 +511,13 @@
 		return err;
 	}
 
+	err = put_fp_registers(pid, thread_fp_regs);
+	if (err < 0) {
+		printk(UM_KERN_ERR "copy_context_skas0 : PTRACE_SETFPREGS "
+		       "failed, pid = %d, errno = %d\n", pid, -err);
+		return err;
+	}
+
 	/* set a well known return code for detection of child write failure */
 	child_data->err = 12345678;
 
diff -ur a/arch/um/sys-i386/shared/sysdep/ptrace.h b/arch/um/sys-i386/shared/sysdep/ptrace.h
--- a/arch/um/sys-i386/shared/sysdep/ptrace.h	2009-04-02 22:55:27.000000000 +0200
+++ b/arch/um/sys-i386/shared/sysdep/ptrace.h	2009-04-18 17:06:30.000000000 +0200
@@ -53,6 +53,7 @@
 
 struct uml_pt_regs {
 	unsigned long gp[MAX_REG_NR];
+	unsigned long fp[HOST_FPX_SIZE];
 	struct faultinfo faultinfo;
 	long syscall;
 	int is_user;
diff -ur a/arch/um/sys-x86_64/shared/sysdep/ptrace.h b/arch/um/sys-x86_64/shared/sysdep/ptrace.h
--- a/arch/um/sys-x86_64/shared/sysdep/ptrace.h	2009-04-02 22:55:27.000000000 +0200
+++ b/arch/um/sys-x86_64/shared/sysdep/ptrace.h	2009-04-18 17:06:30.000000000 +0200
@@ -85,6 +85,7 @@
 
 struct uml_pt_regs {
 	unsigned long gp[MAX_REG_NR];
+	unsigned long fp[HOST_FP_SIZE];
 	struct faultinfo faultinfo;
 	long syscall;
 	int is_user;

------------------------------------------------------------------------------
Stay on top of everything new and different, both inside and 
around Java (TM) technology - register by April 22, and save
$200 on the JavaOne (SM) conference, June 2-5, 2009, San Francisco.
300 plus technical and hands-on sessions. Register today. 
Use priority code J9JMT32. http://p.sf.net/sfu/p
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

