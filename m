Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EblTP-0005e6-J1 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Nov 2005 13:02:43 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EblTM-0002xM-To
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Nov 2005 13:02:43 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] [PATCH] Ok, I build x86-64 -skas0,
	and it still segfaults.
Message-ID: <20051114215517.GA9579@ccure.user-mode-linux.org>
References: <200511121936.41697.rob@landley.net>
	<20051113193256.GA25736@ccure.user-mode-linux.org>
	<200511132020.01596.blaisorblade@yahoo.it>
	<200511131732.11279.rob@landley.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
In-Reply-To: <200511131732.11279.rob@landley.net>
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
Date: Mon, 14 Nov 2005 16:55:17 -0500
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net, Blaisorblade <blaisorblade@yahoo.it>


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 13, 2005 at 05:32:10PM -0600, Rob Landley wrote:
> moan moan

Can you try the x86-64-clobbers-rcx patch below?

If you don't have it already, apply the fix-x86-stubs patch first.

Paolo, could you eyeball this one for me?  This applies the stub_syscall*
goodness to stub_segv.c.

				Jeff


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=x86-64-clobbers-rcx

Index: linux-2.6.14/arch/um/include/sysdep-i386/stub.h
===================================================================
--- linux-2.6.14.orig/arch/um/include/sysdep-i386/stub.h	2005-11-14 15:48:21.000000000 -0500
+++ linux-2.6.14/arch/um/include/sysdep-i386/stub.h	2005-11-14 15:48:30.000000000 -0500
@@ -16,6 +16,15 @@ extern void stub_clone_handler(void);
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
Index: linux-2.6.14/arch/um/include/sysdep-x86_64/stub.h
===================================================================
--- linux-2.6.14.orig/arch/um/include/sysdep-x86_64/stub.h	2005-11-14 15:45:09.000000000 -0500
+++ linux-2.6.14/arch/um/include/sysdep-x86_64/stub.h	2005-11-14 15:45:21.000000000 -0500
@@ -6,7 +6,6 @@
 #ifndef __SYSDEP_STUB_H
 #define __SYSDEP_STUB_H
 
-#include <asm/ptrace.h>
 #include <asm/unistd.h>
 #include <sysdep/ptrace_user.h>
 
@@ -20,6 +19,17 @@ extern void stub_clone_handler(void);
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
Index: linux-2.6.14/arch/um/sys-i386/Makefile
===================================================================
--- linux-2.6.14.orig/arch/um/sys-i386/Makefile	2005-11-10 11:42:11.000000000 -0500
+++ linux-2.6.14/arch/um/sys-i386/Makefile	2005-11-14 15:49:12.000000000 -0500
@@ -5,7 +5,7 @@ obj-y = bitops.o bugs.o checksum.o delay
 obj-$(CONFIG_HIGHMEM) += highmem.o
 obj-$(CONFIG_MODULES) += module.o
 
-USER_OBJS := bugs.o ptrace_user.o sigcontext.o fault.o
+USER_OBJS := bugs.o ptrace_user.o sigcontext.o fault.o stub_segv.o
 
 SYMLINKS = bitops.c semaphore.c highmem.c module.c
 
Index: linux-2.6.14/arch/um/sys-i386/stub_segv.c
===================================================================
--- linux-2.6.14.orig/arch/um/sys-i386/stub_segv.c	2005-11-10 11:41:46.000000000 -0500
+++ linux-2.6.14/arch/um/sys-i386/stub_segv.c	2005-11-14 15:56:22.000000000 -0500
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
 
@@ -17,13 +19,10 @@ stub_segv_handler(int sig)
 	GET_FAULTINFO_FROM_SC(*((struct faultinfo *) UML_CONFIG_STUB_DATA),
 			      sc);
 
-/*	__asm__("movl %0, %%eax ; int $0x80": : "g" (__NR_getpid));
-	__asm__("movl %%eax, %%ebx ; movl %0, %%eax ; movl %1, %%ecx ;"
-		"int $0x80": : "g" (__NR_kill), "g" (SIGUSR1)); */
 	/* Load pointer to sigcontext into esp, since we need to leave
 	 * the stack in its original form when we do the sigreturn here, by
 	 * hand.
 	 */
-	__asm__("mov %0,%%esp ; movl %1, %%eax ; "
-		"int $0x80" : : "a" (sc), "g" (__NR_sigreturn));
+	__asm__("mov %0,%%esp" : : "a" (sc));
+	stub_syscall0(__NR_sigreturn);
 }
Index: linux-2.6.14/arch/um/sys-x86_64/Makefile
===================================================================
--- linux-2.6.14.orig/arch/um/sys-x86_64/Makefile	2005-11-04 14:43:30.000000000 -0500
+++ linux-2.6.14/arch/um/sys-x86_64/Makefile	2005-11-14 15:45:21.000000000 -0500
@@ -12,7 +12,7 @@ lib-y = bitops.o bugs.o csum-partial.o d
 obj-y := ksyms.o
 obj-$(CONFIG_MODULES) += module.o um_module.o
 
-USER_OBJS := ptrace_user.o sigcontext.o
+USER_OBJS := ptrace_user.o sigcontext.o stub_segv.o
 
 SYMLINKS = bitops.c csum-copy.S csum-partial.c csum-wrappers.c gate_vma.c \
 	ldt.c memcpy.S thunk.S module.c
Index: linux-2.6.14/arch/um/sys-x86_64/stub_segv.c
===================================================================
--- linux-2.6.14.orig/arch/um/sys-x86_64/stub_segv.c	2005-11-14 15:45:09.000000000 -0500
+++ linux-2.6.14/arch/um/sys-x86_64/stub_segv.c	2005-11-14 15:45:21.000000000 -0500
@@ -3,13 +3,16 @@
  * Licensed under the GPL
  */
 
-#include <asm/signal.h>
 #include <linux/compiler.h>
+#include <asm/signal.h>
 #include <asm/unistd.h>
+#include <asm/sigcontext.h>
+#include <asm/siginfo.h>
 #include <asm/ucontext.h>
 #include "uml-config.h"
 #include "sysdep/sigcontext.h"
 #include "sysdep/faultinfo.h"
+#include "sysdep/stub.h"
 #include <stddef.h>
 
 /* Copied from sys-x86_64/signal.c - Can't find an equivalent definition
@@ -31,15 +34,15 @@ void __attribute__ ((__section__ (".__sy
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
@@ -47,5 +50,5 @@ stub_segv_handler(int sig)
 	__asm__("movq %0, %%rsp": : 
 		"g" ((unsigned long) container_of(uc, struct rt_sigframe, 
 						  uc) + 8));
-	__asm__("movq %0, %%rax ; syscall" : : "g" (__NR_rt_sigreturn));
+	stub_syscall0(__NR_rt_sigreturn);
 }

--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=fix-x86-stubs

# From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
# 
# Jeff Dike noted that the assembly code for syscall stubs is misassembled with
# GCC 3.2.3: the values copied in registers weren't preserved between one asm()
# and the following one.
# 
# So I fixed the thing by rewriting the __asm__ constraints more
# like unistd.h ones.
# 
# Note: in syscall6 case I had to add one more instruction (i.e. moving arg6 in
# eax and shuffling things around) - it's needed for the function to be valid 
# in general (we can't load the value from the stack, relative to ebp, because 
# we change it), but could be avoided since we actually use a constant as 
# param 6.
# 
# The only fix would be to turn stub_syscall6 to a macro and use a "i" 
# constraint for arg6 (i.e., specify it's a constant value).
# 
# Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
# ---
# 
#  arch/um/include/sysdep-i386/stub.h   |   64 +++++++++++++++++++++++-----------
#  arch/um/include/sysdep-x86_64/stub.h |   61 ++++++++++++++++++++++++++------
#  2 files changed, 92 insertions(+), 33 deletions(-)
# 
diff --git a/arch/um/include/sysdep-i386/stub.h b/arch/um/include/sysdep-i386/stub.h
--- a/arch/um/include/sysdep-i386/stub.h
+++ b/arch/um/include/sysdep-i386/stub.h
@@ -16,45 +16,69 @@ extern void stub_clone_handler(void);
 #define STUB_MMAP_NR __NR_mmap2
 #define MMAP_OFFSET(o) ((o) >> PAGE_SHIFT)
 
+static inline long stub_syscall1(long syscall, long arg1)
+{
+	long ret;
+
+	__asm__ volatile ("int $0x80" : "=a" (ret) : "0" (syscall), "b" (arg1));
+
+	return ret;
+}
+
 static inline long stub_syscall2(long syscall, long arg1, long arg2)
 {
 	long ret;
 
-	__asm__("movl %0, %%ecx; " : : "g" (arg2) : "%ecx");
-	__asm__("movl %0, %%ebx; " : : "g" (arg1) : "%ebx");
-	__asm__("movl %0, %%eax; " : : "g" (syscall) : "%eax");
-	__asm__("int $0x80;" : : : "%eax");
-	__asm__ __volatile__("movl %%eax, %0; " : "=g" (ret) :);
-	return(ret);
+	__asm__ volatile ("int $0x80" : "=a" (ret) : "0" (syscall), "b" (arg1),
+			"c" (arg2));
+
+	return ret;
 }
 
 static inline long stub_syscall3(long syscall, long arg1, long arg2, long arg3)
 {
-	__asm__("movl %0, %%edx; " : : "g" (arg3) : "%edx");
-	return(stub_syscall2(syscall, arg1, arg2));
+	long ret;
+
+	__asm__ volatile ("int $0x80" : "=a" (ret) : "0" (syscall), "b" (arg1),
+			"c" (arg2), "d" (arg3));
+
+	return ret;
 }
 
 static inline long stub_syscall4(long syscall, long arg1, long arg2, long arg3,
 				 long arg4)
 {
-	__asm__("movl %0, %%esi; " : : "g" (arg4) : "%esi");
-	return(stub_syscall3(syscall, arg1, arg2, arg3));
+	long ret;
+
+	__asm__ volatile ("int $0x80" : "=a" (ret) : "0" (syscall), "b" (arg1),
+			"c" (arg2), "d" (arg3), "S" (arg4));
+
+	return ret;
+}
+
+static inline long stub_syscall5(long syscall, long arg1, long arg2, long arg3,
+				 long arg4, long arg5)
+{
+	long ret;
+
+	__asm__ volatile ("int $0x80" : "=a" (ret) : "0" (syscall), "b" (arg1),
+			"c" (arg2), "d" (arg3), "S" (arg4), "D" (arg5));
+
+	return ret;
 }
 
 static inline long stub_syscall6(long syscall, long arg1, long arg2, long arg3,
 				 long arg4, long arg5, long arg6)
 {
 	long ret;
-	__asm__("movl %0, %%eax; " : : "g" (syscall) : "%eax");
-	__asm__("movl %0, %%ebx; " : : "g" (arg1) : "%ebx");
-	__asm__("movl %0, %%ecx; " : : "g" (arg2) : "%ecx");
-	__asm__("movl %0, %%edx; " : : "g" (arg3) : "%edx");
-	__asm__("movl %0, %%esi; " : : "g" (arg4) : "%esi");
-	__asm__("movl %0, %%edi; " : : "g" (arg5) : "%edi");
-	__asm__ __volatile__("pushl %%ebp ; movl %1, %%ebp; "
-		"int $0x80; popl %%ebp ; "
-		"movl %%eax, %0; " : "=g" (ret) : "g" (arg6) : "%eax");
-	return(ret);
+
+	__asm__ volatile ("push %%ebp ; movl %%eax,%%ebp ; movl %1,%%eax ; "
+			"int $0x80 ; pop %%ebp"
+			: "=a" (ret)
+			: "g" (syscall), "b" (arg1), "c" (arg2), "d" (arg3),
+			  "S" (arg4), "D" (arg5), "0" (arg6));
+
+	return ret;
 }
 
 static inline void trap_myself(void)
diff --git a/arch/um/include/sysdep-x86_64/stub.h b/arch/um/include/sysdep-x86_64/stub.h
--- a/arch/um/include/sysdep-x86_64/stub.h
+++ b/arch/um/include/sysdep-x86_64/stub.h
@@ -17,37 +17,72 @@ extern void stub_clone_handler(void);
 #define STUB_MMAP_NR __NR_mmap
 #define MMAP_OFFSET(o) (o)
 
+#define __syscall_clobber "r11","rcx","memory"
+#define __syscall "syscall"
+
 static inline long stub_syscall2(long syscall, long arg1, long arg2)
 {
 	long ret;
 
-	__asm__("movq %0, %%rsi; " : : "g" (arg2) : "%rsi");
-	__asm__("movq %0, %%rdi; " : : "g" (arg1) : "%rdi");
-	__asm__("movq %0, %%rax; " : : "g" (syscall) : "%rax");
-	__asm__("syscall;" : : : "%rax", "%r11", "%rcx");
-	__asm__ __volatile__("movq %%rax, %0; " : "=g" (ret) :);
-	return(ret);
+	__asm__ volatile (__syscall
+		: "=a" (ret)
+		: "0" (syscall), "D" (arg1), "S" (arg2) : __syscall_clobber );
+
+	return ret;
 }
 
 static inline long stub_syscall3(long syscall, long arg1, long arg2, long arg3)
 {
-	__asm__("movq %0, %%rdx; " : : "g" (arg3) : "%rdx");
-	return(stub_syscall2(syscall, arg1, arg2));
+	long ret;
+
+	__asm__ volatile (__syscall
+		: "=a" (ret)
+		: "0" (syscall), "D" (arg1), "S" (arg2), "d" (arg3)
+		: __syscall_clobber );
+
+	return ret;
 }
 
 static inline long stub_syscall4(long syscall, long arg1, long arg2, long arg3,
 				 long arg4)
 {
-	__asm__("movq %0, %%r10; " : : "g" (arg4) : "%r10");
-	return(stub_syscall3(syscall, arg1, arg2, arg3));
+	long ret;
+
+	__asm__ volatile ("movq %5,%%r10 ; " __syscall
+		: "=a" (ret)
+		: "0" (syscall), "D" (arg1), "S" (arg2), "d" (arg3),
+		  "g" (arg4)
+		: __syscall_clobber, "r10" );
+
+	return ret;
+}
+
+static inline long stub_syscall5(long syscall, long arg1, long arg2, long arg3,
+				 long arg4, long arg5)
+{
+	long ret;
+
+	__asm__ volatile ("movq %5,%%r10 ; movq %6,%%r8 ; " __syscall
+		: "=a" (ret)
+		: "0" (syscall), "D" (arg1), "S" (arg2), "d" (arg3),
+		  "g" (arg4), "g" (arg5)
+		: __syscall_clobber, "r10", "r8" );
+
+	return ret;
 }
 
 static inline long stub_syscall6(long syscall, long arg1, long arg2, long arg3,
 				 long arg4, long arg5, long arg6)
 {
-	__asm__("movq %0, %%r9; " : : "g" (arg6) : "%r9");
-	__asm__("movq %0, %%r8; " : : "g" (arg5) : "%r8");
-	return(stub_syscall4(syscall, arg1, arg2, arg3, arg4));
+	long ret;
+
+	__asm__ volatile ("movq %5,%%r10 ; movq %6,%%r8 ; "
+		"movq %7, %%r9; " __syscall : "=a" (ret)
+		: "0" (syscall), "D" (arg1), "S" (arg2), "d" (arg3),
+		  "g" (arg4), "g" (arg5), "g" (arg6)
+		: __syscall_clobber, "r10", "r8", "r9" );
+
+	return ret;
 }
 
 static inline void trap_myself(void)


--a8Wt8u1KmwUX3Y2C--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
