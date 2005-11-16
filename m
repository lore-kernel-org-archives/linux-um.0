Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EcDaa-00075r-0U for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 15 Nov 2005 19:04:00 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EcDaW-0001F0-2m
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 15 Nov 2005 19:04:00 -0800
Received: from localhost.localdomain (localhost [127.0.0.1])
	by grelber.thyrsus.com (8.13.4/8.13.4) with ESMTP id jAG4bdDE022821
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 15 Nov 2005 23:37:40 -0500
From: Rob Landley <rob@landley.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_QGqeDUNBqA4Km+w"
Message-Id: <200511152103.44584.rob@landley.net>
Subject: [uml-devel] Rollup patch to run 2.6.15-rc1 on x86-64 PLD Linux.
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
Date: Tue, 15 Nov 2005 21:03:44 -0600
To: user-mode-linux-devel@lists.sourceforge.net

--Boundary-00=_QGqeDUNBqA4Km+w
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Here is the set of changes that got me a working 2.6.15-rc1 x86-64 UML under 
PLD Linux.  This includes several patches from Jeff (two of which I had to 
apply by hand because the hunks didn't match any known Linux kernel).

There shouldn't be anything new here, I just wanted to make sure that 
everything needed was listed in one place.  Here's hoping -rc2 works out of 
the box. :)

Rob

--Boundary-00=_QGqeDUNBqA4Km+w
Content-Type: text/x-diff; charset="us-ascii"; name="linux-x86-64-fixes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="linux-x86-64-fixes.patch"

Tylko w linux-2.6.15-rc1/: allno.config
diff -ur linux-2.6.14/arch/um/include/sysdep-i386/stub.h linux-2.6.15-rc1/arch/um/include/sysdep-i386/stub.h
--- linux-2.6.14/arch/um/include/sysdep-i386/stub.h	2005-11-16 02:57:42.088694136 +0100
+++ linux-2.6.15-rc1/arch/um/include/sysdep-i386/stub.h	2005-11-14 23:20:54.853517576 +0100
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
diff -ur linux-2.6.14/arch/um/include/sysdep-x86_64/stub.h linux-2.6.15-rc1/arch/um/include/sysdep-x86_64/stub.h
--- linux-2.6.14/arch/um/include/sysdep-x86_64/stub.h	2005-11-16 02:57:42.088694136 +0100
+++ linux-2.6.15-rc1/arch/um/include/sysdep-x86_64/stub.h	2005-11-14 23:20:54.853517576 +0100
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
diff -ur linux-2.6.14/arch/um/Kconfig.x86_64 linux-2.6.15-rc1/arch/um/Kconfig.x86_64
--- linux-2.6.14/arch/um/Kconfig.x86_64	2005-11-16 02:57:42.083694896 +0100
+++ linux-2.6.15-rc1/arch/um/Kconfig.x86_64	2005-11-14 23:25:30.035683528 +0100
@@ -9,7 +9,7 @@
 #XXX: this is so in the underlying arch, but it's wrong!!!
 config RWSEM_GENERIC_SPINLOCK
 	bool
-	default y
+	default n
 
 config SEMAPHORE_SLEEPERS
 	bool
diff -ur linux-2.6.14/arch/um/kernel/skas/clone.c linux-2.6.15-rc1/arch/um/kernel/skas/clone.c
--- linux-2.6.14/arch/um/kernel/skas/clone.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.15-rc1/arch/um/kernel/skas/clone.c	2005-11-16 00:47:29.193707008 +0100
@@ -9,9 +9,13 @@
 #include "stub-data.h"
 #include "uml-config.h"
 #include "sysdep/stub.h"
+#include "kern_constants.h"
 
 /* This is in a separate file because it needs to be compiled with any
  * extraneous gcc flags (-pg, -fprofile-arcs, -ftest-coverage) disabled
+ *
+ * Use UM_KERN_PAGE_SIZE instead of PAGE_SIZE because that calls getpagesize
+ * on some systems.
  */
 void __attribute__ ((__section__ (".__syscall_stub")))
 stub_clone_handler(void)
@@ -20,7 +24,7 @@
 	struct stub_data *from = (struct stub_data *) UML_CONFIG_STUB_DATA;
 
 	err = stub_syscall2(__NR_clone, CLONE_PARENT | CLONE_FILES | SIGCHLD,
-			    UML_CONFIG_STUB_DATA + PAGE_SIZE / 2 -
+			    UML_CONFIG_STUB_DATA + UM_KERN_PAGE_SIZE / 2 -
 			    sizeof(void *));
 	if(err != 0)
 		goto out;
@@ -34,9 +38,9 @@
 	if(err)
 		goto out;
 
-	err = stub_syscall6(STUB_MMAP_NR, UML_CONFIG_STUB_DATA, PAGE_SIZE,
-			    PROT_READ | PROT_WRITE, MAP_FIXED | MAP_SHARED,
-			    from->fd, from->offset);
+       err = stub_syscall6(STUB_MMAP_NR, UML_CONFIG_STUB_DATA,
+                           UM_KERN_PAGE_SIZE, PROT_READ | PROT_WRITE,
+                           MAP_FIXED | MAP_SHARED, from->fd, from->offset);
  out:
 	/* save current result. Parent: pid; child: retcode of mmap */
 	from->err = err;
diff -ur linux-2.6.14/arch/um/Makefile linux-2.6.15-rc1/arch/um/Makefile
--- linux-2.6.14/arch/um/Makefile	2005-11-16 02:57:42.083694896 +0100
+++ linux-2.6.15-rc1/arch/um/Makefile	2005-11-14 23:24:24.355668408 +0100
@@ -107,7 +107,7 @@
 prepare: $(ARCH_DIR)/include/kern_constants.h
 
 LINK-$(CONFIG_LD_SCRIPT_STATIC) += -static
-LINK-$(CONFIG_LD_SCRIPT_DYN) += -Wl,-rpath,/lib
+LINK-$(CONFIG_LD_SCRIPT_DYN) += -Wl,-rpath,/lib64
 
 CPP_MODE-$(CONFIG_MODE_TT) := -DMODE_TT
 CONFIG_KERNEL_STACK_ORDER ?= 2
diff -ur linux-2.6.14/arch/um/sys-i386/Makefile linux-2.6.15-rc1/arch/um/sys-i386/Makefile
--- linux-2.6.14/arch/um/sys-i386/Makefile	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.15-rc1/arch/um/sys-i386/Makefile	2005-11-14 23:20:54.854517424 +0100
@@ -5,7 +5,7 @@
 obj-$(CONFIG_HIGHMEM) += highmem.o
 obj-$(CONFIG_MODULES) += module.o
 
-USER_OBJS := bugs.o ptrace_user.o sigcontext.o fault.o
+USER_OBJS := bugs.o ptrace_user.o sigcontext.o fault.o stub_segv.o
 
 SYMLINKS = bitops.c semaphore.c highmem.c module.c
 
diff -ur linux-2.6.14/arch/um/sys-i386/stub_segv.c linux-2.6.15-rc1/arch/um/sys-i386/stub_segv.c
--- linux-2.6.14/arch/um/sys-i386/stub_segv.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.15-rc1/arch/um/sys-i386/stub_segv.c	2005-11-14 23:23:45.426586528 +0100
@@ -3,9 +3,11 @@
  * Licensed under the GPL
  */
 
+#include <sys/select.h> /* The only way I can see to get sigset_t */
 #include <asm/signal.h>
 #include <asm/unistd.h>
 #include "uml-config.h"
+#include "sysdep/stub.h"
 #include "sysdep/sigcontext.h"
 #include "sysdep/faultinfo.h"
 
@@ -17,13 +19,16 @@
 	GET_FAULTINFO_FROM_SC(*((struct faultinfo *) UML_CONFIG_STUB_DATA),
 			      sc);
 
-	__asm__("movl %0, %%eax ; int $0x80": : "g" (__NR_getpid));
-	__asm__("movl %%eax, %%ebx ; movl %0, %%eax ; movl %1, %%ecx ;"
-		"int $0x80": : "g" (__NR_kill), "g" (SIGUSR1));
+//	__asm__("movl %0, %%eax ; int $0x80": : "g" (__NR_getpid));
+//	__asm__("movl %%eax, %%ebx ; movl %0, %%eax ; movl %1, %%ecx ;"
+//		"int $0x80": : "g" (__NR_kill), "g" (SIGUSR1));
 	/* Load pointer to sigcontext into esp, since we need to leave
 	 * the stack in its original form when we do the sigreturn here, by
 	 * hand.
 	 */
-	__asm__("mov %0,%%esp ; movl %1, %%eax ; "
-		"int $0x80" : : "a" (sc), "g" (__NR_sigreturn));
+	 __asm__("mov %0,%%esp" : : "a" (sc));
+	stub_syscall0(__NR_sigreturn);
+
+//	__asm__("mov %0,%%esp ; movl %1, %%eax ; "
+//		"int $0x80" : : "a" (sc), "g" (__NR_sigreturn));
 }
diff -ur linux-2.6.14/arch/um/sys-x86_64/Makefile linux-2.6.15-rc1/arch/um/sys-x86_64/Makefile
--- linux-2.6.14/arch/um/sys-x86_64/Makefile	2005-11-16 02:57:42.098692616 +0100
+++ linux-2.6.15-rc1/arch/um/sys-x86_64/Makefile	2005-11-14 23:20:54.854517424 +0100
@@ -12,7 +12,7 @@
 obj-y := ksyms.o
 obj-$(CONFIG_MODULES) += module.o um_module.o
 
-USER_OBJS := ptrace_user.o sigcontext.o
+USER_OBJS := ptrace_user.o sigcontext.o stub_segv.o
 
 SYMLINKS = bitops.c csum-copy.S csum-partial.c csum-wrappers.c ldt.c memcpy.S \
 	thunk.S module.c
diff -ur linux-2.6.14/arch/um/sys-x86_64/stub_segv.c linux-2.6.15-rc1/arch/um/sys-x86_64/stub_segv.c
--- linux-2.6.14/arch/um/sys-x86_64/stub_segv.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.15-rc1/arch/um/sys-x86_64/stub_segv.c	2005-11-15 08:18:28.661397632 +0100
@@ -3,13 +3,14 @@
  * Licensed under the GPL
  */
 
-#include <asm/signal.h>
 #include <linux/compiler.h>
+#include <signal.h>
 #include <asm/unistd.h>
-#include <asm/ucontext.h>
+#include <asm/sigcontext.h>
 #include "uml-config.h"
 #include "sysdep/sigcontext.h"
 #include "sysdep/faultinfo.h"
+#include "sysdep/stub.h"
 #include <stddef.h>
 
 /* Copied from sys-x86_64/signal.c - Can't find an equivalent definition
@@ -31,15 +32,15 @@
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
@@ -47,5 +48,5 @@
 	__asm__("movq %0, %%rsp": : 
 		"g" ((unsigned long) container_of(uc, struct rt_sigframe, 
 						  uc) + 8));
-	__asm__("movq %0, %%rax ; syscall" : : "g" (__NR_rt_sigreturn));
+	stub_syscall0(__NR_rt_sigreturn);
 }

--Boundary-00=_QGqeDUNBqA4Km+w--


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
