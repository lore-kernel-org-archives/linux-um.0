Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EJxM4-0000mj-8S	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Sep 2005 11:05:32 -0700
Received: from agminet01.oracle.com ([141.146.126.228])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)	id 1EJxM3-0000uH-EH
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Sep 2005 11:05:32 -0700
Received: from rgmsgw301.us.oracle.com (rgmsgw301.us.oracle.com
	[138.1.186.50])j8QI7Tm6029564
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 26 Sep 2005 13:07:29 -0500
Received: from rgmsgw301.us.oracle.com (localhost [127.0.0.1])
	j8QI5MHr007803	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 26 Sep 2005 12:05:22 -0600
Received: from [138.2.230.92] (agraves-lnx.us.oracle.com [138.2.230.92])
	j8QI5LVa007796
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 26 Sep 2005 12:05:21 -0600
Message-ID: <43383859.7090301@oracle.com>
From: Allan Graves <allan.graves@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040105030508040909060702"
Subject: [uml-devel] sysrq patch
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
Date: Mon, 26 Sep 2005 14:05:13 -0400
To: user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------040105030508040909060702
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Changes: Fixes sysrq t to work under skas mode.  Adds macros to get 
register arguments from the jmp bufs in conjunction with a new 
function.  Changes the show_trace call to pass the correct task, not the 
current one.

Let me know what you want changed, jeff, i set vim to hardtabs, i hope 
the white space comes out okay, don't want to get you in trouble again.  
i ran this in both frame pointer and no frame pointer mode.
Allan

--------------040105030508040909060702
Content-Type: text/plain;
 name="sysrq_patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sysrq_patch"

Index: linux-2.6.13-stack/arch/um/include/registers.h
===================================================================
--- linux-2.6.13-stack.orig/arch/um/include/registers.h
+++ linux-2.6.13-stack/arch/um/include/registers.h
@@ -16,6 +16,7 @@ extern void save_registers(int pid, unio
 extern void restore_registers(int pid, union uml_pt_regs *regs);
 extern void init_registers(int pid);
 extern void get_safe_registers(unsigned long * regs);
+extern union uml_pt_regs *get_thread_regs(union uml_pt_regs *uml_regs, void *buffer);
 
 #endif
 
Index: linux-2.6.13-stack/arch/um/kernel/sysrq.c
===================================================================
--- linux-2.6.13-stack.orig/arch/um/kernel/sysrq.c
+++ linux-2.6.13-stack/arch/um/kernel/sysrq.c
@@ -84,5 +84,5 @@ void show_stack(struct task_struct *task
 	}
 
 	printk("Call Trace: \n");
-	show_trace(current, esp);
+	show_trace(task, esp);
 }
Index: linux-2.6.13-stack/arch/um/os-Linux/sys-i386/registers.c
===================================================================
--- linux-2.6.13-stack.orig/arch/um/os-Linux/sys-i386/registers.c
+++ linux-2.6.13-stack/arch/um/os-Linux/sys-i386/registers.c
@@ -5,6 +5,7 @@
 
 #include <errno.h>
 #include <string.h>
+#include <setjmp.h>
 #include "sysdep/ptrace_user.h"
 #include "sysdep/ptrace.h"
 #include "uml-config.h"
@@ -126,6 +127,25 @@ void get_safe_registers(unsigned long *r
 	memcpy(regs, exec_regs, HOST_FRAME_SIZE * sizeof(unsigned long));
 }
 
+
+
+union uml_pt_regs *get_thread_regs(union uml_pt_regs *uml_regs, void *buffer)
+{
+	//jmp_buf * jmpbuf=(jmp_buf  *)buffer;
+	struct __jmp_buf_tag *jmpbuf=(struct __jmp_buf_tag*)buffer;
+
+	/*uml_regs->skas.regs[HOST_IP]=jmpbuf->__jmp_buf[JB_PC];
+	uml_regs->skas.regs[HOST_SP]=jmpbuf->__jmp_buf[JB_SP];
+	uml_regs->skas.regs[HOST_EBP]=jmpbuf->__jmp_buf[JB_BP];*/
+
+	UPT_SET(uml_regs, EIP, jmpbuf->__jmpbuf[JB_PC]);
+	UPT_SET(uml_regs, UESP, jmpbuf->__jmpbuf[JB_SP]);
+	UPT_SET(uml_regs, EBP, jmpbuf->__jmpbuf[JB_BP]);
+
+
+	return uml_regs;
+
+}
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically
Index: linux-2.6.13-stack/arch/um/sys-i386/sysrq.c
===================================================================
--- linux-2.6.13-stack.orig/arch/um/sys-i386/sysrq.c
+++ linux-2.6.13-stack/arch/um/sys-i386/sysrq.c
@@ -11,6 +11,7 @@
 #include "asm/ptrace.h"
 #include "sysrq.h"
 
+int stop_here=0;
 /* This is declared by <linux/sched.h> */
 void show_regs(struct pt_regs *regs)
 {
@@ -49,6 +50,7 @@ static inline unsigned long print_contex
 				unsigned long *stack, unsigned long ebp)
 {
 	unsigned long addr;
+	int r;
 
 #ifdef CONFIG_FRAME_POINTER
 	while (valid_stack_ptr(tinfo, (void *)ebp)) {
@@ -88,26 +90,16 @@ void show_trace(struct task_struct* task
 		task = current;
 
 	if (task != current) {
-		//ebp = (unsigned long) KSTK_EBP(task);
-		/* Which one? No actual difference - just coding style.*/
-		ebp = (unsigned long) PT_REGS_EBP(&task->thread.regs);
+		ebp = (unsigned long) KSTK_EBP(task);
 	} else {
 		asm ("movl %%ebp, %0" : "=r" (ebp) : );
+		printk("ASM\n");
 	}
 
 	context = (struct thread_info *)
 		((unsigned long)stack & (~(THREAD_SIZE - 1)));
 	print_context_stack(context, stack, ebp);
 
-	/*while (((long) stack & (THREAD_SIZE-1)) != 0) {
-		addr = *stack;
-		if (__kernel_text_address(addr)) {
-			printk("%08lx:	[<%08lx>]", (unsigned long) stack, addr);
-			print_symbol(" %s", addr);
-			printk("\n");
-		}
-		stack++;
-	}*/
 	printk("\n");
 }
 
Index: linux-2.6.13-stack/include/asm-um/processor-generic.h
===================================================================
--- linux-2.6.13-stack.orig/include/asm-um/processor-generic.h
+++ linux-2.6.13-stack/include/asm-um/processor-generic.h
@@ -13,6 +13,7 @@ struct task_struct;
 #include "linux/config.h"
 #include "asm/ptrace.h"
 #include "choose-mode.h"
+#include "registers.h"
 
 struct mm_struct;
 
@@ -22,6 +23,7 @@ struct thread_struct {
 	 * vfork / clone), and reset to 0 after. It is left to 0 when called
 	 * from kernelspace (i.e. kernel_thread() or fork_idle(), as of 2.6.11). */
 	struct task_struct *saved_task;
+	union uml_pt_regs sysrq_regs;
 	int forking;
 	int nsyscalls;
 	struct pt_regs regs;
@@ -136,8 +138,16 @@ extern struct cpuinfo_um cpu_data[];
 #define current_cpu_data boot_cpu_data
 #endif
 
+#ifdef CONFIG_MODE_SKAS
+
+#define KSTK_EIP(tsk) UPT_REG(get_thread_regs(&tsk->thread.sysrq_regs, tsk->thread.mode.skas.switch_buf), EIP);
+#define KSTK_ESP(tsk) UPT_REG(get_thread_regs(&tsk->thread.sysrq_regs, tsk->thread.mode.skas.switch_buf), UESP);
+#define KSTK_EBP(tsk) UPT_REG(get_thread_regs(&tsk->thread.sysrq_regs, tsk->thread.mode.skas.switch_buf), EBP);
+
+#else
 #define KSTK_EIP(tsk) (PT_REGS_IP(&tsk->thread.regs))
 #define KSTK_ESP(tsk) (PT_REGS_SP(&tsk->thread.regs))
+#endif
 #define get_wchan(p) (0)
 
 #endif

--------------040105030508040909060702--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
