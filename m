Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IOKNZ-00052R-DX for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Aug 2007 14:38:13 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IOKNY-0006m1-Qc
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Aug 2007 14:38:13 -0700
Date: Thu, 23 Aug 2007 17:38:08 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070823213808.GA9105@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 4/7] UML - coredumping floating point fixes
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
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Fix core dumping of floating point state.  ELF_CORE_COPY_FPREGS gets a
definitions, and as a result, dump_fpu no longer needs to exist.  Also,
elf_fpregset_t needed a real definition.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/sys-i386/ptrace.c   |   22 ----------------------
 include/asm-um/elf-i386.h   |   12 +++++++++++-
 include/asm-um/elf-x86_64.h |    2 +-
 3 files changed, 12 insertions(+), 24 deletions(-)

Index: linux-2.6.22/include/asm-um/elf-i386.h
===================================================================
--- linux-2.6.22.orig/include/asm-um/elf-i386.h	2007-08-23 12:57:20.000000000 -0400
+++ linux-2.6.22/include/asm-um/elf-i386.h	2007-08-23 13:07:48.000000000 -0400
@@ -5,7 +5,8 @@
 #ifndef __UM_ELF_I386_H
 #define __UM_ELF_I386_H
 
-#include <asm/user.h>
+#include <linux/sched.h>
+#include "skas.h"
 
 #define R_386_NONE	0
 #define R_386_32	1
@@ -75,6 +76,15 @@ typedef struct user_i387_struct elf_fpre
 	pr_reg[16] = PT_REGS_SS(regs);		\
 } while(0);
 
+static inline int elf_core_copy_fpregs(struct task_struct *t,
+				       elf_fpregset_t *fpu)
+{
+	int cpu = ((struct thread_info *) t->stack)->cpu;
+	return save_fp_registers(userspace_pid[cpu], (unsigned long *) fpu);
+}
+
+#define ELF_CORE_COPY_FPREGS(t, fpu) elf_core_copy_fpregs(t, fpu)
+
 extern long elf_aux_hwcap;
 #define ELF_HWCAP (elf_aux_hwcap)
 
Index: linux-2.6.22/include/asm-um/elf-x86_64.h
===================================================================
--- linux-2.6.22.orig/include/asm-um/elf-x86_64.h	2007-08-23 12:57:20.000000000 -0400
+++ linux-2.6.22/include/asm-um/elf-x86_64.h	2007-08-23 13:07:48.000000000 -0400
@@ -36,7 +36,7 @@ typedef unsigned long elf_greg_t;
 #define ELF_NGREG (sizeof (struct user_regs_struct) / sizeof(elf_greg_t))
 typedef elf_greg_t elf_gregset_t[ELF_NGREG];
 
-typedef struct { } elf_fpregset_t;
+typedef struct user_i387_struct elf_fpregset_t;
 
 /*
  * This is used to ensure we don't load something for the wrong architecture.
Index: linux-2.6.22/arch/um/sys-i386/ptrace.c
===================================================================
--- linux-2.6.22.orig/arch/um/sys-i386/ptrace.c	2007-08-23 13:00:46.000000000 -0400
+++ linux-2.6.22/arch/um/sys-i386/ptrace.c	2007-08-23 13:07:48.000000000 -0400
@@ -205,28 +205,6 @@ int set_fpxregs(struct user_fxsr_struct 
 	return restore_fpx_registers(userspace_pid[cpu], fpregs);
 }
 
-#ifdef notdef
-int dump_fpu(struct pt_regs *regs, elf_fpregset_t *fpu)
-{
-	fpu->cwd = (((SC_FP_CW(PT_REGS_SC(regs)) & 0xffff) << 16) |
-		    (SC_FP_SW(PT_REGS_SC(regs)) & 0xffff));
-	fpu->swd = SC_FP_CSSEL(PT_REGS_SC(regs)) & 0xffff;
-	fpu->twd = SC_FP_IPOFF(PT_REGS_SC(regs));
-	fpu->fip = SC_FP_CSSEL(PT_REGS_SC(regs)) & 0xffff;
-	fpu->fcs = SC_FP_DATAOFF(PT_REGS_SC(regs));
-	fpu->foo = SC_FP_DATASEL(PT_REGS_SC(regs));
-	fpu->fos = 0;
-	memcpy(fpu->st_space, (void *) SC_FP_ST(PT_REGS_SC(regs)),
-	       sizeof(fpu->st_space));
-	return 1;
-}
-#endif
-
-int dump_fpu(struct pt_regs *regs, elf_fpregset_t *fpu )
-{
-	return 1;
-}
-
 long subarch_ptrace(struct task_struct *child, long request, long addr,
 		    long data)
 {

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
