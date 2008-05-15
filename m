Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Date: Thu, 15 May 2008 16:11:22 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080515201122.GA12351@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [RFC PATCH 10/12] SKAS4 - Introduce STUB_ADDR
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
To: uml-user <user-mode-linux-user@lists.sourceforge.net>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

There were a number of repetitions of the calculation of an stub
address in a process address space.  This introduces STUB_ADDR to
eliminate the common code.

diff --git a/arch/um/include/skas/skas.h b/arch/um/include/skas/skas.h
index 061a362..331f343 100644
--- a/arch/um/include/skas/skas.h
+++ b/arch/um/include/skas/skas.h
@@ -10,6 +10,9 @@
 
 extern int have_siginfo_segv;
 
+#define STUB_ADDR(x) (STUB_CODE + (unsigned long) (x) - \
+		      (unsigned long) &__syscall_stub_start)
+
 extern int userspace_pid[];
 extern int proc_mm, ptrace_faultinfo, ptrace_ldt;
 extern int skas_needs_stub;
diff --git a/arch/um/os-Linux/skas/mem.c b/arch/um/os-Linux/skas/mem.c
index 5f09a9b..384e43b 100644
--- a/arch/um/os-Linux/skas/mem.c
+++ b/arch/um/os-Linux/skas/mem.c
@@ -45,9 +45,8 @@ static int __init init_syscall_regs(void)
 	get_safe_registers(syscall_regs);
 	stub_entry = &batch_syscall_stub;
 
-	syscall_regs[REGS_IP_INDEX] = STUB_CODE +
-		((unsigned long) stub_entry -
-		 (unsigned long) &__syscall_stub_start);
+	syscall_regs[REGS_IP_INDEX] = STUB_ADDR(stub_entry);
+
 	return 0;
 }
 
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 7cb760b..08297ae 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -264,10 +264,7 @@ static int userspace_tramp(void *stack)
 	}
 	if (!ptrace_faultinfo && (stack != NULL)) {
 		struct sigaction sa;
-
-		unsigned long v = STUB_CODE +
-				  (unsigned long) stub_segv_handler -
-				  (unsigned long) &__syscall_stub_start;
+		unsigned long v = STUB_ADDR(stub_segv_handler);
 
 		set_sigstack((void *) STUB_DATA, UM_KERN_PAGE_SIZE);
 		sigemptyset(&sa.sa_mask);
@@ -482,9 +479,7 @@ static int __init init_thread_regs(void)
 {
 	get_safe_registers(thread_regs);
 	/* Set parent's instruction pointer to start of clone-stub */
-	thread_regs[REGS_IP_INDEX] = STUB_CODE +
-				(unsigned long) stub_clone_handler -
-				(unsigned long) &__syscall_stub_start;
+	thread_regs[REGS_IP_INDEX] = STUB_ADDR(stub_clone_handler);
 	thread_regs[REGS_SP_INDEX] = STUB_DATA + UM_KERN_PAGE_SIZE -
 		sizeof(void *);
 #ifdef __SIGNAL_FRAMESIZE

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
