Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPWrf-0004o9-TB for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 17:56:39 -0800
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]
	helo=zion.localdomain)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CPWrd-0000S2-Cf for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 17:56:39 -0800
From: blaisorblade_spam@yahoo.it
Message-Id: <20041103231749.D2E9955C85@zion.localdomain>
Subject: [uml-devel] [patch 15/20] uml-more-careful-test-startup
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
Date: Thu, 04 Nov 2004 00:17:49 +0100
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, cw@f00f.org, blaisorblade_spam@yahoo.it, bodo.stroesser@fujitsu-siemens.com


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>, Bodo Stroesser <bodo.stroesser@fujitsu-siemens.com>

While testing the host ptrace(2) features, we modify the stack frame of a test
child which is doing a syscall (namely getpid). Either we override the syscall
number or the return value, which become the parent's pid, or we don't, and
the return value is the child's pid.

Actually, we only compared the return value with the child's pid, so we did
not notice a bug where the return value happened to be different from both. So
I added a stricter test here.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.9-paolo/arch/um/kernel/process.c           |   98 +++++++----
 vanilla-linux-2.6.9-paolo/arch/um/kernel/skas/process_kern.c |    2 
 2 files changed, 69 insertions(+), 31 deletions(-)

diff -puN arch/um/kernel/process.c~uml-more-careful-test-startup arch/um/kernel/process.c
--- vanilla-linux-2.6.9/arch/um/kernel/process.c~uml-more-careful-test-startup	2004-11-03 23:45:16.011004688 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/process.c	2004-11-03 23:45:16.015004080 +0100
@@ -137,14 +137,31 @@ int start_fork_tramp(void *thread_arg, u
 
 static int ptrace_child(void *arg)
 {
-	int pid = os_getpid();
+	int ret;
+	int pid = os_getpid(), ppid = getppid();
+	int sc_result;
 
 	if(ptrace(PTRACE_TRACEME, 0, 0, 0) < 0){
 		perror("ptrace");
 		os_kill_process(pid, 0);
 	}
 	os_stop_process(pid);
-	_exit(os_getpid() == pid);
+
+	/*This syscall will be intercepted by the parent. Don't call more than
+	 * once, please.*/
+	sc_result = os_getpid();
+
+	if (sc_result == pid)
+		ret = 1; /*Nothing modified by the parent, we are running
+			   normally.*/
+	else if (sc_result == ppid)
+		ret = 0; /*Expected in check_ptrace and check_sysemu when they
+			   succeed in modifying the stack frame*/
+	else
+		ret = 2; /*Serious trouble! This could be caused by a bug in
+			   host 2.6 SKAS3/2.6 patch before release -V6, together
+			   with a bug in the UML code itself.*/
+	_exit(ret);
 }
 
 static int start_ptraced_child(void **stack_out)
@@ -172,18 +189,36 @@ static int start_ptraced_child(void **st
 	return(pid);
 }
 
-static void stop_ptraced_child(int pid, void *stack, int exitcode)
+/* When testing for SYSEMU support, if it is one of the broken versions, we must
+ * just avoid using sysemu, not panic, but only if SYSEMU features are broken.
+ * So only for SYSEMU features we test mustpanic, while normal host features
+ * must work anyway!*/
+static int stop_ptraced_child(int pid, void *stack, int exitcode, int mustpanic)
 {
-	int status, n;
+	int status, n, ret = 0;
 
 	if(ptrace(PTRACE_CONT, pid, 0, 0) < 0)
 		panic("check_ptrace : ptrace failed, errno = %d", errno);
 	CATCH_EINTR(n = waitpid(pid, &status, 0));
-	if(!WIFEXITED(status) || (WEXITSTATUS(status) != exitcode))
-		panic("check_ptrace : child exited with status 0x%x", status);
+	if(!WIFEXITED(status) || (WEXITSTATUS(status) != exitcode)) {
+		int exit_with = WEXITSTATUS(status);
+		if (exit_with == 2)
+			printk("check_ptrace : child exited with status 2. "
+			       "Serious trouble happening! Try updating your "
+			       "host skas patch!\nDisabling SYSEMU support.");
+		printk("check_ptrace : child exited with exitcode %d, while "
+		      "expecting %d; status 0x%x", exit_with,
+		      exitcode, status);
+		if (mustpanic)
+			panic("\n");
+		else
+			printk("\n");
+		ret = -1;
+	}
 
 	if(munmap(stack, PAGE_SIZE) < 0)
 		panic("check_ptrace : munmap failed, errno = %d", errno);
+	return ret;
 }
 
 static int force_sysemu_disabled = 0;
@@ -213,33 +248,36 @@ static void __init check_sysemu(void)
 	printk("Checking syscall emulation patch for ptrace...");
 	sysemu_supported = 0;
 	pid = start_ptraced_child(&stack);
-	if(ptrace(PTRACE_SYSEMU, pid, 0, 0) >= 0) {
-		CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
-		if (n < 0)
-			panic("check_ptrace : wait failed, errno = %d", errno);
-		if(!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGTRAP))
-			panic("check_ptrace : expected SIGTRAP, "
-			      "got status = %d", status);
 
-		n = ptrace(PTRACE_POKEUSER, pid, PT_SYSCALL_RET_OFFSET,
-			   os_getpid());
-		if(n < 0)
-			panic("check_ptrace : failed to modify system "
-			      "call return, errno = %d", errno);
+	if(ptrace(PTRACE_SYSEMU, pid, 0, 0) < 0)
+		goto fail;
 
-		stop_ptraced_child(pid, stack, 0);
+	CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
+	if (n < 0)
+		panic("check_sysemu : wait failed, errno = %d", errno);
+	if(!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGTRAP))
+		panic("check_sysemu : expected SIGTRAP, "
+		      "got status = %d", status);
 
-		sysemu_supported = 1;
-		printk("OK\n");
-	}
-	else
-	{
-		stop_ptraced_child(pid, stack, 1);
-		sysemu_supported = 0;
-		printk("missing\n");
-	}
+	n = ptrace(PTRACE_POKEUSER, pid, PT_SYSCALL_RET_OFFSET,
+		   os_getpid());
+	if(n < 0)
+		panic("check_sysemu : failed to modify system "
+		      "call return, errno = %d", errno);
 
+	if (stop_ptraced_child(pid, stack, 0, 0) < 0)
+		goto fail_stopped;
+
+	sysemu_supported = 1;
+	printk("OK\n");
 	set_using_sysemu(!force_sysemu_disabled);
+	return;
+
+fail:
+	stop_ptraced_child(pid, stack, 1, 0);
+fail_stopped:
+	sysemu_supported = 0;
+	printk("missing\n");
 }
 
 void __init check_ptrace(void)
@@ -272,7 +310,7 @@ void __init check_ptrace(void)
 			break;
 		}
 	}
-	stop_ptraced_child(pid, stack, 0);
+	stop_ptraced_child(pid, stack, 0, 1);
 	printk("OK\n");
 	check_sysemu();
 }
@@ -320,7 +358,7 @@ int can_do_skas(void)
 	else printf("found\n");
 
 	init_registers(pid);
-	stop_ptraced_child(pid, stack, 1);
+	stop_ptraced_child(pid, stack, 1, 1);
 
 	printf("Checking for /proc/mm...");
 	if(os_access("/proc/mm", OS_ACC_W_OK) < 0){
diff -puN arch/um/kernel/skas/process_kern.c~uml-more-careful-test-startup arch/um/kernel/skas/process_kern.c
--- vanilla-linux-2.6.9/arch/um/kernel/skas/process_kern.c~uml-more-careful-test-startup	2004-11-03 23:45:16.012004536 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/skas/process_kern.c	2004-11-03 23:45:16.015004080 +0100
@@ -24,7 +24,7 @@
 #include "mode.h"
 #include "proc_mm.h"
 
-static atomic_t using_sysemu;
+static atomic_t using_sysemu = ATOMIC_INIT(0);
 int sysemu_supported;
 
 void set_using_sysemu(int value)
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
