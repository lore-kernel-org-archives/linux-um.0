Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from zeniv-ca.linux.org.uk ([2607:5300:60:148a::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSQuM-003BNH-Aj
 for linux-um@lists.infradead.org; Mon, 20 Sep 2021 21:33:03 +0000
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1mSQuL-005yeF-HP
 for linux-um@lists.infradead.org; Mon, 20 Sep 2021 21:33:01 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 02/15] um: move amd64 variant of mmap(2) to
 arch/x86/um/syscalls_64.c
Date: Mon, 20 Sep 2021 21:32:48 +0000
Message-Id: <20210920213301.1424730-2-viro@zeniv.linux.org.uk>
In-Reply-To: <20210920213301.1424730-1-viro@zeniv.linux.org.uk>
References: <YUj9S+S4Gd86mM6N@zeniv-ca.linux.org.uk>
 <20210920213301.1424730-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/um/kernel/Makefile                 |  2 +-
 arch/um/kernel/syscall.c                | 28 ----------------------------
 arch/x86/um/shared/sysdep/syscalls_64.h |  3 ---
 arch/x86/um/sys_call_table_64.c         |  3 ---
 arch/x86/um/syscalls_64.c               | 10 ++++++++++
 5 files changed, 11 insertions(+), 35 deletions(-)
 delete mode 100644 arch/um/kernel/syscall.c

diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
index 1d18e4e469895..7ab6d40558b61 100644
--- a/arch/um/kernel/Makefile
+++ b/arch/um/kernel/Makefile
@@ -16,7 +16,7 @@ extra-y := vmlinux.lds
 
 obj-y = config.o exec.o exitcode.o irq.o ksyms.o mem.o \
 	physmem.o process.o ptrace.o reboot.o sigio.o \
-	signal.o syscall.o sysrq.o time.o tlb.o trap.o \
+	signal.o sysrq.o time.o tlb.o trap.o \
 	um_arch.o umid.o maccess.o kmsg_dump.o capflags.o skas/
 
 obj-$(CONFIG_BLK_DEV_INITRD) += initrd.o
diff --git a/arch/um/kernel/syscall.c b/arch/um/kernel/syscall.c
deleted file mode 100644
index eed54c53fbbb9..0000000000000
--- a/arch/um/kernel/syscall.c
+++ /dev/null
@@ -1,28 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- */
-
-#include <linux/file.h>
-#include <linux/fs.h>
-#include <linux/mm.h>
-#include <linux/sched.h>
-#include <linux/utsname.h>
-#include <linux/syscalls.h>
-#include <asm/current.h>
-#include <asm/mman.h>
-#include <linux/uaccess.h>
-#include <asm/unistd.h>
-
-long old_mmap(unsigned long addr, unsigned long len,
-	      unsigned long prot, unsigned long flags,
-	      unsigned long fd, unsigned long offset)
-{
-	long err = -EINVAL;
-	if (offset & ~PAGE_MASK)
-		goto out;
-
-	err = ksys_mmap_pgoff(addr, len, prot, flags, fd, offset >> PAGE_SHIFT);
- out:
-	return err;
-}
diff --git a/arch/x86/um/shared/sysdep/syscalls_64.h b/arch/x86/um/shared/sysdep/syscalls_64.h
index 8a7d5e1da98e5..48d6cd12f8a5e 100644
--- a/arch/x86/um/shared/sysdep/syscalls_64.h
+++ b/arch/x86/um/shared/sysdep/syscalls_64.h
@@ -23,9 +23,6 @@ extern syscall_handler_t *sys_call_table[];
 				      UPT_SYSCALL_ARG5(&regs->regs), \
 				      UPT_SYSCALL_ARG6(&regs->regs)))
 
-extern long old_mmap(unsigned long addr, unsigned long len,
-		     unsigned long prot, unsigned long flags,
-		     unsigned long fd, unsigned long pgoff);
 extern syscall_handler_t sys_modify_ldt;
 extern syscall_handler_t sys_arch_prctl;
 
diff --git a/arch/x86/um/sys_call_table_64.c b/arch/x86/um/sys_call_table_64.c
index 82b695ed23c41..b0b4cfd2308c8 100644
--- a/arch/x86/um/sys_call_table_64.c
+++ b/arch/x86/um/sys_call_table_64.c
@@ -18,9 +18,6 @@
 #define sys_iopl sys_ni_syscall
 #define sys_ioperm sys_ni_syscall
 
-/* On UML we call it this way ("old" means it's not mmap2) */
-#define sys_mmap old_mmap
-
 #define __SYSCALL(nr, sym) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
 #include <asm/syscalls_64.h>
 
diff --git a/arch/x86/um/syscalls_64.c b/arch/x86/um/syscalls_64.c
index 58f51667e2e4b..ad974f8ddf11b 100644
--- a/arch/x86/um/syscalls_64.c
+++ b/arch/x86/um/syscalls_64.c
@@ -87,3 +87,13 @@ void arch_switch_to(struct task_struct *to)
 
 	arch_prctl(to, ARCH_SET_FS, (void __user *) to->thread.arch.fs);
 }
+
+SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
+		unsigned long, prot, unsigned long, flags,
+		unsigned long, fd, unsigned long, off)
+{
+	if (off & ~PAGE_MASK)
+		return -EINVAL;
+
+	return ksys_mmap_pgoff(addr, len, prot, flags, fd, off >> PAGE_SHIFT);
+}
-- 
2.11.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

