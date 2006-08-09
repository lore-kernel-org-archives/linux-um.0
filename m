Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GAzlW-00059j-Ez for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Aug 2006 18:55:18 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GAzlV-0001fY-UO
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Aug 2006 18:55:18 -0700
Message-Id: <200608091815.k79IFW3W005315@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Wed, 09 Aug 2006 14:15:30 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH] UML - Stack usage reduction
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
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

The KSTK_* macros used an inordinate amount of stack.  In order to
overcome an impedance mismatch between their interface, which just
returns a single register value, and the interface of get_thread_regs,
which took a full pt_regs, the implementation created an on-stack
pt_regs, filled it in, and returned one field.  do_task_stat calls
KSTK_* twice, resulting in two local pt_regs, blowing out the stack.

This patch changes the interface (and name) of get_thread_regs to just
return a single register from a jmp_buf.

The include of archsetjmp.h" in registers.h to get the definition of
jmp_buf exposed a bogus include of <setjmp.h> in start_up.c.
<setjmp.h> shouldn't be used anywhere any more since UML uses the
klibc setjmp/longjmp.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17/arch/um/include/registers.h
===================================================================
--- linux-2.6.17.orig/arch/um/include/registers.h	2006-06-17 21:49:35.000000000 -0400
+++ linux-2.6.17/arch/um/include/registers.h	2006-08-09 13:42:06.000000000 -0400
@@ -7,6 +7,7 @@
 #define __REGISTERS_H
 
 #include "sysdep/ptrace.h"
+#include "sysdep/archsetjmp.h"
 
 extern void init_thread_registers(union uml_pt_regs *to);
 extern int save_fp_registers(int pid, unsigned long *fp_regs);
@@ -15,6 +16,6 @@ extern void save_registers(int pid, unio
 extern void restore_registers(int pid, union uml_pt_regs *regs);
 extern void init_registers(int pid);
 extern void get_safe_registers(unsigned long * regs, unsigned long * fp_regs);
-extern void get_thread_regs(union uml_pt_regs *uml_regs, void *buffer);
+extern unsigned long get_thread_reg(int reg, jmp_buf *buf);
 
 #endif
Index: linux-2.6.17/arch/um/os-Linux/sys-i386/registers.c
===================================================================
--- linux-2.6.17.orig/arch/um/os-Linux/sys-i386/registers.c	2006-08-09 13:36:17.000000000 -0400
+++ linux-2.6.17/arch/um/os-Linux/sys-i386/registers.c	2006-08-09 13:42:06.000000000 -0400
@@ -130,11 +130,14 @@ void get_safe_registers(unsigned long *r
 		       HOST_FP_SIZE * sizeof(unsigned long));
 }
 
-void get_thread_regs(union uml_pt_regs *uml_regs, void *buffer)
+unsigned long get_thread_reg(int reg, jmp_buf *buf)
 {
-	struct __jmp_buf *jmpbuf = buffer;
-
-	UPT_SET(uml_regs, EIP, jmpbuf->__eip);
-	UPT_SET(uml_regs, UESP, jmpbuf->__esp);
-	UPT_SET(uml_regs, EBP, jmpbuf->__ebp);
+	switch(reg){
+	case EIP: return buf[0]->__eip;
+	case UESP: return buf[0]->__esp;
+	case EBP: return buf[0]->__ebp;
+	default:
+		printk("get_thread_regs - unknown register %d\n", reg);
+		return 0;
+	}
 }
Index: linux-2.6.17/arch/um/os-Linux/sys-x86_64/registers.c
===================================================================
--- linux-2.6.17.orig/arch/um/os-Linux/sys-x86_64/registers.c	2006-08-09 13:36:17.000000000 -0400
+++ linux-2.6.17/arch/um/os-Linux/sys-x86_64/registers.c	2006-08-09 13:42:06.000000000 -0400
@@ -78,11 +78,14 @@ void get_safe_registers(unsigned long *r
 		       HOST_FP_SIZE * sizeof(unsigned long));
 }
 
-void get_thread_regs(union uml_pt_regs *uml_regs, void *buffer)
+unsigned long get_thread_reg(int reg, jmp_buf *buf)
 {
-	struct __jmp_buf *jmpbuf = buffer;
-
-	UPT_SET(uml_regs, RIP, jmpbuf->__rip);
-	UPT_SET(uml_regs, RSP, jmpbuf->__rsp);
-	UPT_SET(uml_regs, RBP, jmpbuf->__rbp);
+	switch(reg){
+	case RIP: return buf[0]->__rip;
+	case RSP: return buf[0]->__rsp;
+	case RBP: return buf[0]->__rbp;
+	default:
+		printk("get_thread_regs - unknown register %d\n", reg);
+		return 0;
+	}
 }
Index: linux-2.6.17/include/asm-um/processor-generic.h
===================================================================
--- linux-2.6.17.orig/include/asm-um/processor-generic.h	2006-08-09 13:35:31.000000000 -0400
+++ linux-2.6.17/include/asm-um/processor-generic.h	2006-08-09 13:42:06.000000000 -0400
@@ -138,9 +138,7 @@ extern struct cpuinfo_um cpu_data[];
 
 #ifdef CONFIG_MODE_SKAS
 #define KSTK_REG(tsk, reg) \
-	({ union uml_pt_regs regs; \
-	   get_thread_regs(&regs, tsk->thread.mode.skas.switch_buf); \
-	   UPT_REG(&regs, reg); })
+	get_thread_reg(reg, tsk->thread.mode.skas.switch_buf)
 #else
 #define KSTK_REG(tsk, reg) (0xbadbabe)
 #endif
Index: linux-2.6.17/arch/um/os-Linux/start_up.c
===================================================================
--- linux-2.6.17.orig/arch/um/os-Linux/start_up.c	2006-08-09 13:56:44.000000000 -0400
+++ linux-2.6.17/arch/um/os-Linux/start_up.c	2006-08-09 13:56:54.000000000 -0400
@@ -14,7 +14,6 @@
 #include <sched.h>
 #include <fcntl.h>
 #include <errno.h>
-#include <setjmp.h>
 #include <sys/time.h>
 #include <sys/wait.h>
 #include <sys/mman.h>


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
