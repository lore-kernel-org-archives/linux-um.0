Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GAYek-0001oG-Kf for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Aug 2006 13:58:30 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GAYej-0007iZ-Tj
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Aug 2006 13:58:30 -0700
Message-Id: <200608082058.k78KwGa4006531@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Tue, 08 Aug 2006 16:58:16 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 1/2] Split i386 and x86_64 ptrace.h
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: akpm@osdl.org
Cc: Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Kyle Moffett <mrmacman_g4@mac.com>

The use of SEGMENT_RPL_MASK in the i386 ptrace.h introduced by
x86-allow-a-kernel-to-not-be-in-ring-0.patch broke the UML build, as
UML includes the underlying architecture's ptrace.h, but has no easy
access to the x86 segment definitions.

Rather than kludging around this, as in the past, this patch splits
the userspace-usable parts, which are the bits that UML needs, of
ptrace.h into ptrace-abi.h, which is included back into ptrace.h.
Thus, there is no net effect on i386.

As a side-effect, this creates a ptrace header which is close to being
usable in /usr/include.

x86_64 is also treated in this way for consistency.

This patch was run by linux-arch yesterday with no comment.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17/include/asm-i386/ptrace-abi.h
===================================================================
--- /dev/null
+++ linux-2.6.17/include/asm-i386/ptrace-abi.h
@@ -0,0 +1,60 @@
+#ifndef I386_PTRACE_ABI_H
+#define I386_PTRACE_ABI_H
+
+#define EBX 0
+#define ECX 1
+#define EDX 2
+#define ESI 3
+#define EDI 4
+#define EBP 5
+#define EAX 6
+#define DS 7
+#define ES 8
+#define FS 9
+#define GS 10
+#define ORIG_EAX 11
+#define EIP 12
+#define CS  13
+#define EFL 14
+#define UESP 15
+#define SS   16
+#define FRAME_SIZE 17
+
+/* this struct defines the way the registers are stored on the
+   stack during a system call. */
+
+struct pt_regs {
+	long ebx;
+	long ecx;
+	long edx;
+	long esi;
+	long edi;
+	long ebp;
+	long eax;
+	int  xds;
+	int  xes;
+	long orig_eax;
+	long eip;
+	int  xcs;
+	long eflags;
+	long esp;
+	int  xss;
+};
+
+/* Arbitrarily choose the same ptrace numbers as used by the Sparc code. */
+#define PTRACE_GETREGS            12
+#define PTRACE_SETREGS            13
+#define PTRACE_GETFPREGS          14
+#define PTRACE_SETFPREGS          15
+#define PTRACE_GETFPXREGS         18
+#define PTRACE_SETFPXREGS         19
+
+#define PTRACE_OLDSETOPTIONS         21
+
+#define PTRACE_GET_THREAD_AREA    25
+#define PTRACE_SET_THREAD_AREA    26
+
+#define PTRACE_SYSEMU		  31
+#define PTRACE_SYSEMU_SINGLESTEP  32
+
+#endif
Index: linux-2.6.17/include/asm-i386/ptrace.h
===================================================================
--- linux-2.6.17.orig/include/asm-i386/ptrace.h
+++ linux-2.6.17/include/asm-i386/ptrace.h
@@ -1,61 +1,7 @@
 #ifndef _I386_PTRACE_H
 #define _I386_PTRACE_H
 
-#define EBX 0
-#define ECX 1
-#define EDX 2
-#define ESI 3
-#define EDI 4
-#define EBP 5
-#define EAX 6
-#define DS 7
-#define ES 8
-#define FS 9
-#define GS 10
-#define ORIG_EAX 11
-#define EIP 12
-#define CS  13
-#define EFL 14
-#define UESP 15
-#define SS   16
-#define FRAME_SIZE 17
-
-/* this struct defines the way the registers are stored on the 
-   stack during a system call. */
-
-struct pt_regs {
-	long ebx;
-	long ecx;
-	long edx;
-	long esi;
-	long edi;
-	long ebp;
-	long eax;
-	int  xds;
-	int  xes;
-	long orig_eax;
-	long eip;
-	int  xcs;
-	long eflags;
-	long esp;
-	int  xss;
-};
-
-/* Arbitrarily choose the same ptrace numbers as used by the Sparc code. */
-#define PTRACE_GETREGS            12
-#define PTRACE_SETREGS            13
-#define PTRACE_GETFPREGS          14
-#define PTRACE_SETFPREGS          15
-#define PTRACE_GETFPXREGS         18
-#define PTRACE_SETFPXREGS         19
-
-#define PTRACE_OLDSETOPTIONS         21
-
-#define PTRACE_GET_THREAD_AREA    25
-#define PTRACE_SET_THREAD_AREA    26
-
-#define PTRACE_SYSEMU		  31
-#define PTRACE_SYSEMU_SINGLESTEP  32
+#include <asm/ptrace-abi.h>
 
 #ifdef __KERNEL__
 
Index: linux-2.6.17/include/asm-x86_64/ptrace-abi.h
===================================================================
--- /dev/null
+++ linux-2.6.17/include/asm-x86_64/ptrace-abi.h
@@ -0,0 +1,83 @@
+#ifndef _X86_64_PTRACE_ABI_H
+#define _X86_64_PTRACE_ABI_H
+
+#if defined(__ASSEMBLY__) || defined(__FRAME_OFFSETS)
+#define R15 0
+#define R14 8
+#define R13 16
+#define R12 24
+#define RBP 32
+#define RBX 40
+/* arguments: interrupts/non tracing syscalls only save upto here*/
+#define R11 48
+#define R10 56
+#define R9 64
+#define R8 72
+#define RAX 80
+#define RCX 88
+#define RDX 96
+#define RSI 104
+#define RDI 112
+#define ORIG_RAX 120       /* = ERROR */
+/* end of arguments */
+/* cpu exception frame or undefined in case of fast syscall. */
+#define RIP 128
+#define CS 136
+#define EFLAGS 144
+#define RSP 152
+#define SS 160
+#define ARGOFFSET R11
+#endif /* __ASSEMBLY__ */
+
+/* top of stack page */
+#define FRAME_SIZE 168
+
+#define PTRACE_OLDSETOPTIONS         21
+
+#ifndef __ASSEMBLY__
+
+struct pt_regs {
+	unsigned long r15;
+	unsigned long r14;
+	unsigned long r13;
+	unsigned long r12;
+	unsigned long rbp;
+	unsigned long rbx;
+/* arguments: non interrupts/non tracing syscalls only save upto here*/
+ 	unsigned long r11;
+	unsigned long r10;
+	unsigned long r9;
+	unsigned long r8;
+	unsigned long rax;
+	unsigned long rcx;
+	unsigned long rdx;
+	unsigned long rsi;
+	unsigned long rdi;
+	unsigned long orig_rax;
+/* end of arguments */
+/* cpu exception frame or undefined */
+	unsigned long rip;
+	unsigned long cs;
+	unsigned long eflags;
+	unsigned long rsp;
+	unsigned long ss;
+/* top of stack page */
+};
+
+#endif
+
+/* Arbitrarily choose the same ptrace numbers as used by the Sparc code. */
+#define PTRACE_GETREGS            12
+#define PTRACE_SETREGS            13
+#define PTRACE_GETFPREGS          14
+#define PTRACE_SETFPREGS          15
+#define PTRACE_GETFPXREGS         18
+#define PTRACE_SETFPXREGS         19
+
+/* only useful for access 32bit programs */
+#define PTRACE_GET_THREAD_AREA    25
+#define PTRACE_SET_THREAD_AREA    26
+
+#define PTRACE_ARCH_PRCTL	  30	/* arch_prctl for child */
+
+#endif
Index: linux-2.6.17/include/asm-x86_64/ptrace.h
===================================================================
--- linux-2.6.17.orig/include/asm-x86_64/ptrace.h
+++ linux-2.6.17/include/asm-x86_64/ptrace.h
@@ -1,84 +1,7 @@
 #ifndef _X86_64_PTRACE_H
 #define _X86_64_PTRACE_H
 
-#if defined(__ASSEMBLY__) || defined(__FRAME_OFFSETS) 
-#define R15 0
-#define R14 8
-#define R13 16
-#define R12 24
-#define RBP 32
-#define RBX 40
-/* arguments: interrupts/non tracing syscalls only save upto here*/
-#define R11 48
-#define R10 56	
-#define R9 64
-#define R8 72
-#define RAX 80
-#define RCX 88
-#define RDX 96
-#define RSI 104
-#define RDI 112
-#define ORIG_RAX 120       /* = ERROR */ 
-/* end of arguments */ 	
-/* cpu exception frame or undefined in case of fast syscall. */
-#define RIP 128
-#define CS 136
-#define EFLAGS 144
-#define RSP 152
-#define SS 160
-#define ARGOFFSET R11
-#endif /* __ASSEMBLY__ */
-
-/* top of stack page */ 
-#define FRAME_SIZE 168
-
-#define PTRACE_OLDSETOPTIONS         21
-
-#ifndef __ASSEMBLY__ 
-
-struct pt_regs {
-	unsigned long r15;
-	unsigned long r14;
-	unsigned long r13;
-	unsigned long r12;
-	unsigned long rbp;
-	unsigned long rbx;
-/* arguments: non interrupts/non tracing syscalls only save upto here*/
- 	unsigned long r11;
-	unsigned long r10;	
-	unsigned long r9;
-	unsigned long r8;
-	unsigned long rax;
-	unsigned long rcx;
-	unsigned long rdx;
-	unsigned long rsi;
-	unsigned long rdi;
-	unsigned long orig_rax;
-/* end of arguments */ 	
-/* cpu exception frame or undefined */
-	unsigned long rip;
-	unsigned long cs;
-	unsigned long eflags; 
-	unsigned long rsp; 
-	unsigned long ss;
-/* top of stack page */ 
-};
-
-#endif
-
-/* Arbitrarily choose the same ptrace numbers as used by the Sparc code. */
-#define PTRACE_GETREGS            12
-#define PTRACE_SETREGS            13
-#define PTRACE_GETFPREGS          14
-#define PTRACE_SETFPREGS          15
-#define PTRACE_GETFPXREGS         18
-#define PTRACE_SETFPXREGS         19
-
-/* only useful for access 32bit programs */
-#define PTRACE_GET_THREAD_AREA    25
-#define PTRACE_SET_THREAD_AREA    26
-
-#define PTRACE_ARCH_PRCTL	  30	/* arch_prctl for child */
+#include <asm/ptrace-abi.h>
 
 #if defined(__KERNEL__) && !defined(__ASSEMBLY__) 
 #define user_mode(regs) (!!((regs)->cs & 3))


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
