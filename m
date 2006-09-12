Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GNAaA-0004d0-4Q for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Sep 2006 08:53:54 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GNAa4-0008JI-RP
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Sep 2006 08:53:51 -0700
Message-Id: <200609121552.k8CFq4IE008007@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Tue, 12 Sep 2006 11:52:04 -0400
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
Cc: zach@vmware.com, jeremy@xensource.com, user-mode-linux-devel@lists.sourceforge.net, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, ak@muc.de, 76306.1226@compuserve.com

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

x86_64 is also treated in this way for consistency.  There was some
trailing whitespace there, which is cleaned up.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.18-mm/include/asm-i386/ptrace-abi.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18-mm/include/asm-i386/ptrace-abi.h	2006-09-11 18:04:30.000000000 -0400
@@ -0,0 +1,39 @@
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
Index: linux-2.6.18-mm/include/asm-i386/ptrace.h
===================================================================
--- linux-2.6.18-mm.orig/include/asm-i386/ptrace.h	2006-09-11 10:48:33.000000000 -0400
+++ linux-2.6.18-mm/include/asm-i386/ptrace.h	2006-09-11 18:04:20.000000000 -0400
@@ -1,24 +1,7 @@
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
+#include <asm/ptrace-abi.h>
 
 /* this struct defines the way the registers are stored on the 
    stack during a system call. */
@@ -43,22 +26,6 @@ struct pt_regs {
 	int  xss;
 };
 
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
-
 #ifdef __KERNEL__
 
 #include <asm/vm86.h>
Index: linux-2.6.18-mm/include/asm-x86_64/ptrace-abi.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18-mm/include/asm-x86_64/ptrace-abi.h	2006-09-11 18:05:29.000000000 -0400
@@ -0,0 +1,51 @@
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
Index: linux-2.6.18-mm/include/asm-x86_64/ptrace.h
===================================================================
--- linux-2.6.18-mm.orig/include/asm-x86_64/ptrace.h	2006-09-11 10:48:33.000000000 -0400
+++ linux-2.6.18-mm/include/asm-x86_64/ptrace.h	2006-09-11 18:05:27.000000000 -0400
@@ -1,40 +1,9 @@
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
+#include <asm/ptrace-abi.h>
 
-/* top of stack page */ 
-#define FRAME_SIZE 168
-
-#define PTRACE_OLDSETOPTIONS         21
-
-#ifndef __ASSEMBLY__ 
+#ifndef __ASSEMBLY__
 
 struct pt_regs {
 	unsigned long r15;
@@ -45,7 +14,7 @@ struct pt_regs {
 	unsigned long rbx;
 /* arguments: non interrupts/non tracing syscalls only save upto here*/
  	unsigned long r11;
-	unsigned long r10;	
+	unsigned long r10;
 	unsigned long r9;
 	unsigned long r8;
 	unsigned long rax;
@@ -54,32 +23,18 @@ struct pt_regs {
 	unsigned long rsi;
 	unsigned long rdi;
 	unsigned long orig_rax;
-/* end of arguments */ 	
+/* end of arguments */
 /* cpu exception frame or undefined */
 	unsigned long rip;
 	unsigned long cs;
-	unsigned long eflags; 
-	unsigned long rsp; 
+	unsigned long eflags;
+	unsigned long rsp;
 	unsigned long ss;
-/* top of stack page */ 
+/* top of stack page */
 };
 
 #endif
 
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
-
 #if defined(__KERNEL__) && !defined(__ASSEMBLY__) 
 #define user_mode(regs) (!!((regs)->cs & 3))
 #define user_mode_vm(regs) user_mode(regs)


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
