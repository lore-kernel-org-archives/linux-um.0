Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CcnqP-0003kl-Eh for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 10 Dec 2004 08:42:13 -0800
Received: from dgate2.fujitsu-siemens.com ([217.115.66.36])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CcnqO-0000Ka-09 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 10 Dec 2004 08:42:13 -0800
Message-Id: <200412101642.iBAGg7A12850@trolli.pdb.fsc.net>
From: bstroesser@fujitsu-siemens.com
Subject: [uml-devel] [patch 1/1] make UML use PTRACE_OLDSETOPTIONS instead of
	PTRACE_SETOPTIONS
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
Date: Fri, 10 Dec 2004 17:41:49 +0100
To: jdike@addtoit.com
Cc: user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it, bstroesser@fujitsu-siemens.com


From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

To use ptrace-option PTRACE_O_TRACESYSGOOD, it must be enabled
by a PTRACE_SETOPTIONS call.
This call the first time was implemented in linux 2.4, where
PTRACE_SETOPTIONS was set to 21.
In linux 2.6, PTRACE_SETOPTIONS is redefined to 0x4200, while
the old value 21 still is available as PTRACE_OLDSETOPTIONS.
So, if UML uses PTRACE_SETOPTIONS, an UML-kernel built on a 2.4
won't run on a 2.6 host and vice versa.
UML always should use PTRACE_OLDSETOPTIONS with its value
of 21. Since PTRACE_OLDSETOPTIONS isn't defined on a 2.4
generally and on those 2.6 subarchs, that hadn't supported
TRACESYSGOOD on 2.4, we additionaly include:
  #ifndef PTRACE_OLDSETOPTIONS
  #define PTRACE_OLDSETOPTIONS PTRACE_SETOTIONS
  #endif
Some architectures only have PTRACE_SETOPTIONS with a value
of 0x4200, since they didn't support it on 2.4
On those architectures, the redefinition lets UML use 0x4200
as PTRACE_OLDSETOPTIONS.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>


---


diff -puN arch/um/kernel/tt/tracer.c~use-OLSSETOPTIONS arch/um/kernel/tt/tracer.c
--- linux-2.6.10-rc2-mm4/arch/um/kernel/tt/tracer.c~use-OLSSETOPTIONS	2004-12-10 15:53:52.344598828 +0100
+++ linux-2.6.10-rc2-mm4-root/arch/um/kernel/tt/tracer.c	2004-12-10 15:53:52.356594650 +0100
@@ -72,7 +72,7 @@ void attach_process(int pid)
 	   (ptrace(PTRACE_CONT, pid, 0, 0) < 0))
 		tracer_panic("OP_FORK failed to attach pid");
 	wait_for_stop(pid, SIGSTOP, PTRACE_CONT, NULL);
-	if (ptrace(PTRACE_SETOPTIONS, pid, 0, (void *)PTRACE_O_TRACESYSGOOD) < 0)
+	if (ptrace(PTRACE_OLDSETOPTIONS, pid, 0, (void *)PTRACE_O_TRACESYSGOOD) < 0)
 		tracer_panic("OP_FORK: PTRACE_SETOPTIONS failed, errno = %d", errno);
 	if(ptrace(PTRACE_CONT, pid, 0, 0) < 0)
 		tracer_panic("OP_FORK failed to continue process");
@@ -200,7 +200,7 @@ int tracer(int (*init_proc)(void *), voi
 		printf("waitpid on idle thread failed, errno = %d\n", errno);
 		exit(1);
 	}
-	if (ptrace(PTRACE_SETOPTIONS, pid, 0, (void *)PTRACE_O_TRACESYSGOOD) < 0) {
+	if (ptrace(PTRACE_OLDSETOPTIONS, pid, 0, (void *)PTRACE_O_TRACESYSGOOD) < 0) {
 		printf("Failed to PTRACE_SETOPTIONS for idle thread, errno = %d\n", errno);
 		exit(1);
 	}
diff -puN arch/um/kernel/tt/exec_user.c~use-OLSSETOPTIONS arch/um/kernel/tt/exec_user.c
--- linux-2.6.10-rc2-mm4/arch/um/kernel/tt/exec_user.c~use-OLSSETOPTIONS	2004-12-10 15:53:52.346598132 +0100
+++ linux-2.6.10-rc2-mm4-root/arch/um/kernel/tt/exec_user.c	2004-12-10 15:53:52.356594650 +0100
@@ -39,7 +39,7 @@ void do_exec(int old_pid, int new_pid)
 
 	os_kill_ptraced_process(old_pid, 0);
 
-	if (ptrace(PTRACE_SETOPTIONS, new_pid, 0, (void *)PTRACE_O_TRACESYSGOOD) < 0)
+	if (ptrace(PTRACE_OLDSETOPTIONS, new_pid, 0, (void *)PTRACE_O_TRACESYSGOOD) < 0)
 		tracer_panic("do_exec: PTRACE_SETOPTIONS failed, errno = %d", errno);
 
 	if(ptrace_setregs(new_pid, regs) < 0)
diff -puN arch/um/kernel/skas/process.c~use-OLSSETOPTIONS arch/um/kernel/skas/process.c
--- linux-2.6.10-rc2-mm4/arch/um/kernel/skas/process.c~use-OLSSETOPTIONS	2004-12-10 15:53:52.349597087 +0100
+++ linux-2.6.10-rc2-mm4-root/arch/um/kernel/skas/process.c	2004-12-10 15:53:52.356594650 +0100
@@ -122,7 +122,7 @@ void start_userspace(int cpu)
 		panic("start_userspace : expected SIGSTOP, got status = %d",
 		      status);
 
-	if (ptrace(PTRACE_SETOPTIONS, pid, NULL, (void *)PTRACE_O_TRACESYSGOOD) < 0)
+	if (ptrace(PTRACE_OLDSETOPTIONS, pid, NULL, (void *)PTRACE_O_TRACESYSGOOD) < 0)
 		panic("start_userspace : PTRACE_SETOPTIONS failed, errno=%d\n", 
 		      errno);
 
diff -puN arch/um/kernel/process.c~use-OLSSETOPTIONS arch/um/kernel/process.c
--- linux-2.6.10-rc2-mm4/arch/um/kernel/process.c~use-OLSSETOPTIONS	2004-12-10 15:53:52.351596391 +0100
+++ linux-2.6.10-rc2-mm4-root/arch/um/kernel/process.c	2004-12-10 15:53:52.357594302 +0100
@@ -321,7 +321,7 @@ void __init check_ptrace(void)
 	printk("Checking that ptrace can change system call numbers...");
 	pid = start_ptraced_child(&stack);
 
-	if(ptrace(PTRACE_SETOPTIONS, pid, 0, (void *)PTRACE_O_TRACESYSGOOD) < 0)
+	if (ptrace(PTRACE_OLDSETOPTIONS, pid, 0, (void *)PTRACE_O_TRACESYSGOOD) < 0)
 		panic("check_ptrace: PTRACE_SETOPTIONS failed, errno = %d", errno);
 
 	while(1){
diff -puN arch/um/include/ptrace_user.h~use-OLSSETOPTIONS arch/um/include/ptrace_user.h
--- linux-2.6.10-rc2-mm4/arch/um/include/ptrace_user.h~use-OLSSETOPTIONS	2004-12-10 15:56:44.711572089 +0100
+++ linux-2.6.10-rc2-mm4-root/arch/um/include/ptrace_user.h	2004-12-10 16:16:41.218676798 +0100
@@ -26,6 +26,26 @@ extern void ptrace_pokeuser(unsigned lon
 #define PTRACE_SYSEMU_SINGLESTEP 32
 #endif
 
+/* On architectures, that started to support PTRACE_O_TRACESYSGOOD
+ * in linux 2.4, there are two different definitions of
+ * PTRACE_SETOPTIONS: linux 2.4 uses 21 while linux 2.6 uses 0x4200.
+ * For binary compatibility, 2.6 also supports the old "21", named
+ * PTRACE_OLDSETOPTION. On these architectures, UML always must use
+ * "21", to ensure the kernel runs on 2.4 and 2.6 host without
+ * recompilation. So, we use PTRACE_OLDSETOPTIONS in UML.
+ * We also want to be able to build the kernel on 2.4, which doesn't
+ * have PTRACE_OLDSETOPTIONS. So, if it is missing, we declare
+ * PTRACE_OLDSETOPTIONS to to be the same as PTRACE_SETOPTIONS.
+ *
+ * On architectures, that start to support PTRACE_O_TRACESYSGOOD on
+ * linux 2.6, PTRACE_OLDSETOPTIONS never is defined, and also isn't
+ * supported by the host kernel. In that case, our trick lets us use
+ * the new 0x4200 with the name PTRACE_OLDSETOPTIONS.
+ */
+#ifndef PTRACE_OLDSETOPTIONS
+#define PTRACE_OLDSETOPTIONS PTRACE_SETOPTIONS
+#endif
+
 void set_using_sysemu(int value);
 int get_using_sysemu(void);
 extern int sysemu_supported;
_


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
