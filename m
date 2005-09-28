Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EKkAQ-0006Lo-Rs	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Sep 2005 15:12:46 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EKkAN-0002N1-Sc
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Sep 2005 15:12:46 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Clearing kmalloc_ok during shutdown is broken -
	malloc will clear our data.
Message-ID: <20050928213125.GA16955@ccure.user-mode-linux.org>
References: <200509281346.23592.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <200509281346.23592.blaisorblade@yahoo.it>
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
Date: Wed, 28 Sep 2005 17:31:25 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 28, 2005 at 01:46:15PM +0200, Blaisorblade wrote:
> Also, there are some calls to kmalloc in the shutdown path - and they work. 
> I know this because I saw a problem with one of them: it gave "might_sleep 
> while atomic", and it was kmalloc in the shutdown, or rather, in panic() - 
> for the broken sysrq t (where's the fix you promised?).

Attached.

	Jeff

--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=sysrq-t

# From Allan Graves:
#
# Fix sysrq-t support for skas mode.  The old code had the IP and SP coming
# from the registers in the thread struct, which are completely wrong since
# those are the userspace registers.  This fixes that by pulling the correct
# values from the jmp_buf in which the kernel state of each thread is stored.
#
# Signed-off-by: Allan Graves <allan.graves@oracle.com>
Index: test/arch/um/include/registers.h
===================================================================
--- test.orig/arch/um/include/registers.h	2005-09-14 15:52:06.000000000 -0400
+++ test/arch/um/include/registers.h	2005-09-27 19:00:35.000000000 -0400
@@ -15,16 +15,6 @@
 extern void restore_registers(int pid, union uml_pt_regs *regs);
 extern void init_registers(int pid);
 extern void get_safe_registers(unsigned long * regs);
+extern void get_thread_regs(union uml_pt_regs *uml_regs, void *buffer);
 
 #endif
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: test/arch/um/include/sysdep-x86_64/ptrace.h
===================================================================
--- test.orig/arch/um/include/sysdep-x86_64/ptrace.h	2005-09-27 11:33:43.000000000 -0400
+++ test/arch/um/include/sysdep-x86_64/ptrace.h	2005-09-27 19:55:07.000000000 -0400
@@ -218,10 +218,6 @@
                 case RBP: UPT_RBP(regs) = __upt_val; break; \
                 case ORIG_RAX: UPT_ORIG_RAX(regs) = __upt_val; break; \
                 case CS: UPT_CS(regs) = __upt_val; break; \
-                case DS: UPT_DS(regs) = __upt_val; break; \
-                case ES: UPT_ES(regs) = __upt_val; break; \
-                case FS: UPT_FS(regs) = __upt_val; break; \
-                case GS: UPT_GS(regs) = __upt_val; break; \
                 case EFLAGS: UPT_EFLAGS(regs) = __upt_val; break; \
                 default :  \
                         panic("Bad register in UPT_SET : %d\n", reg);  \
Index: test/arch/um/kernel/sysrq.c
===================================================================
--- test.orig/arch/um/kernel/sysrq.c	2005-06-17 15:48:29.000000000 -0400
+++ test/arch/um/kernel/sysrq.c	2005-09-27 19:00:35.000000000 -0400
@@ -62,13 +62,7 @@
 
 	if (esp == NULL) {
 		if (task != current && task != NULL) {
-			/* XXX: Isn't this bogus? I.e. isn't this the
-			 * *userspace* stack of this task? If not so, use this
-			 * even when task == current (as in i386).
-			 */
 			esp = (unsigned long *) KSTK_ESP(task);
-			/* Which one? No actual difference - just coding style.*/
-			//esp = (unsigned long *) PT_REGS_IP(&task->thread.regs);
 		} else {
 			esp = (unsigned long *) &esp;
 		}
@@ -84,5 +78,5 @@
 	}
 
 	printk("Call Trace: \n");
-	show_trace(current, esp);
+	show_trace(task, esp);
 }
Index: test/arch/um/os-Linux/sys-i386/registers.c
===================================================================
--- test.orig/arch/um/os-Linux/sys-i386/registers.c	2005-09-14 15:52:06.000000000 -0400
+++ test/arch/um/os-Linux/sys-i386/registers.c	2005-09-27 19:28:43.000000000 -0400
@@ -5,6 +5,7 @@
 
 #include <errno.h>
 #include <string.h>
+#include <setjmp.h>
 #include "sysdep/ptrace_user.h"
 #include "sysdep/ptrace.h"
 #include "uml-config.h"
@@ -126,13 +127,11 @@
 	memcpy(regs, exec_regs, HOST_FRAME_SIZE * sizeof(unsigned long));
 }
 
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
+void get_thread_regs(union uml_pt_regs *uml_regs, void *buffer)
+{
+	struct __jmp_buf_tag *jmpbuf = buffer;
+
+	UPT_SET(uml_regs, EIP, jmpbuf->__jmpbuf[JB_PC]);
+	UPT_SET(uml_regs, UESP, jmpbuf->__jmpbuf[JB_SP]);
+	UPT_SET(uml_regs, EBP, jmpbuf->__jmpbuf[JB_BP]);
+}
Index: test/arch/um/os-Linux/sys-x86_64/registers.c
===================================================================
--- test.orig/arch/um/os-Linux/sys-x86_64/registers.c	2005-09-14 15:52:06.000000000 -0400
+++ test/arch/um/os-Linux/sys-x86_64/registers.c	2005-09-27 19:31:44.000000000 -0400
@@ -5,6 +5,7 @@
 
 #include <errno.h>
 #include <string.h>
+#include <setjmp.h>
 #include "ptrace_user.h"
 #include "uml-config.h"
 #include "skas_ptregs.h"
@@ -74,13 +75,11 @@
 	memcpy(regs, exec_regs, HOST_FRAME_SIZE * sizeof(unsigned long));
 }
 
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
+void get_thread_regs(union uml_pt_regs *uml_regs, void *buffer)
+{
+	struct __jmp_buf_tag *jmpbuf = buffer;
+
+	UPT_SET(uml_regs, RIP, jmpbuf->__jmpbuf[JB_PC]);
+	UPT_SET(uml_regs, RSP, jmpbuf->__jmpbuf[JB_RSP]);
+	UPT_SET(uml_regs, RBP, jmpbuf->__jmpbuf[JB_RBP]);
+}
Index: test/arch/um/sys-i386/sysrq.c
===================================================================
--- test.orig/arch/um/sys-i386/sysrq.c	2005-06-17 15:48:29.000000000 -0400
+++ test/arch/um/sys-i386/sysrq.c	2005-09-27 19:00:35.000000000 -0400
@@ -88,9 +88,7 @@
 		task = current;
 
 	if (task != current) {
-		//ebp = (unsigned long) KSTK_EBP(task);
-		/* Which one? No actual difference - just coding style.*/
-		ebp = (unsigned long) PT_REGS_EBP(&task->thread.regs);
+		ebp = (unsigned long) KSTK_EBP(task);
 	} else {
 		asm ("movl %%ebp, %0" : "=r" (ebp) : );
 	}
@@ -99,15 +97,6 @@
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
 
Index: test/include/asm-um/processor-generic.h
===================================================================
--- test.orig/include/asm-um/processor-generic.h	2005-09-27 11:34:18.000000000 -0400
+++ test/include/asm-um/processor-generic.h	2005-09-27 19:17:47.000000000 -0400
@@ -13,6 +13,7 @@
 #include "linux/config.h"
 #include "asm/ptrace.h"
 #include "choose-mode.h"
+#include "registers.h"
 
 struct mm_struct;
 
@@ -136,19 +137,15 @@
 #define current_cpu_data boot_cpu_data
 #endif
 
-#define KSTK_EIP(tsk) (PT_REGS_IP(&tsk->thread.regs))
-#define KSTK_ESP(tsk) (PT_REGS_SP(&tsk->thread.regs))
-#define get_wchan(p) (0)
 
+#ifdef CONFIG_MODE_SKAS
+#define KSTK_REG(tsk, reg) \
+	({ union uml_pt_regs regs; \
+	   get_thread_regs(&regs, tsk->thread.mode.skas.switch_buf); \
+	   UPT_REG(&regs, reg); })
+#else
+#define KSTK_REG(tsk, reg) (0xbadbabe)
 #endif
+#define get_wchan(p) (0)
 
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
+#endif
Index: test/include/asm-um/processor-i386.h
===================================================================
--- test.orig/include/asm-um/processor-i386.h	2005-06-17 15:48:29.000000000 -0400
+++ test/include/asm-um/processor-i386.h	2005-09-27 19:17:05.000000000 -0400
@@ -43,17 +43,10 @@
 #define ARCH_IS_STACKGROW(address) \
        (address + 32 >= UPT_SP(&current->thread.regs.regs))
 
+#define KSTK_EIP(tsk) KSTK_REG(tsk, EIP)
+#define KSTK_ESP(tsk) KSTK_REG(tsk, UESP)
+#define KSTK_EBP(tsk) KSTK_REG(tsk, EBP)
+
 #include "asm/processor-generic.h"
 
 #endif
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: test/include/asm-um/processor-x86_64.h
===================================================================
--- test.orig/include/asm-um/processor-x86_64.h	2005-06-17 15:48:29.000000000 -0400
+++ test/include/asm-um/processor-x86_64.h	2005-09-27 19:17:39.000000000 -0400
@@ -36,17 +36,9 @@
 #define ARCH_IS_STACKGROW(address) \
         (address + 128 >= UPT_SP(&current->thread.regs.regs))
 
+#define KSTK_EIP(tsk) KSTK_REG(tsk, RIP)
+#define KSTK_ESP(tsk) KSTK_REG(tsk, RSP)
+
 #include "asm/processor-generic.h"
 
 #endif
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */

--NzB8fVQJ5HfG6fxh--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
