Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HTPMW-0004pb-H0 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Mar 2007 14:25:52 -0700
Received: from ns2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HTPMV-0007lG-8B
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Mar 2007 14:25:52 -0700
From: <gregkh@suse.de>
Date: Mon, 19 Mar 2007 14:23:49 -0700
In-Reply-To: <20070319201250.GC12179@c2.user-mode-linux.org>
Message-Id: <20070319212538.1262DCB18F7@imap.suse.de>
Subject: [uml-devel] patch uml-arch_prctl-should-set-thread-fs.patch queued
	to -stable tree
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: jdike@addtoit.com, greg@kroah.com, gregkh@suse.de, user-mode-linux-devel@lists.sourceforge.net
Cc: stable@kernel.org


This is a note to let you know that we have just queued up the patch titled

     Subject: UML - arch_prctl should set thread fs

to the 2.6.20-stable tree.  Its filename is

     uml-arch_prctl-should-set-thread-fs.patch

A git repo of this tree can be found at 
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary


From jdike@addtoit.com Mon Mar 19 13:16:13 2007
From: Jeff Dike <jdike@addtoit.com>
Date: Mon, 19 Mar 2007 16:12:50 -0400
Subject: UML - arch_prctl should set thread fs
To: stable@kernel.org
Cc: Greg KH <greg@kroah.com>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>
Message-ID: <20070319201250.GC12179@c2.user-mode-linux.org>

From: Jeff Dike <jdike@addtoit.com>

x86_64 needs some TLS fixes.  What was missing was remembering the child
thread id during clone and stuffing it into the child during each context
switch.

The %fs value is stored separately in the thread structure since the host
controls what effect it has on the actual register file.  The host also needs
to store it in its own thread struct, so we need the value kept outside the
register file.

arch_prctl_skas was fixed to call PTRACE_ARCH_PRCTL appropriately.  There is
some saving and restoring of registers in the ARCH_SET_* cases so that the
correct set of registers are changed on the host and restored to the process
when it runs again.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

--- linux-2.6.20.3.orig/arch/um/include/os.h
+++ linux-2.6.20.3/arch/um/include/os.h
@@ -341,4 +341,6 @@ extern void maybe_sigio_broken(int fd, i
 extern void sig_handler_common_skas(int sig, void *sc_ptr);
 extern void user_signal(int sig, union uml_pt_regs *regs, int pid);
 
+extern int os_arch_prctl(int pid, int code, unsigned long *addr);
+
 #endif
Index: linux-2.6.20.3/arch/um/os-Linux/sys-x86_64/Makefile
===================================================================
--- linux-2.6.20.3.orig/arch/um/os-Linux/sys-x86_64/Makefile
+++ linux-2.6.20.3/arch/um/os-Linux/sys-x86_64/Makefile
@@ -3,7 +3,7 @@
 # Licensed under the GPL
 #
 
-obj-$(CONFIG_MODE_SKAS) = registers.o signal.o
+obj-$(CONFIG_MODE_SKAS) = registers.o prctl.o signal.o
 
 USER_OBJS := $(obj-y)
 
Index: linux-2.6.20.3/arch/um/os-Linux/sys-x86_64/prctl.c
===================================================================
--- /dev/null
+++ linux-2.6.20.3/arch/um/os-Linux/sys-x86_64/prctl.c
@@ -0,0 +1,12 @@
+/*
+ * Copyright (C) 2007 Jeff Dike (jdike@{addtoit.com,linux.intel.com})
+ * Licensed under the GPL
+ */
+
+#include <sys/ptrace.h>
+#include <linux/ptrace.h>
+
+int os_arch_prctl(int pid, int code, unsigned long *addr)
+{
+	return ptrace(PTRACE_ARCH_PRCTL, pid, (unsigned long) addr, code);
+}
Index: linux-2.6.20.3/arch/um/sys-x86_64/syscalls.c
===================================================================
--- linux-2.6.20.3.orig/arch/um/sys-x86_64/syscalls.c
+++ linux-2.6.20.3/arch/um/sys-x86_64/syscalls.c
@@ -16,6 +16,7 @@
 #include "asm/prctl.h" /* XXX This should get the constants from libc */
 #include "choose-mode.h"
 #include "kern.h"
+#include "os.h"
 
 asmlinkage long sys_uname64(struct new_utsname __user * name)
 {
@@ -58,40 +59,70 @@ static long arch_prctl_tt(int code, unsi
 
 #ifdef CONFIG_MODE_SKAS
 
-/* XXX: Must also call arch_prctl in the host, beside saving the segment bases! */
-static long arch_prctl_skas(int code, unsigned long addr)
+static long arch_prctl_skas(int code, unsigned long __user *addr)
 {
-	long ret = 0;
+	unsigned long *ptr = addr, tmp;
+	long ret;
+	int pid = current->mm->context.skas.id.u.pid;
+
+	/*
+	 * With ARCH_SET_FS (and ARCH_SET_GS is treated similarly to
+	 * be safe), we need to call arch_prctl on the host because
+	 * setting %fs may result in something else happening (like a
+	 * GDT being set instead).  So, we let the host fiddle the
+	 * registers and restore them afterwards.
+	 *
+	 * So, the saved registers are stored to the process (this
+	 * needed because a stub may have been the last thing to run),
+	 * arch_prctl is run on the host, then the registers are read
+	 * back.
+	 */
+	switch(code){
+	case ARCH_SET_FS:
+	case ARCH_SET_GS:
+		restore_registers(pid, &current->thread.regs.regs);
+		break;
+	case ARCH_GET_FS:
+	case ARCH_GET_GS:
+		/*
+		 * With these two, we read to a local pointer and
+		 * put_user it to the userspace pointer that we were
+		 * given.  If addr isn't valid (because it hasn't been
+		 * faulted in or is just bogus), we want put_user to
+		 * fault it in (or return -EFAULT) instead of having
+		 * the host return -EFAULT.
+		 */
+		ptr = &tmp;
+	}
+
+	ret = os_arch_prctl(pid, code, ptr);
+	if(ret)
+		return ret;
 
 	switch(code){
 	case ARCH_SET_FS:
-		current->thread.regs.regs.skas.regs[FS_BASE / sizeof(unsigned long)] = addr;
+		current->thread.arch.fs = (unsigned long) ptr;
+		save_registers(pid, &current->thread.regs.regs);
 		break;
 	case ARCH_SET_GS:
-		current->thread.regs.regs.skas.regs[GS_BASE / sizeof(unsigned long)] = addr;
+		save_registers(pid, &current->thread.regs.regs);
 		break;
 	case ARCH_GET_FS:
-		ret = put_user(current->thread.regs.regs.skas.
-				regs[FS_BASE / sizeof(unsigned long)],
-				(unsigned long __user *)addr);
-	        break;
+		ret = put_user(tmp, addr);
+		break;
 	case ARCH_GET_GS:
-		ret = put_user(current->thread.regs.regs.skas.
-				regs[GS_BASE / sizeof(unsigned long)],
-				(unsigned long __user *)addr);
-	        break;
-	default:
-		ret = -EINVAL;
+		ret = put_user(tmp, addr);
 		break;
 	}
 
-	return(ret);
+	return ret;
 }
 #endif
 
 long sys_arch_prctl(int code, unsigned long addr)
 {
-	return(CHOOSE_MODE_PROC(arch_prctl_tt, arch_prctl_skas, code, addr));
+	return CHOOSE_MODE_PROC(arch_prctl_tt, arch_prctl_skas, code,
+				(unsigned long __user *) addr);
 }
 
 long sys_clone(unsigned long clone_flags, unsigned long newsp,
@@ -105,5 +136,14 @@ long sys_clone(unsigned long clone_flags
 	ret = do_fork(clone_flags, newsp, &current->thread.regs, 0, parent_tid,
 		      child_tid);
 	current->thread.forking = 0;
-	return(ret);
+	return ret;
 }
+
+void arch_switch_to_skas(struct task_struct *from, struct task_struct *to)
+{
+	if((to->thread.arch.fs == 0) || (to->mm == NULL))
+		return;
+
+	arch_prctl_skas(ARCH_SET_FS, (void __user *) to->thread.arch.fs);
+}
+
Index: linux-2.6.20.3/arch/um/sys-x86_64/tls.c
===================================================================
--- linux-2.6.20.3.orig/arch/um/sys-x86_64/tls.c
+++ linux-2.6.20.3/arch/um/sys-x86_64/tls.c
@@ -1,14 +1,17 @@
 #include "linux/sched.h"
 
-void debug_arch_force_load_TLS(void)
-{
-}
-
 void clear_flushed_tls(struct task_struct *task)
 {
 }
 
 int arch_copy_tls(struct task_struct *t)
 {
+	/*
+	 * If CLONE_SETTLS is set, we need to save the thread id
+	 * (which is argument 5, child_tid, of clone) so it can be set
+	 * during context switches.
+	 */
+	t->thread.arch.fs = t->thread.regs.regs.skas.regs[R8 / sizeof(long)];
+
         return 0;
 }
Index: linux-2.6.20.3/include/asm-um/processor-x86_64.h
===================================================================
--- linux-2.6.20.3.orig/include/asm-um/processor-x86_64.h
+++ linux-2.6.20.3/include/asm-um/processor-x86_64.h
@@ -13,6 +13,7 @@
 struct arch_thread {
         unsigned long debugregs[8];
         int debugregs_seq;
+	unsigned long fs;
         struct faultinfo faultinfo;
 };
 
@@ -25,8 +26,9 @@ extern inline void rep_nop(void)
 #define cpu_relax()   rep_nop()
 
 #define INIT_ARCH_THREAD { .debugregs  		= { [ 0 ... 7 ] = 0 }, \
-                           .debugregs_seq	= 0, \
-                           .faultinfo		= { 0, 0, 0 } }
+			   .debugregs_seq	= 0,			       \
+			   .fs			= 0, \
+			   .faultinfo		= { 0, 0, 0 } }
 
 static inline void arch_flush_thread(struct arch_thread *thread)
 {
Index: linux-2.6.20.3/include/asm-um/ptrace-x86_64.h
===================================================================
--- linux-2.6.20.3.orig/include/asm-um/ptrace-x86_64.h
+++ linux-2.6.20.3/include/asm-um/ptrace-x86_64.h
@@ -81,9 +81,7 @@ static inline void arch_switch_to_tt(str
 {
 }
 
-static inline void arch_switch_to_skas(struct task_struct *from,
-                                       struct task_struct *to)
-{
-}
+extern void arch_switch_to_skas(struct task_struct *from,
+				struct task_struct *to);
 
 #endif


Patches currently in stable-queue which might be from jdike@addtoit.com are


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
