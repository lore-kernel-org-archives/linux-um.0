Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C1sbK-0002C2-IW for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 Aug 2004 13:18:02 -0700
Received: from mail-relay-2.tiscali.it ([213.205.33.42])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C1sbJ-0000Jq-KL for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 Aug 2004 13:18:02 -0700
Received: from zion.localdomain (62.11.74.135) by mail-relay-2.tiscali.it
	(7.1.021.3)
	id 40F419A700A71E2B for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 Aug 2004 22:17:55 +0200
From: blaisorblade_spam@yahoo.it
Message-Id: <20040830201008.12BCF939B@zion.localdomain>
Subject: [uml-devel] [patch 1/5] um-sysemu
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
Date: Mon, 30 Aug 2004 22:10:07 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: blaisorblade_spam@yahoo.it


Turns off syscall emulation patch for ptrace (SYSEMU) on.
SYSEMU is a performance-patch introduced by Laurent Vivier. It changes
behaviour of ptrace() and helps reducing host context switch rate.
To make it working, you need a kernel patch for your host, too.
See http://perso.wanadoo.fr/laurent.vivier/UML/ for further information.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 uml-linux-2.6.8.1-paolo/arch/um/kernel/process.c                  |   35 ++++++++++
 uml-linux-2.6.8.1-paolo/arch/um/kernel/skas/include/ptrace-skas.h |    7 ++
 uml-linux-2.6.8.1-paolo/arch/um/kernel/skas/process.c             |   22 ++++++
 3 files changed, 64 insertions(+)

diff -puN arch/um/kernel/process.c~um-sysemu arch/um/kernel/process.c
--- uml-linux-2.6.8.1/arch/um/kernel/process.c~um-sysemu	2004-08-29 14:40:46.969071392 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/kernel/process.c	2004-08-29 14:40:46.973070784 +0200
@@ -19,6 +19,7 @@
 #include <asm/sigcontext.h>
 #include <asm/unistd.h>
 #include <asm/page.h>
+#include <asm/user.h>
 #include "user_util.h"
 #include "kern_util.h"
 #include "user.h"
@@ -217,6 +218,40 @@ void __init check_ptrace(void)
 	}
 	stop_ptraced_child(pid, stack, 0);
 	printk("OK\n");
+
+#ifdef PTRACE_SYSEMU
+	printk("Checking syscall emulation patch for ptrace...");
+	use_sysemu = 0;
+	pid = start_ptraced_child(&stack);
+	if(ptrace(PTRACE_SYSEMU, pid, 0, 0) >= 0) {
+		struct user_regs_struct regs;
+
+		if (waitpid(pid, &status, WUNTRACED) < 0)
+			panic("check_ptrace : wait failed, errno = %d", errno);
+		if(!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGTRAP))
+			panic("check_ptrace : expected SIGTRAP, "
+			      "got status = %d", status);
+
+		if (ptrace(PTRACE_GETREGS, pid, 0, &regs) < 0)
+			panic("check_ptrace : failed to read child "
+			      "registers, errno = %d", errno);
+		regs.orig_eax = pid;
+		if (ptrace(PTRACE_SETREGS, pid, 0, &regs) < 0)
+			panic("check_ptrace : failed to modify child "
+			      "registers, errno = %d", errno);
+
+		stop_ptraced_child(pid, stack, 0);
+
+		printk("OK\n");
+		use_sysemu = 1;
+	}
+	else
+	{
+		printk("missing\n");
+		stop_ptraced_child(pid, stack, 1);
+	}
+
+# endif /* PTRACE_SYSEMU */
 }
 
 int run_kernel_thread(int (*fn)(void *), void *arg, void **jmp_ptr)
diff -puN arch/um/kernel/skas/include/ptrace-skas.h~um-sysemu arch/um/kernel/skas/include/ptrace-skas.h
--- uml-linux-2.6.8.1/arch/um/kernel/skas/include/ptrace-skas.h~um-sysemu	2004-08-29 14:40:46.970071240 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/kernel/skas/include/ptrace-skas.h	2004-08-29 14:40:46.974070632 +0200
@@ -10,6 +10,13 @@
 
 #ifdef UML_CONFIG_MODE_SKAS
 
+/* syscall emulation path in ptrace */
+
+#ifndef PTRACE_SYSEMU
+#define PTRACE_SYSEMU 31
+#endif
+extern int use_sysemu;
+
 #include "skas_ptregs.h"
 
 #define HOST_FRAME_SIZE 17
diff -puN arch/um/kernel/skas/process.c~um-sysemu arch/um/kernel/skas/process.c
--- uml-linux-2.6.8.1/arch/um/kernel/skas/process.c~um-sysemu	2004-08-29 14:40:46.971071088 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/kernel/skas/process.c	2004-08-29 14:40:46.974070632 +0200
@@ -28,6 +28,10 @@
 #include "chan_user.h"
 #include "signal_user.h"
 
+#ifdef PTRACE_SYSEMU
+int use_sysemu = 0;
+#endif
+
 int is_skas_winch(int pid, int fd, void *data)
 {
 	if(pid != getpid())
@@ -68,6 +72,10 @@ static void handle_trap(int pid, union u
 		return;
 	}
 
+#ifdef PTRACE_SYSEMU
+	if (!use_sysemu)
+	{
+#endif
 	err = ptrace(PTRACE_POKEUSER, pid, PT_SYSCALL_NR_OFFSET, __NR_getpid);
 	if(err < 0)
 	        panic("handle_trap - nullifying syscall failed errno = %d\n", 
@@ -82,6 +90,9 @@ static void handle_trap(int pid, union u
 	if((err < 0) || !WIFSTOPPED(status) || (WSTOPSIG(status) != SIGTRAP))
 		panic("handle_trap - failed to wait at end of syscall, "
 		      "errno = %d, status = %d\n", errno, status);
+#ifdef PTRACE_SYSEMU
+	}
+#endif
 
 	handle_syscall(regs);
 }
@@ -139,6 +150,11 @@ void userspace(union uml_pt_regs *regs)
 
 	restore_registers(regs);
 		
+#ifdef PTRACE_SYSEMU
+	if (use_sysemu)
+		err = ptrace(PTRACE_SYSEMU, pid, 0, 0);
+	else
+#endif
 	err = ptrace(PTRACE_SYSCALL, pid, 0, 0);
 	if(err)
 		panic("userspace - PTRACE_SYSCALL failed, errno = %d\n", 
@@ -177,6 +193,12 @@ void userspace(union uml_pt_regs *regs)
 
 		restore_registers(regs);
 
+#ifdef PTRACE_SYSEMU
+		if (use_sysemu)
+			op = singlestepping_skas() ? PTRACE_SINGLESTEP :
+				PTRACE_SYSEMU;
+		else
+#endif
 		op = singlestepping_skas() ? PTRACE_SINGLESTEP : 
 			PTRACE_SYSCALL;
 		err = ptrace(op, pid, 0, 0);
_


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
