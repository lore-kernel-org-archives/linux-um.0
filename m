Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CG0AA-0007N4-SQ for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 08 Oct 2004 12:12:22 -0700
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CG0A9-0005iy-B2 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 08 Oct 2004 12:12:22 -0700
Message-Id: <200410081912.i98JCFr20437@trolli.pdb.fsc.net>
From: bodo.stroesser@fujitsu-siemens.com
Subject: [uml-devel] Implement vsyscall/sysenter, patch 1/4
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
Date: Fri, 08 Oct 2004 21:12:15 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: jdike@addtoit.com, blaisorblade_spam@yahoo.it

This is the first patch of a series of four.
These patches allow the use of sysenter-systemcalls in UML
if the host support sysenter.
Some facts have to be noted:
- the sysenter instruction does not save anything, not even the
  return address. Thus the host-kernel builds a stackframe with an
  fixed return address for the backjump to the vsyscall-page. All
  kernels that support sysenter thus must have a vsyscall-page
- The hosts vsyscall-page is visible in all memory-contexts on the
  host, even in those of the processes running on UML. This cannot
  be changed.
So the best way to implement sysenter is to integrate the host's
vsyscall-page into UML, if available.

This patch creates a new source file containing an UML
initialization function. The function scans the Elf-auxiliary vector
that is prepared by the host for relevant information about:
- vsyscall elf-header
- vsyscall entry
- machine type (called "platform", e.g. "i586" or "i686")
- hardware capabilities
These informations are inserted into the Elf-auxiliary-vector that is
generated if an UML process calls "execXX()". If the information from
the auxiliray-vector is not complete, UML uses the previos default
values, with one exception: if the host has no vsyscall-page, UML now
does no longer insert AT_SYSINFO or AT_SYSINFO_EHDR elements. (I think,
that's better than writing dummies)

Since the host's vsyscall-page is always visible to UML processes, this
change is enough to let UML with an i686-compiled glibc use sysenter.

what's missing:
- is_syscall() in SKAS cannot access the code in the vsyscall-page via
  copy_from_user(), thus singlesteppers still could break out. (Note:
  that's not new, if someone jumps willingly to the sysenter-entry in
  the vsyscall-page, he can do that without the patch, too).
- a debugger cannot access the code in the vsyscall-page via
  ptrace( PEEKTEXT, ...)

Risks:
could there by any feature of the host's processor, that is indicated in
the hardware capabilities, but must not be used in UML?


Signed-off-by: Bodo Stroesser <bodo.stroesser@fujitsu-siemens.com>

---

--- linux-2.6.9-rc2-orig/arch/um/kernel/Makefile	2004-09-29 14:49:59.000000000 +0200
+++ linux-2.6.9-rc2/arch/um/kernel/Makefile	2004-10-05 16:45:39.835901012 +0200
@@ -12,7 +12,7 @@
 	sigio_user.o sigio_kern.o signal_kern.o signal_user.o smp.o \
 	syscall_kern.o syscall_user.o sysrq.o sys_call_table.o tempfile.o \
 	time.o time_kern.o tlb.o trap_kern.o trap_user.o uaccess_user.o \
-	um_arch.o umid.o user_util.o
+	um_arch.o umid.o user_util.o elf_aux.o
 
 obj-$(CONFIG_BLK_DEV_INITRD) += initrd_kern.o initrd_user.o
 obj-$(CONFIG_GPROF)	+= gprof_syms.o
@@ -25,7 +25,8 @@
 user-objs-$(CONFIG_TTY_LOG) += tty_log.o
 
 USER_OBJS := $(filter %_user.o,$(obj-y))  $(user-objs-y) config.o helper.o \
-	main.o process.o tempfile.o time.o tty_log.o umid.o user_util.o frame.o
+	main.o process.o tempfile.o time.o tty_log.o umid.o user_util.o \
+	frame.o elf_aux.o
 USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
 
 CFLAGS_frame.o := -fno-omit-frame-pointer
--- linux-2.6.9-rc2-orig/arch/um/kernel/main.c	2004-09-27 19:24:56.000000000 +0200
+++ linux-2.6.9-rc2/arch/um/kernel/main.c	2004-10-05 16:47:16.520923249 +0200
@@ -78,6 +78,8 @@
 
 extern int uml_exitcode;
 
+extern void scan_elf_aux( char **envp);
+
 int main(int argc, char **argv, char **envp)
 {
 	char **new_argv;
@@ -144,6 +146,8 @@
 	set_handler(SIGTERM, last_ditch_exit, SA_ONESHOT | SA_NODEFER, -1);
 	set_handler(SIGHUP, last_ditch_exit, SA_ONESHOT | SA_NODEFER, -1);
 
+	scan_elf_aux( envp);
+
 	do_uml_initcalls();
 	ret = linux_main(argc, argv);
 
--- linux-2.6.9-rc2-orig/arch/um/kernel/elf_aux.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.9-rc2/arch/um/kernel/elf_aux.c	2004-10-05 16:50:33.238414539 +0200
@@ -0,0 +1,66 @@
+/*
+ *  arch/um/kernel/elf_aux.c
+ *
+ *  Scan the Elf auxiliary vector provided by the host to extract
+ *  information about vsyscall-page, etc.
+ *
+ *  Copyright (C) 2004 Fujitsu Siemens Computers GmbH
+ *  Author: Bodo Stroesser (bodo.stroesser@fujitsu-siemens.com)
+ */
+#include <elf.h>
+#include <stddef.h>
+#include "init.h"
+
+#if ELF_CLASS == ELFCLASS32
+typedef Elf32_auxv_t elf_auxv_t;
+#else
+typedef Elf64_auxv_t elf_auxv_t;
+#endif
+
+char * elf_aux_platform;
+long elf_aux_hwcap;
+
+long vsyscall_ehdr;
+long vsyscall_end;
+
+long __kernel_vsyscall;
+
+
+__init void scan_elf_aux( char **envp)
+{
+	long page_size = 0;
+	elf_auxv_t * auxv;
+
+	while ( *envp++ != NULL) ;
+
+	for ( auxv = (elf_auxv_t *)envp; auxv->a_type != AT_NULL; auxv++) {
+		switch ( auxv->a_type ) {
+			case AT_SYSINFO:
+				__kernel_vsyscall = auxv->a_un.a_val;
+				break;
+			case AT_SYSINFO_EHDR:
+				vsyscall_ehdr = auxv->a_un.a_val;
+				break;
+			case AT_HWCAP:
+				elf_aux_hwcap = auxv->a_un.a_val;
+				break;
+			case AT_PLATFORM:
+				elf_aux_platform = auxv->a_un.a_ptr;
+				break;
+			case AT_PAGESZ:
+				page_size = auxv->a_un.a_val;
+				break;
+		}
+	}
+	if ( ! __kernel_vsyscall || ! vsyscall_ehdr ||
+	     ! elf_aux_hwcap || ! elf_aux_platform ||
+	     ! page_size || (vsyscall_ehdr % page_size) ) {
+		__kernel_vsyscall = 0;
+		vsyscall_ehdr = 0;
+		elf_aux_hwcap = 0;
+		elf_aux_platform = "i586";
+	}
+	else {
+		vsyscall_end = vsyscall_ehdr + page_size;
+	}
+}
--- linux-2.6.9-rc2-orig/arch/um/kernel/um_arch.c	2004-09-27 19:24:56.000000000 +0200
+++ linux-2.6.9-rc2/arch/um/kernel/um_arch.c	2004-10-04 19:20:05.112436437 +0200
@@ -44,11 +44,6 @@
 	.ipi_pipe		= { -1, -1 }
 };
 
-/* Placeholder to make UML link until the vsyscall stuff is actually
- * implemented
- */
-void *__kernel_vsyscall;
-
 unsigned long thread_saved_pc(struct task_struct *task)
 {
 	return(os_process_pc(CHOOSE_MODE_PROC(thread_pid_tt, thread_pid_skas,
--- linux-2.6.9-rc2-orig/include/asm-um/elf.h	2004-09-13 07:32:55.000000000 +0200
+++ linux-2.6.9-rc2/include/asm-um/elf.h	2004-10-05 16:16:08.747583665 +0200
@@ -3,7 +3,8 @@
 
 #include "asm/archparam.h"
 
-#define ELF_HWCAP (0)
+extern long elf_aux_hwcap;
+#define ELF_HWCAP (elf_aux_hwcap)
 
 #define SET_PERSONALITY(ex, ibcs2) do ; while(0)
 
--- linux-2.6.9-rc2-orig/include/asm-um/archparam-i386.h	2004-09-13 07:33:11.000000000 +0200
+++ linux-2.6.9-rc2/include/asm-um/archparam-i386.h	2004-10-05 16:15:44.488592605 +0200
@@ -10,7 +10,8 @@
 
 #include "user.h"
 
-#define ELF_PLATFORM "i586"
+extern char * elf_aux_platform;
+#define ELF_PLATFORM (elf_aux_platform)
 
 #define ELF_ET_DYN_BASE (2 * TASK_SIZE / 3)
 
@@ -56,15 +57,13 @@
 	pr_reg[16] = PT_REGS_SS(regs);		\
 } while(0);
 
-#if 0 /* Turn this back on when UML has VSYSCALL working */
-#define VSYSCALL_BASE	(__fix_to_virt(FIX_VSYSCALL))
-#else
-#define VSYSCALL_BASE	0
-#endif
 
-#define VSYSCALL_EHDR	((const struct elfhdr *) VSYSCALL_BASE)
-#define VSYSCALL_ENTRY	((unsigned long) &__kernel_vsyscall)
-extern void *__kernel_vsyscall;
+extern long vsyscall_ehdr;
+extern long vsyscall_end;
+extern long __kernel_vsyscall;
+
+#define VSYSCALL_BASE vsyscall_ehdr
+#define VSYSCALL_END vsyscall_end
 
 /*
  * Architecture-neutral AT_ values in 0-17, leave some room
@@ -75,8 +74,10 @@
 
 #define ARCH_DLINFO						\
 do {								\
-		NEW_AUX_ENT(AT_SYSINFO,	VSYSCALL_ENTRY);	\
-		NEW_AUX_ENT(AT_SYSINFO_EHDR, VSYSCALL_BASE);	\
+	if ( vsyscall_ehdr ) {					\
+		NEW_AUX_ENT(AT_SYSINFO,	__kernel_vsyscall);	\
+		NEW_AUX_ENT(AT_SYSINFO_EHDR, vsyscall_ehdr);	\
+	}							\
 } while (0)
 
 /*


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
