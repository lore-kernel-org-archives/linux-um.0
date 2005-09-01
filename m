Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EAxTO-00066U-24	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Sep 2005 15:23:54 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EAxTL-0001Ff-Uc
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Sep 2005 15:23:53 -0700
Message-Id: <200509012217.j81MHMKt011572@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 11/12] UML - Fix advanced sysemu check
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
Date: Thu, 01 Sep 2005 18:17:22 -0400
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

cleanup and fix the check for advanced sysemu
(PTRACE_SYSEMU_SINGLESTEP option)

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: test/arch/um/os-Linux/start_up.c
===================================================================
--- test.orig/arch/um/os-Linux/start_up.c	2005-09-01 17:19:47.000000000 -0400
+++ test/arch/um/os-Linux/start_up.c	2005-09-01 17:21:35.000000000 -0400
@@ -161,7 +161,7 @@
 static void __init check_sysemu(void)
 {
 	void *stack;
-	int pid, syscall, n, status, count=0;
+ 	int pid, n, status, count=0;
 
 	printk("Checking syscall emulation patch for ptrace...");
 	sysemu_supported = 0;
@@ -192,6 +192,12 @@
 
 	printk("Checking advanced syscall emulation patch for ptrace...");
 	pid = start_ptraced_child(&stack);
+
+	if(ptrace(PTRACE_OLDSETOPTIONS, pid, 0, 
+		  (void *) PTRACE_O_TRACESYSGOOD) < 0)
+		panic("check_ptrace: PTRACE_OLDSETOPTIONS failed, errno = %d",
+		      errno);
+
 	while(1){
 		count++;
 		if(ptrace(PTRACE_SYSEMU_SINGLESTEP, pid, 0, 0) < 0)
@@ -199,15 +205,10 @@
 		CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
 		if(n < 0)
 			panic("check_ptrace : wait failed, errno = %d", errno);
-		if(!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGTRAP))
-			panic("check_ptrace : expected (SIGTRAP|SYSCALL_TRAP), "
-			      "got status = %d", status);
-
-		syscall = ptrace(PTRACE_PEEKUSR, pid, PT_SYSCALL_NR_OFFSET,
-				 0);
-		if(syscall == __NR_getpid){
+		if(WIFSTOPPED(status) && (WSTOPSIG(status) == (SIGTRAP|0x80))){
 			if (!count)
-				panic("check_ptrace : SYSEMU_SINGLESTEP doesn't singlestep");
+				panic("check_ptrace : SYSEMU_SINGLESTEP "
+				      "doesn't singlestep");
 			n = ptrace(PTRACE_POKEUSR, pid, PT_SYSCALL_RET_OFFSET,
 				   os_getpid());
 			if(n < 0)
@@ -215,6 +216,11 @@
 				      "call return, errno = %d", errno);
 			break;
 		}
+		else if(WIFSTOPPED(status) && (WSTOPSIG(status) == SIGTRAP))
+			count++;
+		else
+			panic("check_ptrace : expected SIGTRAP or "
+			      "(SIGTRAP|0x80), got status = %d", status);
 	}
 	if (stop_ptraced_child(pid, stack, 0, 0) < 0)
 		goto fail_stopped;
@@ -250,8 +256,8 @@
 		CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
 		if(n < 0)
 			panic("check_ptrace : wait failed, errno = %d", errno);
-		if(!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGTRAP + 0x80))
-			panic("check_ptrace : expected SIGTRAP + 0x80, "
+		if(!WIFSTOPPED(status) || (WSTOPSIG(status) != (SIGTRAP|0x80)))
+			panic("check_ptrace : expected (SIGTRAP|0x80), "
 			      "got status = %d", status);
 		
 		syscall = ptrace(PTRACE_PEEKUSR, pid, PT_SYSCALL_NR_OFFSET,



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
