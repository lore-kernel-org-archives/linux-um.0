Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C1szp-0006ia-Nv for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 Aug 2004 13:43:21 -0700
Received: from mail-relay-4.tiscali.it ([213.205.33.44])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C1szn-0003sk-Nb for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 Aug 2004 13:43:20 -0700
Received: from zion.localdomain (62.11.74.135) by mail-relay-4.tiscali.it
	(7.1.021.3)
	id 40F3EBEA00A49F84 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 Aug 2004 22:43:13 +0200
From: blaisorblade_spam@yahoo.it
Message-Id: <20040830203552.302A1BD58@zion.localdomain>
Subject: [uml-devel] [patch 3/4] sysemu-only-if-supported
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
Date: Mon, 30 Aug 2004 22:35:52 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: blaisorblade_spam@yahoo.it


- Correct some error messages
- separate using_sysemu from sysemu_supported (so to refuse to activate sysemu
if it is not supported, avoiding panics)
- not probe sysemu if in tt mode.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 uml-linux-2.6.8.1-paolo/arch/um/kernel/process.c                  |   80 +++++-----
 uml-linux-2.6.8.1-paolo/arch/um/kernel/skas/include/ptrace-skas.h |    1 
 uml-linux-2.6.8.1-paolo/arch/um/kernel/skas/process.c             |    9 -
 uml-linux-2.6.8.1-paolo/arch/um/kernel/skas/process_kern.c        |    8 -
 4 files changed, 55 insertions(+), 43 deletions(-)

diff -puN arch/um/kernel/skas/process_kern.c~sysemu-only-if-supported arch/um/kernel/skas/process_kern.c
--- uml-linux-2.6.8.1/arch/um/kernel/skas/process_kern.c~sysemu-only-if-supported	2004-08-29 14:40:47.988916352 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/kernel/skas/process_kern.c	2004-08-29 14:40:47.994915440 +0200
@@ -25,13 +25,12 @@
 #include "filehandle.h"
 #include "proc_mm.h"
 
-#ifdef PTRACE_SYSEMU
 static atomic_t using_sysemu;
-#endif
+int sysemu_supported;
 
 void set_using_sysemu(int value)
 {
-	atomic_set(&using_sysemu, value);
+	atomic_set(&using_sysemu, sysemu_supported && value);
 }
 
 int get_using_sysemu(void)
@@ -63,6 +62,9 @@ int __init make_proc_sysemu(void)
 {
 	struct proc_dir_entry *ent;
 
+ 	if (mode_tt || !sysemu_supported)
+ 		return 0;
+
 	ent = create_proc_entry("sysemu", 00600, &proc_root);
 	if (ent == NULL)
 	{
diff -puN arch/um/kernel/process.c~sysemu-only-if-supported arch/um/kernel/process.c
--- uml-linux-2.6.8.1/arch/um/kernel/process.c~sysemu-only-if-supported	2004-08-29 14:40:47.989916200 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/kernel/process.c	2004-08-29 14:40:47.995915288 +0200
@@ -202,6 +202,49 @@ __uml_setup("nosysemu", nosysemu_cmd_par
 		"    To make it working, you need a kernel patch for your host, too.\n"
 		"    See http://perso.wanadoo.fr/laurent.vivier/UML/ for further information.\n");
 
+static void __init check_sysemu(void)
+{
+	void *stack;
+	int pid, n, status;
+
+	if (mode_tt)
+		return;
+
+	printk("Checking syscall emulation patch for ptrace...");
+	sysemu_supported = 0;
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
+		sysemu_supported = 1;
+		printk("found\n");
+	}
+	else
+	{
+		stop_ptraced_child(pid, stack, 1);
+		sysemu_supported = 0;
+		printk("missing\n");
+	}
+
+	set_using_sysemu(!force_sysemu_disabled);
+}
+
 void __init check_ptrace(void)
 {
 	void *stack;
@@ -234,42 +277,7 @@ void __init check_ptrace(void)
 	}
 	stop_ptraced_child(pid, stack, 0);
 	printk("OK\n");
-
-	printk("Checking syscall emulation patch for ptrace...");
-	set_using_sysemu(0);
-	pid = start_ptraced_child(&stack);
-	if(ptrace(PTRACE_SYSEMU, pid, 0, 0) >= 0) {
-		struct user_regs_struct regs;
-
-		if (waitpid(pid, &status, WUNTRACED) < 0)
-			panic("check_ptrace : wait failed, errno = %d", errno);
-		if(!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGTRAP))
-			panic("check_ptrace : expected SIGTRAP, "
-			      "got status = %d", status);
-
-		if (ptrace(PTRACE_GETREGS, pid, 0, &regs) < 0)
-			panic("check_ptrace : failed to read child "
-			      "registers, errno = %d", errno);
-		regs.orig_eax = pid;
-		if (ptrace(PTRACE_SETREGS, pid, 0, &regs) < 0)
-			panic("check_ptrace : failed to modify child "
-			      "registers, errno = %d", errno);
-
-		stop_ptraced_child(pid, stack, 0);
-
-		if (!force_sysemu_disabled) {
-			printk("found\n");
-			set_using_sysemu(1);
-		} else {
-			printk("found but disabled\n");
-		}
-	}
-	else
-	{
-		printk("missing\n");
-		stop_ptraced_child(pid, stack, 1);
-	}
-
+	check_sysemu();
 }
 
 int run_kernel_thread(int (*fn)(void *), void *arg, void **jmp_ptr)
diff -puN arch/um/kernel/skas/include/ptrace-skas.h~sysemu-only-if-supported arch/um/kernel/skas/include/ptrace-skas.h
--- uml-linux-2.6.8.1/arch/um/kernel/skas/include/ptrace-skas.h~sysemu-only-if-supported	2004-08-29 14:40:47.990916048 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/kernel/skas/include/ptrace-skas.h	2004-08-29 14:40:47.995915288 +0200
@@ -18,6 +18,7 @@
 
 void set_using_sysemu(int value);
 int get_using_sysemu(void);
+extern int sysemu_supported;
 
 #include "skas_ptregs.h"
 
diff -puN arch/um/kernel/skas/process.c~sysemu-only-if-supported arch/um/kernel/skas/process.c
--- uml-linux-2.6.8.1/arch/um/kernel/skas/process.c~sysemu-only-if-supported	2004-08-29 14:40:47.992915744 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/kernel/skas/process.c	2004-08-29 14:40:47.995915288 +0200
@@ -151,8 +151,8 @@ void userspace(union uml_pt_regs *regs)
 	else
 		err = ptrace(PTRACE_SYSCALL, pid, 0, 0);
 	if(err)
-		panic("userspace - PTRACE_SYSCALL failed, errno = %d\n", 
-		       errno);
+		panic("userspace - PTRACE_%s failed, errno = %d\n",
+		       local_using_sysemu ? "SYSEMU" : "SYSCALL", errno);
 	while(1){
 		CATCH_EINTR(err = waitpid(pid, &status, WUNTRACED));
 		if(err < 0)
@@ -199,8 +199,9 @@ void userspace(union uml_pt_regs *regs)
 
 		err = ptrace(op, pid, 0, 0);
 		if(err)
-			panic("userspace - PTRACE_SYSCALL failed, "
-			      "errno = %d\n", errno);
+			panic("userspace - PTRACE_%s failed, "
+			      "errno = %d\n",
+			      local_using_sysemu ? "SYSEMU" : "SYSCALL", errno);
 	}
 }
 
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
