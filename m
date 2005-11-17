Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EcqCm-0008O5-Lj for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Nov 2005 12:18:00 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EcqCc-00078p-Ky
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Nov 2005 12:17:51 -0800
Message-Id: <200511172110.jAHLASIB010204@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 3/4] UML - Properly invoke x86_64 system calls
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
Date: Thu, 17 Nov 2005 16:10:28 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

This patch makes stub_segv use the stub_syscall macros.  This was
needed anyway, but the bug that prompted this was the discovery that
gcc was storing stuff in RCX, which is trashed across a system
call.  This is exactly the sort of problem that the new macros fix.
There is a stub_syscall0 for getpid.
stub_segv was changed to be a libc file, and that caused some
include changes.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/include/sysdep-i386/stub.h
===================================================================
--- linux-2.6.15.orig/arch/um/include/sysdep-i386/stub.h	2005-11-17 14:59:30.000000000 -0500
+++ linux-2.6.15/arch/um/include/sysdep-i386/stub.h	2005-11-17 14:59:55.000000000 -0500
@@ -16,6 +16,15 @@
 #define STUB_MMAP_NR __NR_mmap2
 #define MMAP_OFFSET(o) ((o) >> PAGE_SHIFT)
 
+static inline long stub_syscall0(long syscall)
+{
+	long ret;
+
+	__asm__ volatile ("int $0x80" : "=a" (ret) : "0" (syscall));
+
+	return ret;
+}
+
 static inline long stub_syscall1(long syscall, long arg1)
 {
 	long ret;
Index: linux-2.6.15/arch/um/include/sysdep-x86_64/stub.h
===================================================================
--- linux-2.6.15.orig/arch/um/include/sysdep-x86_64/stub.h	2005-11-17 14:59:30.000000000 -0500
+++ linux-2.6.15/arch/um/include/sysdep-x86_64/stub.h	2005-11-17 14:59:55.000000000 -0500
@@ -6,7 +6,6 @@
 #ifndef __SYSDEP_STUB_H
 #define __SYSDEP_STUB_H
 
-#include <asm/ptrace.h>
 #include <asm/unistd.h>
 #include <sysdep/ptrace_user.h>
 
@@ -20,6 +19,17 @@
 #define __syscall_clobber "r11","rcx","memory"
 #define __syscall "syscall"
 
+static inline long stub_syscall0(long syscall)
+{
+	long ret;
+
+	__asm__ volatile (__syscall
+		: "=a" (ret)
+		: "0" (syscall) : __syscall_clobber );
+
+	return ret;
+}
+
 static inline long stub_syscall2(long syscall, long arg1, long arg2)
 {
 	long ret;
Index: linux-2.6.15/arch/um/sys-i386/Makefile
===================================================================
--- linux-2.6.15.orig/arch/um/sys-i386/Makefile	2005-11-17 14:59:30.000000000 -0500
+++ linux-2.6.15/arch/um/sys-i386/Makefile	2005-11-17 14:59:55.000000000 -0500
@@ -5,7 +5,7 @@
 obj-$(CONFIG_HIGHMEM) += highmem.o
 obj-$(CONFIG_MODULES) += module.o
 
-USER_OBJS := bugs.o ptrace_user.o sigcontext.o fault.o
+USER_OBJS := bugs.o ptrace_user.o sigcontext.o fault.o stub_segv.o
 
 SYMLINKS = bitops.c semaphore.c highmem.c module.c
 
Index: linux-2.6.15/arch/um/sys-i386/stub_segv.c
===================================================================
--- linux-2.6.15.orig/arch/um/sys-i386/stub_segv.c	2005-11-17 14:59:30.000000000 -0500
+++ linux-2.6.15/arch/um/sys-i386/stub_segv.c	2005-11-17 14:59:55.000000000 -0500
@@ -3,9 +3,11 @@
  * Licensed under the GPL
  */
 
-#include <asm/signal.h>
+#include <signal.h>
+#include <sys/select.h> /* The only way I can see to get sigset_t */
 #include <asm/unistd.h>
 #include "uml-config.h"
+#include "sysdep/stub.h"
 #include "sysdep/sigcontext.h"
 #include "sysdep/faultinfo.h"
 
@@ -13,13 +15,14 @@
 stub_segv_handler(int sig)
 {
 	struct sigcontext *sc = (struct sigcontext *) (&sig + 1);
+	int pid;
 
 	GET_FAULTINFO_FROM_SC(*((struct faultinfo *) UML_CONFIG_STUB_DATA),
 			      sc);
 
-	__asm__("movl %0, %%eax ; int $0x80": : "g" (__NR_getpid));
-	__asm__("movl %%eax, %%ebx ; movl %0, %%eax ; movl %1, %%ecx ;"
-		"int $0x80": : "g" (__NR_kill), "g" (SIGUSR1));
+	pid = stub_syscall0(__NR_getpid);
+	stub_syscall2(__NR_kill, pid, SIGUSR1);
+
 	/* Load pointer to sigcontext into esp, since we need to leave
 	 * the stack in its original form when we do the sigreturn here, by
 	 * hand.
Index: linux-2.6.15/arch/um/sys-x86_64/Makefile
===================================================================
--- linux-2.6.15.orig/arch/um/sys-x86_64/Makefile	2005-11-17 14:59:30.000000000 -0500
+++ linux-2.6.15/arch/um/sys-x86_64/Makefile	2005-11-17 14:59:55.000000000 -0500
@@ -12,7 +12,7 @@
 obj-y := ksyms.o
 obj-$(CONFIG_MODULES) += module.o um_module.o
 
-USER_OBJS := ptrace_user.o sigcontext.o
+USER_OBJS := ptrace_user.o sigcontext.o stub_segv.o
 
 SYMLINKS = bitops.c csum-copy.S csum-partial.c csum-wrappers.c ldt.c memcpy.S \
 	thunk.S module.c
Index: linux-2.6.15/arch/um/sys-x86_64/stub_segv.c
===================================================================
--- linux-2.6.15.orig/arch/um/sys-x86_64/stub_segv.c	2005-11-17 14:59:30.000000000 -0500
+++ linux-2.6.15/arch/um/sys-x86_64/stub_segv.c	2005-11-17 15:12:23.000000000 -0500
@@ -3,14 +3,14 @@
  * Licensed under the GPL
  */
 
-#include <asm/signal.h>
+#include <stddef.h>
+#include <signal.h>
 #include <linux/compiler.h>
 #include <asm/unistd.h>
-#include <asm/ucontext.h>
 #include "uml-config.h"
 #include "sysdep/sigcontext.h"
 #include "sysdep/faultinfo.h"
-#include <stddef.h>
+#include "sysdep/stub.h"
 
 /* Copied from sys-x86_64/signal.c - Can't find an equivalent definition
  * in the libc headers anywhere.
@@ -31,21 +31,21 @@
 stub_segv_handler(int sig)
 {
 	struct ucontext *uc;
+        int pid;
 
 	__asm__("movq %%rdx, %0" : "=g" (uc) :);
 	GET_FAULTINFO_FROM_SC(*((struct faultinfo *) UML_CONFIG_STUB_DATA),
 			      &uc->uc_mcontext);
 
-	__asm__("movq %0, %%rax ; syscall": : "g" (__NR_getpid));	
-	__asm__("movq %%rax, %%rdi ; movq %0, %%rax ; movq %1, %%rsi ;"
-		"syscall": : "g" (__NR_kill), "g" (SIGUSR1) : 
-		"%rdi", "%rax", "%rsi");
+	pid = stub_syscall0(__NR_getpid);
+	stub_syscall2(__NR_kill, pid, SIGUSR1);
+
 	/* sys_sigreturn expects that the stack pointer will be 8 bytes into
 	 * the signal frame.  So, we use the ucontext pointer, which we know
 	 * already, to get the signal frame pointer, and add 8 to that.
 	 */
-	__asm__("movq %0, %%rsp": : 
+	__asm__("movq %0, %%rsp; movq %1, %%rax ; syscall": : 
 		"g" ((unsigned long) container_of(uc, struct rt_sigframe, 
-						  uc) + 8));
-	__asm__("movq %0, %%rax ; syscall" : : "g" (__NR_rt_sigreturn));
+						  uc) + 8),
+                "g" (__NR_rt_sigreturn));
 }



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
