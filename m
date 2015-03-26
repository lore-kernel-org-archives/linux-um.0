Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1Yb6st-0005D4-9Q
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 Mar 2015 12:27:39 +0000
Received: from mail.sigma-star.at ([95.130.255.111])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Yb6sq-00071t-L1 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 Mar 2015 12:27:39 +0000
From: Richard Weinberger <richard@nod.at>
Date: Thu, 26 Mar 2015 13:27:14 +0100
Message-Id: <1427372838-16605-3-git-send-email-richard@nod.at>
In-Reply-To: <1427372838-16605-1-git-send-email-richard@nod.at>
References: <1427372838-16605-1-git-send-email-richard@nod.at>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [PATCH 3/7] um: Remove ppc cruft
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org

That code is a relict from the early days of UML.
ppc support was never completed nor worked.
Let's rip it out.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/Makefile-ppc                        |   9 ---
 arch/um/sys-ppc/Makefile                    |  65 ----------------
 arch/um/sys-ppc/asm/archparam.h             |   8 --
 arch/um/sys-ppc/asm/elf.h                   |  51 -------------
 arch/um/sys-ppc/asm/processor.h             |  15 ----
 arch/um/sys-ppc/misc.S                      | 111 ----------------------------
 arch/um/sys-ppc/miscthings.c                |  42 -----------
 arch/um/sys-ppc/ptrace.c                    |  58 ---------------
 arch/um/sys-ppc/ptrace_user.c               |  29 --------
 arch/um/sys-ppc/shared/sysdep/ptrace.h      |  93 -----------------------
 arch/um/sys-ppc/shared/sysdep/sigcontext.h  |  52 -------------
 arch/um/sys-ppc/shared/sysdep/skas_ptrace.h |  22 ------
 arch/um/sys-ppc/shared/sysdep/syscalls.h    |  43 -----------
 arch/um/sys-ppc/sigcontext.c                |   4 -
 arch/um/sys-ppc/sysrq.c                     |  33 ---------
 15 files changed, 635 deletions(-)
 delete mode 100644 arch/um/Makefile-ppc
 delete mode 100644 arch/um/sys-ppc/Makefile
 delete mode 100644 arch/um/sys-ppc/asm/archparam.h
 delete mode 100644 arch/um/sys-ppc/asm/elf.h
 delete mode 100644 arch/um/sys-ppc/asm/processor.h
 delete mode 100644 arch/um/sys-ppc/misc.S
 delete mode 100644 arch/um/sys-ppc/miscthings.c
 delete mode 100644 arch/um/sys-ppc/ptrace.c
 delete mode 100644 arch/um/sys-ppc/ptrace_user.c
 delete mode 100644 arch/um/sys-ppc/shared/sysdep/ptrace.h
 delete mode 100644 arch/um/sys-ppc/shared/sysdep/sigcontext.h
 delete mode 100644 arch/um/sys-ppc/shared/sysdep/skas_ptrace.h
 delete mode 100644 arch/um/sys-ppc/shared/sysdep/syscalls.h
 delete mode 100644 arch/um/sys-ppc/sigcontext.c
 delete mode 100644 arch/um/sys-ppc/sysrq.c

diff --git a/arch/um/Makefile-ppc b/arch/um/Makefile-ppc
deleted file mode 100644
index 66fd200..0000000
--- a/arch/um/Makefile-ppc
+++ /dev/null
@@ -1,9 +0,0 @@
-ifeq ($(CONFIG_HOST_2G_2G), y)
-START_ADDR = 0x80000000
-else
-START_ADDR = 0xc0000000
-endif
-ARCH_CFLAGS = -U__powerpc__ -D__UM_PPC__
-
-# The arch is ppc, but the elf32 name is powerpc
-ELF_SUBARCH = powerpc
diff --git a/arch/um/sys-ppc/Makefile b/arch/um/sys-ppc/Makefile
deleted file mode 100644
index 20d363b..0000000
--- a/arch/um/sys-ppc/Makefile
+++ /dev/null
@@ -1,65 +0,0 @@
-OBJ = built-in.o
-
-.S.o:
-	$(CC) $(KBUILD_AFLAGS) -D__ASSEMBLY__ -D__UM_PPC__ -c $< -o $*.o
-
-OBJS = ptrace.o sigcontext.o checksum.o miscthings.o misc.o \
-	ptrace_user.o sysrq.o
-
-asflags-y := -DCONFIG_PPC32 -I. -I$(srctree)/arch/ppc/kernel
-
-all: $(OBJ)
-
-$(OBJ): $(OBJS)
-	rm -f $@
-	$(LD) $(LINKFLAGS) --start-group $^ --end-group -o $@
-
-ptrace_user.o: ptrace_user.c
-	$(CC) -D__KERNEL__ $(USER_CFLAGS) $(ccflags-y) -c -o $@ $<
-
-sigcontext.o: sigcontext.c
-	$(CC) $(USER_CFLAGS) $(ccflags-y) -c -o $@ $<
-
-checksum.S:
-	rm -f $@
-	ln -s $(srctree)/arch/ppc/lib/$@ $@
-
-mk_defs.c:
-	rm -f $@
-	ln -s $(srctree)/arch/ppc/kernel/$@ $@
-
-ppc_defs.head:
-	rm -f $@
-	ln -s $(srctree)/arch/ppc/kernel/$@ $@
-
-ppc_defs.h: mk_defs.c ppc_defs.head \
-		$(srctree)/include/asm-ppc/mmu.h \
-		$(srctree)/include/asm-ppc/processor.h \
-		$(srctree)/include/asm-ppc/pgtable.h \
-		$(srctree)/include/asm-ppc/ptrace.h
-#	$(CC) $(CFLAGS) -S mk_defs.c
-	cp ppc_defs.head ppc_defs.h
-# for bk, this way we can write to the file even if it's not checked out
-	echo '#define THREAD 608' >> ppc_defs.h
-	echo '#define PT_REGS 8' >> ppc_defs.h
-	echo '#define CLONE_VM 256' >> ppc_defs.h
-#	chmod u+w ppc_defs.h
-#	grep '^#define' mk_defs.s >> ppc_defs.h
-#	rm mk_defs.s
-
-# the asm link is horrible, and breaks the other targets.  This is also
-# not going to work with parallel makes.
-
-checksum.o: checksum.S
-	rm -f asm
-	ln -s $(srctree)/include/asm-ppc asm
-	$(CC) $(asflags-y) $(KBUILD_AFLAGS) -D__ASSEMBLY__ -D__UM_PPC__ -c $< -o $*.o
-	rm -f asm
-
-misc.o: misc.S ppc_defs.h
-	rm -f asm
-	ln -s $(srctree)/include/asm-ppc asm
-	$(CC) $(asflags-y) $(KBUILD_AFLAGS) -D__ASSEMBLY__ -D__UM_PPC__ -c $< -o $*.o
-	rm -f asm
-
-clean-files := $(OBJS) ppc_defs.h checksum.S mk_defs.c
diff --git a/arch/um/sys-ppc/asm/archparam.h b/arch/um/sys-ppc/asm/archparam.h
deleted file mode 100644
index 4269d8a..0000000
--- a/arch/um/sys-ppc/asm/archparam.h
+++ /dev/null
@@ -1,8 +0,0 @@
-#ifndef __UM_ARCHPARAM_PPC_H
-#define __UM_ARCHPARAM_PPC_H
-
-/********* Bits for asm-um/string.h **********/
-
-#define __HAVE_ARCH_STRRCHR
-
-#endif
diff --git a/arch/um/sys-ppc/asm/elf.h b/arch/um/sys-ppc/asm/elf.h
deleted file mode 100644
index 8aacaf5..0000000
--- a/arch/um/sys-ppc/asm/elf.h
+++ /dev/null
@@ -1,51 +0,0 @@
-#ifndef __UM_ELF_PPC_H
-#define __UM_ELF_PPC_H
-
-
-extern long elf_aux_hwcap;
-#define ELF_HWCAP (elf_aux_hwcap)
-
-#define SET_PERSONALITY(ex) do ; while(0)
-
-#define ELF_EXEC_PAGESIZE 4096
-
-#define elf_check_arch(x) (1)
-
-#ifdef CONFIG_64BIT
-#define ELF_CLASS ELFCLASS64
-#else
-#define ELF_CLASS ELFCLASS32
-#endif
-
-#define R_386_NONE	0
-#define R_386_32	1
-#define R_386_PC32	2
-#define R_386_GOT32	3
-#define R_386_PLT32	4
-#define R_386_COPY	5
-#define R_386_GLOB_DAT	6
-#define R_386_JMP_SLOT	7
-#define R_386_RELATIVE	8
-#define R_386_GOTOFF	9
-#define R_386_GOTPC	10
-#define R_386_NUM	11
-
-#define ELF_PLATFORM (0)
-
-#define ELF_ET_DYN_BASE (0x08000000)
-
-/* the following stolen from asm-ppc/elf.h */
-#define ELF_NGREG	48	/* includes nip, msr, lr, etc. */
-#define ELF_NFPREG	33	/* includes fpscr */
-/* General registers */
-typedef unsigned long elf_greg_t;
-typedef elf_greg_t elf_gregset_t[ELF_NGREG];
-
-/* Floating point registers */
-typedef double elf_fpreg_t;
-typedef elf_fpreg_t elf_fpregset_t[ELF_NFPREG];
-
-#define ELF_DATA        ELFDATA2MSB
-#define ELF_ARCH	EM_PPC
-
-#endif
diff --git a/arch/um/sys-ppc/asm/processor.h b/arch/um/sys-ppc/asm/processor.h
deleted file mode 100644
index 9593231..0000000
--- a/arch/um/sys-ppc/asm/processor.h
+++ /dev/null
@@ -1,15 +0,0 @@
-#ifndef __UM_PROCESSOR_PPC_H
-#define __UM_PROCESSOR_PPC_H
-
-#if defined(__ASSEMBLY__)
-
-#define CONFIG_PPC_MULTIPLATFORM
-#include "arch/processor.h"
-
-#else
-
-#include "asm/processor-generic.h"
-
-#endif
-
-#endif
diff --git a/arch/um/sys-ppc/misc.S b/arch/um/sys-ppc/misc.S
deleted file mode 100644
index 1364b7d..0000000
--- a/arch/um/sys-ppc/misc.S
+++ /dev/null
@@ -1,111 +0,0 @@
-/*
- * This file contains miscellaneous low-level functions.
- *    Copyright (C) 1995-1996 Gary Thomas (gdt@linuxppc.org)
- *
- * Largely rewritten by Cort Dougan (cort@cs.nmt.edu)
- * and Paul Mackerras.
- *
- * A couple of functions stolen from arch/ppc/kernel/misc.S for UML
- * by Chris Emerson.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- *
- */
-
-#include <asm/processor.h>
-#include "ppc_asm.h"
-
-#if defined(CONFIG_4xx) || defined(CONFIG_8xx)
-#define CACHE_LINE_SIZE		16
-#define LG_CACHE_LINE_SIZE	4
-#define MAX_COPY_PREFETCH	1
-#else
-#define CACHE_LINE_SIZE		32
-#define LG_CACHE_LINE_SIZE	5
-#define MAX_COPY_PREFETCH	4
-#endif /* CONFIG_4xx || CONFIG_8xx */
-
-	.text
-
-/*
- * Clear a page using the dcbz instruction, which doesn't cause any
- * memory traffic (except to write out any cache lines which get
- * displaced).  This only works on cacheable memory.
- */
-_GLOBAL(clear_page)
-	li	r0,4096/CACHE_LINE_SIZE
-	mtctr	r0
-#ifdef CONFIG_8xx
-	li	r4, 0
-1:	stw	r4, 0(r3)
-	stw	r4, 4(r3)
-	stw	r4, 8(r3)
-	stw	r4, 12(r3)
-#else
-1:	dcbz	0,r3
-#endif
-	addi	r3,r3,CACHE_LINE_SIZE
-	bdnz	1b
-	blr
-
-/*
- * Copy a whole page.  We use the dcbz instruction on the destination
- * to reduce memory traffic (it eliminates the unnecessary reads of
- * the destination into cache).  This requires that the destination
- * is cacheable.
- */
-#define COPY_16_BYTES		\
-	lwz	r6,4(r4);	\
-	lwz	r7,8(r4);	\
-	lwz	r8,12(r4);	\
-	lwzu	r9,16(r4);	\
-	stw	r6,4(r3);	\
-	stw	r7,8(r3);	\
-	stw	r8,12(r3);	\
-	stwu	r9,16(r3)
-
-_GLOBAL(copy_page)
-	addi	r3,r3,-4
-	addi	r4,r4,-4
-	li	r5,4
-
-#ifndef CONFIG_8xx
-#if MAX_COPY_PREFETCH > 1
-	li	r0,MAX_COPY_PREFETCH
-	li	r11,4
-	mtctr	r0
-11:	dcbt	r11,r4
-	addi	r11,r11,CACHE_LINE_SIZE
-	bdnz	11b
-#else /* MAX_COPY_PREFETCH == 1 */
-	dcbt	r5,r4
-	li	r11,CACHE_LINE_SIZE+4
-#endif /* MAX_COPY_PREFETCH */
-#endif /* CONFIG_8xx */
-
-	li	r0,4096/CACHE_LINE_SIZE
-	mtctr	r0
-1:
-#ifndef CONFIG_8xx
-	dcbt	r11,r4
-	dcbz	r5,r3
-#endif
-	COPY_16_BYTES
-#if CACHE_LINE_SIZE >= 32
-	COPY_16_BYTES
-#if CACHE_LINE_SIZE >= 64
-	COPY_16_BYTES
-	COPY_16_BYTES
-#if CACHE_LINE_SIZE >= 128
-	COPY_16_BYTES
-	COPY_16_BYTES
-	COPY_16_BYTES
-	COPY_16_BYTES
-#endif
-#endif
-#endif
-	bdnz	1b
-	blr
diff --git a/arch/um/sys-ppc/miscthings.c b/arch/um/sys-ppc/miscthings.c
deleted file mode 100644
index 25908d2..0000000
--- a/arch/um/sys-ppc/miscthings.c
+++ /dev/null
@@ -1,42 +0,0 @@
-#include <linux/threads.h>
-#include <linux/stddef.h>  // for NULL
-#include <linux/elf.h>  // for AT_NULL
-
-/* The following function nicked from arch/ppc/kernel/process.c and
- * adapted slightly */
-/*
- * XXX ld.so expects the auxiliary table to start on
- * a 16-byte boundary, so we have to find it and
- * move it up. :-(
- */
-void shove_aux_table(unsigned long sp)
-{
-	int argc;
-	char *p;
-	unsigned long e;
-	unsigned long aux_start, offset;
-
-	argc = *(int *)sp;
-	sp += sizeof(int) + (argc + 1) * sizeof(char *);
-	/* skip over the environment pointers */
-	do {
-		p = *(char **)sp;
-		sp += sizeof(char *);
-	} while (p != NULL);
-	aux_start = sp;
-	/* skip to the end of the auxiliary table */
-	do {
-		e = *(unsigned long *)sp;
-		sp += 2 * sizeof(unsigned long);
-	} while (e != AT_NULL);
-	offset = ((aux_start + 15) & ~15) - aux_start;
-	if (offset != 0) {
-		do {
-			sp -= sizeof(unsigned long);
-			e = *(unsigned long *)sp;
-			*(unsigned long *)(sp + offset) = e;
-		} while (sp > aux_start);
-	}
-}
-/* END stuff taken from arch/ppc/kernel/process.c */
-
diff --git a/arch/um/sys-ppc/ptrace.c b/arch/um/sys-ppc/ptrace.c
deleted file mode 100644
index 8245df4..0000000
--- a/arch/um/sys-ppc/ptrace.c
+++ /dev/null
@@ -1,58 +0,0 @@
-#include <linux/sched.h>
-#include "asm/ptrace.h"
-
-int putreg(struct task_struct *child, unsigned long regno, 
-		  unsigned long value)
-{
-	child->thread.process_regs.regs[regno >> 2] = value;
-	return 0;
-}
-
-int poke_user(struct task_struct *child, long addr, long data)
-{
-	if ((addr & 3) || addr < 0)
-		return -EIO;
-
-	if (addr < MAX_REG_OFFSET)
-		return putreg(child, addr, data);
-
-	else if((addr >= offsetof(struct user, u_debugreg[0])) &&
-		(addr <= offsetof(struct user, u_debugreg[7]))){
-		  addr -= offsetof(struct user, u_debugreg[0]);
-		  addr = addr >> 2;
-		  if((addr == 4) || (addr == 5)) return -EIO;
-		  child->thread.arch.debugregs[addr] = data;
-		  return 0;
-	}
-	return -EIO;
-}
-
-unsigned long getreg(struct task_struct *child, unsigned long regno)
-{
-	unsigned long retval = ~0UL;
-
-	retval &= child->thread.process_regs.regs[regno >> 2];
-	return retval;
-}
-
-int peek_user(struct task_struct *child, long addr, long data)
-{
-	/* read the word at location addr in the USER area. */
-	unsigned long tmp;
-
-	if ((addr & 3) || addr < 0)
-		return -EIO;
-
-	tmp = 0;  /* Default return condition */
-	if(addr < MAX_REG_OFFSET){
-		tmp = getreg(child, addr);
-	}
-	else if((addr >= offsetof(struct user, u_debugreg[0])) &&
-		(addr <= offsetof(struct user, u_debugreg[7]))){
-		addr -= offsetof(struct user, u_debugreg[0]);
-		addr = addr >> 2;
-		tmp = child->thread.arch.debugregs[addr];
-	}
-	return put_user(tmp, (unsigned long *) data);
-}
-
diff --git a/arch/um/sys-ppc/ptrace_user.c b/arch/um/sys-ppc/ptrace_user.c
deleted file mode 100644
index 4601b92..0000000
--- a/arch/um/sys-ppc/ptrace_user.c
+++ /dev/null
@@ -1,29 +0,0 @@
-#include <errno.h>
-#include <asm/ptrace.h>
-#include <sysdep/ptrace.h>
-
-int ptrace_getregs(long pid, unsigned long *regs_out)
-{
-    int i;
-    for (i=0; i < sizeof(struct sys_pt_regs)/sizeof(PPC_REG); ++i) {
-	errno = 0;
-	regs_out->regs[i] = ptrace(PTRACE_PEEKUSR, pid, i*4, 0);
-	if (errno) {
-	    return -errno;
-	}
-    }
-    return 0;
-}
-
-int ptrace_setregs(long pid, unsigned long *regs_in)
-{
-    int i;
-    for (i=0; i < sizeof(struct sys_pt_regs)/sizeof(PPC_REG); ++i) {
-	if (i != 34 /* FIXME: PT_ORIG_R3 */ && i <= PT_MQ) {
-	    if (ptrace(PTRACE_POKEUSR, pid, i*4, regs_in->regs[i]) < 0) {
-		return -errno;
-	    }
-	}
-    }
-    return 0;
-}
diff --git a/arch/um/sys-ppc/shared/sysdep/ptrace.h b/arch/um/sys-ppc/shared/sysdep/ptrace.h
deleted file mode 100644
index efe0c1a..0000000
--- a/arch/um/sys-ppc/shared/sysdep/ptrace.h
+++ /dev/null
@@ -1,93 +0,0 @@
-/* 
- * Licensed under the GPL
- */
-
-#ifndef __SYS_PTRACE_PPC_H
-#define __SYS_PTRACE_PPC_H
-
-#include <linux/types.h>
-
-/* the following taken from <asm-ppc/ptrace.h> */
-
-#ifdef CONFIG_PPC64
-#define PPC_REG unsigned long /*long*/
-#else
-#define PPC_REG unsigned long
-#endif
-struct sys_pt_regs_s {
-	PPC_REG gpr[32];
-	PPC_REG nip;
-	PPC_REG msr;
-	PPC_REG orig_gpr3;	/* Used for restarting system calls */
-	PPC_REG ctr;
-	PPC_REG link;
-	PPC_REG xer;
-	PPC_REG ccr;
-	PPC_REG mq;		/* 601 only (not used at present) */
-				/* Used on APUS to hold IPL value. */
-	PPC_REG trap;		/* Reason for being here */
-	PPC_REG dar;		/* Fault registers */
-	PPC_REG dsisr;
-	PPC_REG result; 	/* Result of a system call */
-};
-
-#define NUM_REGS (sizeof(struct sys_pt_regs_s) / sizeof(PPC_REG))
-
-struct sys_pt_regs {
-    PPC_REG regs[sizeof(struct sys_pt_regs_s) / sizeof(PPC_REG)];
-};
-
-#define UM_MAX_REG (PT_FPR0)
-#define UM_MAX_REG_OFFSET (UM_MAX_REG * sizeof(PPC_REG))
-
-#define EMPTY_REGS { { [ 0 ... NUM_REGS - 1] = 0 } }
-
-#define UM_REG(r, n) ((r)->regs[n])
-
-#define UM_SYSCALL_RET(r) UM_REG(r, PT_R3)
-#define UM_SP(r) UM_REG(r, PT_R1)
-#define UM_IP(r) UM_REG(r, PT_NIP)
-#define UM_ELF_ZERO(r) UM_REG(r, PT_FPSCR)
-#define UM_SYSCALL_NR(r) UM_REG(r, PT_R0)
-#define UM_SYSCALL_ARG1(r) UM_REG(r, PT_ORIG_R3)
-#define UM_SYSCALL_ARG2(r) UM_REG(r, PT_R4)
-#define UM_SYSCALL_ARG3(r) UM_REG(r, PT_R5)
-#define UM_SYSCALL_ARG4(r) UM_REG(r, PT_R6)
-#define UM_SYSCALL_ARG5(r) UM_REG(r, PT_R7)
-#define UM_SYSCALL_ARG6(r) UM_REG(r, PT_R8)
-
-#define UM_SYSCALL_NR_OFFSET (PT_R0 * sizeof(PPC_REG))
-#define UM_SYSCALL_RET_OFFSET (PT_R3 * sizeof(PPC_REG))
-#define UM_SYSCALL_ARG1_OFFSET (PT_R3 * sizeof(PPC_REG))
-#define UM_SYSCALL_ARG2_OFFSET (PT_R4 * sizeof(PPC_REG))
-#define UM_SYSCALL_ARG3_OFFSET (PT_R5 * sizeof(PPC_REG))
-#define UM_SYSCALL_ARG4_OFFSET (PT_R6 * sizeof(PPC_REG))
-#define UM_SYSCALL_ARG5_OFFSET (PT_R7 * sizeof(PPC_REG))
-#define UM_SYSCALL_ARG6_OFFSET (PT_R8 * sizeof(PPC_REG))
-#define UM_SP_OFFSET (PT_R1 * sizeof(PPC_REG))
-#define UM_IP_OFFSET (PT_NIP * sizeof(PPC_REG))
-#define UM_ELF_ZERO_OFFSET (PT_R3 * sizeof(PPC_REG))
-
-#define UM_SET_SYSCALL_RETURN(_regs, result)	        \
-do {                                                    \
-        if (result < 0) {				\
-		(_regs)->regs[PT_CCR] |= 0x10000000;	\
-		UM_SYSCALL_RET((_regs)) = -result;	\
-        } else {					\
-		UM_SYSCALL_RET((_regs)) = result;	\
-        }                                               \
-} while(0)
-
-extern void shove_aux_table(unsigned long sp);
-#define UM_FIX_EXEC_STACK(sp) shove_aux_table(sp);
-
-/* These aren't actually defined.  The undefs are just to make sure
- * everyone's clear on the concept.
- */
-#undef UML_HAVE_GETREGS
-#undef UML_HAVE_GETFPREGS
-#undef UML_HAVE_SETREGS
-#undef UML_HAVE_SETFPREGS
-
-#endif
-
diff --git a/arch/um/sys-ppc/shared/sysdep/sigcontext.h b/arch/um/sys-ppc/shared/sysdep/sigcontext.h
deleted file mode 100644
index b7286f0..0000000
--- a/arch/um/sys-ppc/shared/sysdep/sigcontext.h
+++ /dev/null
@@ -1,52 +0,0 @@
-/* 
- * Copyright (C) 2000 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#ifndef __SYS_SIGCONTEXT_PPC_H
-#define __SYS_SIGCONTEXT_PPC_H
-
-#define DSISR_WRITE 0x02000000
-
-#define SC_FAULT_ADDR(sc) ({ \
-		struct sigcontext *_sc = (sc); \
-		long retval = -1; \
-		switch (_sc->regs->trap) { \
-		case 0x300: \
-			/* data exception */ \
-			retval = _sc->regs->dar; \
-			break; \
-		case 0x400: \
-			/* instruction exception */ \
-			retval = _sc->regs->nip; \
-			break; \
-		default: \
-			panic("SC_FAULT_ADDR: unhandled trap type\n"); \
-		} \
-		retval; \
-	})
-
-#define SC_FAULT_WRITE(sc) ({ \
-		struct sigcontext *_sc = (sc); \
-		long retval = -1; \
-		switch (_sc->regs->trap) { \
-		case 0x300: \
-			/* data exception */ \
-			retval = !!(_sc->regs->dsisr & DSISR_WRITE); \
-			break; \
-		case 0x400: \
-			/* instruction exception: not a write */ \
-			retval = 0; \
-			break; \
-		default: \
-			panic("SC_FAULT_ADDR: unhandled trap type\n"); \
-		} \
-		retval; \
-	})
-
-#define SC_IP(sc) ((sc)->regs->nip)
-#define SC_SP(sc) ((sc)->regs->gpr[1])
-#define SEGV_IS_FIXABLE(sc) (1)
-
-#endif
-
diff --git a/arch/um/sys-ppc/shared/sysdep/skas_ptrace.h b/arch/um/sys-ppc/shared/sysdep/skas_ptrace.h
deleted file mode 100644
index d9fbbac..0000000
--- a/arch/um/sys-ppc/shared/sysdep/skas_ptrace.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- * Copyright (C) 2000, 2001, 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#ifndef __SYSDEP_PPC_SKAS_PTRACE_H
-#define __SYSDEP_PPC_SKAS_PTRACE_H
-
-struct ptrace_faultinfo {
-        int is_write;
-        unsigned long addr;
-};
-
-struct ptrace_ldt {
-        int func;
-        void *ptr;
-        unsigned long bytecount;
-};
-
-#define PTRACE_LDT 54
-
-#endif
diff --git a/arch/um/sys-ppc/shared/sysdep/syscalls.h b/arch/um/sys-ppc/shared/sysdep/syscalls.h
deleted file mode 100644
index 1ff8155..0000000
--- a/arch/um/sys-ppc/shared/sysdep/syscalls.h
+++ /dev/null
@@ -1,43 +0,0 @@
-/* 
- * Copyright (C) 2000 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-typedef long syscall_handler_t(unsigned long arg1, unsigned long arg2,
-			       unsigned long arg3, unsigned long arg4,
-			       unsigned long arg5, unsigned long arg6);
-
-#define EXECUTE_SYSCALL(syscall, regs) \
-        (*sys_call_table[syscall])(UM_SYSCALL_ARG1(&regs), \
-			           UM_SYSCALL_ARG2(&regs), \
-				   UM_SYSCALL_ARG3(&regs), \
-				   UM_SYSCALL_ARG4(&regs), \
-				   UM_SYSCALL_ARG5(&regs), \
-				   UM_SYSCALL_ARG6(&regs))
-
-extern syscall_handler_t sys_mincore;
-extern syscall_handler_t sys_madvise;
-
-/* old_mmap needs the correct prototype since syscall_kern.c includes
- * this file.
- */
-int old_mmap(unsigned long addr, unsigned long len,
-	     unsigned long prot, unsigned long flags,
-	     unsigned long fd, unsigned long offset);
-
-#define ARCH_SYSCALLS \
-	[ __NR_modify_ldt ] = sys_ni_syscall, \
-	[ __NR_pciconfig_read ] = sys_ni_syscall, \
-	[ __NR_pciconfig_write ] = sys_ni_syscall, \
-	[ __NR_pciconfig_iobase ] = sys_ni_syscall, \
-	[ __NR_pivot_root ] = sys_ni_syscall, \
-	[ __NR_multiplexer ] = sys_ni_syscall, \
-	[ __NR_mmap ] = old_mmap, \
-	[ __NR_madvise ] = sys_madvise, \
-	[ __NR_mincore ] = sys_mincore, \
-	[ __NR_iopl ] = (syscall_handler_t *) sys_ni_syscall, \
-	[ __NR_utimes ] = (syscall_handler_t *) sys_utimes, \
-	[ __NR_fadvise64 ] = (syscall_handler_t *) sys_fadvise64,
-
-#define LAST_ARCH_SYSCALL __NR_fadvise64
-
diff --git a/arch/um/sys-ppc/sigcontext.c b/arch/um/sys-ppc/sigcontext.c
deleted file mode 100644
index aac6c83..0000000
--- a/arch/um/sys-ppc/sigcontext.c
+++ /dev/null
@@ -1,4 +0,0 @@
-#include "asm/ptrace.h"
-#include "asm/sigcontext.h"
-#include <sysdep/ptrace.h>
-
diff --git a/arch/um/sys-ppc/sysrq.c b/arch/um/sys-ppc/sysrq.c
deleted file mode 100644
index 1ff1ad7..0000000
--- a/arch/um/sys-ppc/sysrq.c
+++ /dev/null
@@ -1,33 +0,0 @@
-/* 
- * Copyright (C) 2001 Chris Emerson (cemerson@chiark.greenend.org.uk)
- * Licensed under the GPL
- */
-
-#include <linux/kernel.h>
-#include <linux/smp.h>
-#include "asm/ptrace.h"
-#include "sysrq.h"
-
-void show_regs(struct pt_regs_subarch *regs)
-{
-	printk("\n");
-	show_regs_print_info(KERN_DEFAULT);
-
-	printk("show_regs(): insert regs here.\n");
-#if 0
-        printk("\n");
-        printk("EIP: %04x:[<%08lx>] CPU: %d",0xffff & regs->xcs, regs->eip,
-	       smp_processor_id());
-        if (regs->xcs & 3)
-                printk(" ESP: %04x:%08lx",0xffff & regs->xss, regs->esp);
-        printk(" EFLAGS: %08lx\n", regs->eflags);
-        printk("EAX: %08lx EBX: %08lx ECX: %08lx EDX: %08lx\n",
-                regs->eax, regs->ebx, regs->ecx, regs->edx);
-        printk("ESI: %08lx EDI: %08lx EBP: %08lx",
-                regs->esi, regs->edi, regs->ebp);
-        printk(" DS: %04x ES: %04x\n",
-                0xffff & regs->xds, 0xffff & regs->xes);
-#endif
-
-        show_trace(current, &regs->gpr[1]);
-}
-- 
1.8.4.5


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

