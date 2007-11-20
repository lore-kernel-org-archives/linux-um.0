Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IuXoB-0007af-0b for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Nov 2007 10:26:52 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IuXo7-0003bN-Lx
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Nov 2007 10:26:50 -0800
Date: Tue, 20 Nov 2007 13:26:32 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071120182632.GA7689@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 2/4] UML - use ptrace directly in libc code
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

Some register accessor cleanups -
	userspace() was calling restore_registers and save_registers for no
reason, since userspace() is on the libc side of the house, and these
add no value over calling ptrace directly
	init_thread_registers and get_safe_registers were the same thing,
so init_thread_registers is gone

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/include/registers.h     |    1 -
 arch/um/kernel/process.c        |    2 +-
 arch/um/os-Linux/registers.c    |   13 ++++---------
 arch/um/os-Linux/skas/process.c |    9 +++++++--
 4 files changed, 12 insertions(+), 13 deletions(-)

Index: linux-2.6.22/arch/um/os-Linux/skas/process.c
===================================================================
--- linux-2.6.22.orig/arch/um/os-Linux/skas/process.c	2007-11-20 13:05:22.000000000 -0500
+++ linux-2.6.22/arch/um/os-Linux/skas/process.c	2007-11-20 13:05:45.000000000 -0500
@@ -298,7 +298,9 @@ void userspace(struct uml_pt_regs *regs)
 	nsecs += os_nsecs();
 
 	while (1) {
-		restore_registers(pid, regs);
+		if (ptrace(PTRACE_SETREGS, pid, 0, regs->gp))
+			panic("userspace - PTRACE_SETREGS failed, "
+			      "errno = %d\n", errno);
 
 		/* Now we set local_using_sysemu to be used for one loop */
 		local_using_sysemu = get_using_sysemu();
@@ -318,7 +320,10 @@ void userspace(struct uml_pt_regs *regs)
 			      errno);
 
 		regs->is_user = 1;
-		save_registers(pid, regs);
+		if (ptrace(PTRACE_GETREGS, pid, 0, regs->gp))
+			panic("userspace - saving registers failed, "
+			      "errno = %d\n", errno);
+
 		UPT_SYSCALL_NR(regs) = -1; /* Assume: It's not a syscall */
 
 		if (WIFSTOPPED(status)) {
@@ -341,7 +346,7 @@ void userspace(struct uml_pt_regs *regs)
 				break;
 			case SIGVTALRM:
 				now = os_nsecs();
-				if(now < nsecs)
+				if (now < nsecs)
 					break;
 				block_signals();
 				(*sig_info[sig])(sig, regs);
Index: linux-2.6.22/arch/um/kernel/process.c
===================================================================
--- linux-2.6.22.orig/arch/um/kernel/process.c	2007-11-20 13:05:20.000000000 -0500
+++ linux-2.6.22/arch/um/kernel/process.c	2007-11-20 13:05:24.000000000 -0500
@@ -200,7 +200,7 @@ int copy_thread(int nr, unsigned long cl
 		arch_copy_thread(&current->thread.arch, &p->thread.arch);
 	}
 	else {
-		init_thread_registers(&p->thread.regs.regs);
+		get_safe_registers(p->thread.regs.regs.gp);
 		p->thread.request.u.thread = current->thread.request.u.thread;
 		handler = new_thread_handler;
 	}
Index: linux-2.6.22/arch/um/os-Linux/registers.c
===================================================================
--- linux-2.6.22.orig/arch/um/os-Linux/registers.c	2007-11-20 13:05:20.000000000 -0500
+++ linux-2.6.22/arch/um/os-Linux/registers.c	2007-11-20 13:05:24.000000000 -0500
@@ -10,15 +10,6 @@
 #include "sysdep/ptrace.h"
 #include "user.h"
 
-/* This is set once at boot time and not changed thereafter */
-
-static unsigned long exec_regs[MAX_REG_NR];
-
-void init_thread_registers(struct uml_pt_regs *to)
-{
-	memcpy(to->gp, exec_regs, sizeof(to->gp));
-}
-
 void save_registers(int pid, struct uml_pt_regs *regs)
 {
 	int err;
@@ -39,6 +30,10 @@ void restore_registers(int pid, struct u
 		      "errno = %d\n", errno);
 }
 
+/* This is set once at boot time and not changed thereafter */
+
+static unsigned long exec_regs[MAX_REG_NR];
+
 void init_registers(int pid)
 {
 	int err;
Index: linux-2.6.22/arch/um/include/registers.h
===================================================================
--- linux-2.6.22.orig/arch/um/include/registers.h	2007-11-20 13:05:20.000000000 -0500
+++ linux-2.6.22/arch/um/include/registers.h	2007-11-20 13:05:24.000000000 -0500
@@ -9,7 +9,6 @@
 #include "sysdep/ptrace.h"
 #include "sysdep/archsetjmp.h"
 
-extern void init_thread_registers(struct uml_pt_regs *to);
 extern int save_fp_registers(int pid, unsigned long *fp_regs);
 extern int restore_fp_registers(int pid, unsigned long *fp_regs);
 extern int save_fpx_registers(int pid, unsigned long *fp_regs);

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
