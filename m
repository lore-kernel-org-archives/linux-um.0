Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B3DCCFA1A
	for <linux-um@archiver.kernel.org>; Sat,  8 Nov 2025 08:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AADfWcJgVjD9ZN7PUFLyBggrmXQYWqBtbT5qNU1VBN8=; b=kizyKVIz3YdnW/+cQNKCb7b0qR
	5p9rUP9yNvq4v2V3Zib6W4FRn9vvzBDRznOctLAfWrqiZSJ9omRk7wHf0P3V3hgBE526MFAqy2pAI
	GDcwef2SaReINPNwRRdbxvuEZnJEtEaSQ7UmNQRV47eVW9ADuPfgcn4pw5i3myqjEzqQElCCXB/M8
	vVq9HZ3GaJaFaXCq50V8uBgUmtVULXVwe9uL6aEaR2wm77uv0zVZpjHNDIydlAq7LlCiWtjf5qkOe
	oyGLmZoLLR7rFw1R/h1RM2/kgzK+eRaWNo77NHmk1vX9HT1YqQROLOOiicaOYxwq5PAIOvPH66vsa
	xUkLehxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHdxU-00000002isA-3AeZ;
	Sat, 08 Nov 2025 08:06:04 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHdxS-00000002ir4-2MJh
	for linux-um@lists.infradead.org;
	Sat, 08 Nov 2025 08:06:03 +0000
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-294fe7c2e69so16024585ad.0
        for <linux-um@lists.infradead.org>; Sat, 08 Nov 2025 00:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762589162; x=1763193962; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AADfWcJgVjD9ZN7PUFLyBggrmXQYWqBtbT5qNU1VBN8=;
        b=GC95wLpuQyLqBhEd8vihHCKAB6YLa/Q8L8KGA3ED1x2yOR51rF7y6+0usmRzHWK1Eh
         Oz2XDhHEmdrzl9e0P4AVeK3q8jlz9wRj4G8cAHvAhHXzfGVehMS9NMboABeAb8JDMgQC
         4QmJxd/zvj+urWsfiYnlUk/xhFhQTgdZjIJdmIZffxtTJnJo/6Na38VFhpEMKJ2PFYT/
         AtkTCd8rx/bdQ+ZVbmpGiKiow3Mlz+gFUhp/3FW7VcW5F+DElLwtRWdtE9uYMJzk5YDb
         FC1LCd+PH7OAye6UBTOIUk9EQz3EPNSpDMNSmfDx/hxSeyuk1iYYRhAx63dGid4TRKKX
         zFVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762589162; x=1763193962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AADfWcJgVjD9ZN7PUFLyBggrmXQYWqBtbT5qNU1VBN8=;
        b=qUNY42e+6ESb+6MXNVWa9ZGoianAlxB8X38loiflPB1PW4yhnzjqxxQzpu6F3lgHCK
         NJnT/QUadgaDcTMCQczCm5cZDXvEJGV/Mpo6qQ1zctQYU9y3gjltnSvR30ujt1dBvJ7Q
         uHzYKcUjgN5J0xOjZDcGZMcXU+ka+ZwgJ6Dgxo7gmTmSZ1rhRlsSQ7/Kkkn731h2WS6J
         D6sNLr+ukSegOJOk4YwhsRZadoBYxLQgrWr8AIcgRqkGKW/5v/Aa9YwMer3ZMxy+oqF+
         mFTbQXt1t5KCU6m9afPNO3q7bllaDWYwppKp/gih/Lf95ronmdgBITOTABowAe9ox+Bn
         IrXg==
X-Gm-Message-State: AOJu0YydkHMggicGMz5tgzLtU/G0FRuuR9ZgmIT9lRhkiZoQSqacyuc+
	9vpXkOzmUsjGZONvGT95Uzs9uURasv4iX6L8+/fg9gtwZ/Y/zRZDlwJ1
X-Gm-Gg: ASbGncs0SxQDLQoppvRJ8VVMoSvNhzR617lQte3qFRkiIlhDG8Pmt74kV2mtyAMcOPd
	QfRvdqqtaacWJWRHNqcE0S/1FpeY/O8t9gA2PP6YMu5XIIxwDIaPnCZKLI86iup3yv2UNg1U1I8
	YQK93OM1Dow9Mra28zuPUb1bhzTaiCxL+T2CcG7Yu5+RfCyVI/f3aSS61ktF8R67rNlhCM3wLlQ
	zmmI/ccQ+n4d0rfiAzLhHhG5uLxrPOmnF8Fz9xliGm577e35v+eFZNuCQZU5iw3LPfZiM77dIRv
	F8SPHXr7/cVDNLpduOp+W/7ta3QzRS4WKZHItuSCBye1l2DHz7E/sPAPrgnJ1o6Myd3j1QzuWhC
	Q+eQop0AJURYb0SZK62WLEsj2YI/haxKrhQi6QKtO0xT5ceCOAW86XIL21k+CoN4j5OcITDY32i
	/3nh+fMIOYSIKUDbY03yKadhxJPeFoU12onVfOuATlC4fHuw==
X-Google-Smtp-Source: AGHT+IFiJr0EeMCxqF+xD/dFMEIX//Iica2/667frEt8MglvDOKULW8yWmUZ2gxdKGQQIHQbJRODxQ==
X-Received: by 2002:a17:902:f791:b0:297:e267:c4c1 with SMTP id d9443c01a7336-297e5718125mr22597115ad.55.1762589161767;
        Sat, 08 Nov 2025 00:06:01 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c6f6cdsm83649695ad.71.2025.11.08.00.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 00:06:01 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 57AE911388C9; Sat,  8 Nov 2025 17:05:59 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v13 02/13] um: decouple MMU specific code from the common part
Date: Sat,  8 Nov 2025 17:05:37 +0900
Message-ID: <df871d488f69a512ad762bf22d63e6615946566c.1762588860.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762588860.git.thehajime@gmail.com>
References: <cover.1762588860.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251108_000602_630271_D55D3EC8 
X-CRM114-Status: GOOD (  21.88  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

This splits the memory, process related code with common and MMU
specific parts in order to avoid ifdefs in .c file and duplication
between MMU and !MMU.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 arch/um/kernel/Makefile         |   5 +-
 arch/um/kernel/mem-pgtable.c    |  55 ++++++++++++++
 arch/um/kernel/mem.c            |  35 ---------
 arch/um/kernel/process.c        |  38 ++++++++++
 arch/um/kernel/skas/process.c   |  37 ---------
 arch/um/os-Linux/Makefile       |   3 +-
 arch/um/os-Linux/process.c      | 129 ++++++++++++++++++++++++++++++++
 arch/um/os-Linux/skas/process.c | 127 -------------------------------
 8 files changed, 227 insertions(+), 202 deletions(-)
 create mode 100644 arch/um/kernel/mem-pgtable.c

diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
index be60bc451b3f..76d36751973e 100644
--- a/arch/um/kernel/Makefile
+++ b/arch/um/kernel/Makefile
@@ -16,9 +16,10 @@ always-$(KBUILD_BUILTIN) := vmlinux.lds
 
 obj-y = config.o exec.o exitcode.o irq.o ksyms.o mem.o \
 	physmem.o process.o ptrace.o reboot.o sigio.o \
-	signal.o sysrq.o time.o tlb.o trap.o \
-	um_arch.o umid.o kmsg_dump.o capflags.o skas/
+	signal.o sysrq.o time.o \
+	um_arch.o umid.o kmsg_dump.o capflags.o
 obj-y += load_file.o
+obj-$(CONFIG_MMU) += mem-pgtable.o tlb.o trap.o skas/
 
 obj-$(CONFIG_BLK_DEV_INITRD) += initrd.o
 obj-$(CONFIG_GPROF)	+= gprof_syms.o
diff --git a/arch/um/kernel/mem-pgtable.c b/arch/um/kernel/mem-pgtable.c
new file mode 100644
index 000000000000..549da1d3bff0
--- /dev/null
+++ b/arch/um/kernel/mem-pgtable.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
+ */
+
+#include <linux/stddef.h>
+#include <linux/module.h>
+#include <linux/memblock.h>
+#include <linux/swap.h>
+#include <linux/slab.h>
+#include <asm/page.h>
+#include <asm/pgalloc.h>
+#include <as-layout.h>
+#include <init.h>
+#include <kern.h>
+#include <kern_util.h>
+#include <mem_user.h>
+#include <os.h>
+#include <um_malloc.h>
+
+
+/* Allocate and free page tables. */
+
+pgd_t *pgd_alloc(struct mm_struct *mm)
+{
+	pgd_t *pgd = (pgd_t *)__get_free_page(GFP_KERNEL);
+
+	if (pgd) {
+		memset(pgd, 0, USER_PTRS_PER_PGD * sizeof(pgd_t));
+		memcpy(pgd + USER_PTRS_PER_PGD,
+		       swapper_pg_dir + USER_PTRS_PER_PGD,
+		       (PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
+	}
+	return pgd;
+}
+
+static const pgprot_t protection_map[16] = {
+	[VM_NONE]					= PAGE_NONE,
+	[VM_READ]					= PAGE_READONLY,
+	[VM_WRITE]					= PAGE_COPY,
+	[VM_WRITE | VM_READ]				= PAGE_COPY,
+	[VM_EXEC]					= PAGE_READONLY,
+	[VM_EXEC | VM_READ]				= PAGE_READONLY,
+	[VM_EXEC | VM_WRITE]				= PAGE_COPY,
+	[VM_EXEC | VM_WRITE | VM_READ]			= PAGE_COPY,
+	[VM_SHARED]					= PAGE_NONE,
+	[VM_SHARED | VM_READ]				= PAGE_READONLY,
+	[VM_SHARED | VM_WRITE]				= PAGE_SHARED,
+	[VM_SHARED | VM_WRITE | VM_READ]		= PAGE_SHARED,
+	[VM_SHARED | VM_EXEC]				= PAGE_READONLY,
+	[VM_SHARED | VM_EXEC | VM_READ]			= PAGE_READONLY,
+	[VM_SHARED | VM_EXEC | VM_WRITE]		= PAGE_SHARED,
+	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= PAGE_SHARED
+};
+DECLARE_VM_GET_PAGE_PROT
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 39c4a7e21c6f..f3258680bfbe 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -6,7 +6,6 @@
 #include <linux/stddef.h>
 #include <linux/module.h>
 #include <linux/memblock.h>
-#include <linux/mm.h>
 #include <linux/swap.h>
 #include <linux/slab.h>
 #include <linux/init.h>
@@ -107,45 +106,11 @@ void free_initmem(void)
 {
 }
 
-/* Allocate and free page tables. */
-
-pgd_t *pgd_alloc(struct mm_struct *mm)
-{
-	pgd_t *pgd = __pgd_alloc(mm, 0);
-
-	if (pgd)
-		memcpy(pgd + USER_PTRS_PER_PGD,
-		       swapper_pg_dir + USER_PTRS_PER_PGD,
-		       (PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
-
-	return pgd;
-}
-
 void *uml_kmalloc(int size, int flags)
 {
 	return kmalloc(size, flags);
 }
 
-static const pgprot_t protection_map[16] = {
-	[VM_NONE]					= PAGE_NONE,
-	[VM_READ]					= PAGE_READONLY,
-	[VM_WRITE]					= PAGE_COPY,
-	[VM_WRITE | VM_READ]				= PAGE_COPY,
-	[VM_EXEC]					= PAGE_READONLY,
-	[VM_EXEC | VM_READ]				= PAGE_READONLY,
-	[VM_EXEC | VM_WRITE]				= PAGE_COPY,
-	[VM_EXEC | VM_WRITE | VM_READ]			= PAGE_COPY,
-	[VM_SHARED]					= PAGE_NONE,
-	[VM_SHARED | VM_READ]				= PAGE_READONLY,
-	[VM_SHARED | VM_WRITE]				= PAGE_SHARED,
-	[VM_SHARED | VM_WRITE | VM_READ]		= PAGE_SHARED,
-	[VM_SHARED | VM_EXEC]				= PAGE_READONLY,
-	[VM_SHARED | VM_EXEC | VM_READ]			= PAGE_READONLY,
-	[VM_SHARED | VM_EXEC | VM_WRITE]		= PAGE_SHARED,
-	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= PAGE_SHARED
-};
-DECLARE_VM_GET_PAGE_PROT
-
 void mark_rodata_ro(void)
 {
 	unsigned long rodata_start = PFN_ALIGN(__start_rodata);
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 63b38a3f73f7..b07c1f120910 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -25,6 +25,7 @@
 #include <linux/tick.h>
 #include <linux/threads.h>
 #include <linux/resume_user_mode.h>
+#include <linux/start_kernel.h>
 #include <asm/current.h>
 #include <asm/mmu_context.h>
 #include <asm/switch_to.h>
@@ -307,3 +308,40 @@ unsigned long __get_wchan(struct task_struct *p)
 
 	return 0;
 }
+
+extern void start_kernel(void);
+
+static int __init start_kernel_proc(void *unused)
+{
+	block_signals_trace();
+
+	start_kernel();
+	return 0;
+}
+
+char cpu_irqstacks[NR_CPUS][THREAD_SIZE] __aligned(THREAD_SIZE);
+
+int __init start_uml(void)
+{
+	stack_protections((unsigned long) &cpu_irqstacks[0]);
+	set_sigstack(cpu_irqstacks[0], THREAD_SIZE);
+
+	init_new_thread_signals();
+
+	init_task.thread.request.thread.proc = start_kernel_proc;
+	init_task.thread.request.thread.arg = NULL;
+	return start_idle_thread(task_stack_page(&init_task),
+				 &init_task.thread.switch_buf);
+}
+
+static DEFINE_SPINLOCK(initial_jmpbuf_spinlock);
+
+void initial_jmpbuf_lock(void)
+{
+	spin_lock_irq(&initial_jmpbuf_spinlock);
+}
+
+void initial_jmpbuf_unlock(void)
+{
+	spin_unlock_irq(&initial_jmpbuf_spinlock);
+}
diff --git a/arch/um/kernel/skas/process.c b/arch/um/kernel/skas/process.c
index 4a7673b0261a..d643854942bc 100644
--- a/arch/um/kernel/skas/process.c
+++ b/arch/um/kernel/skas/process.c
@@ -17,31 +17,6 @@
 #include <skas.h>
 #include <kern_util.h>
 
-extern void start_kernel(void);
-
-static int __init start_kernel_proc(void *unused)
-{
-	block_signals_trace();
-
-	start_kernel();
-	return 0;
-}
-
-char cpu_irqstacks[NR_CPUS][THREAD_SIZE] __aligned(THREAD_SIZE);
-
-int __init start_uml(void)
-{
-	stack_protections((unsigned long) &cpu_irqstacks[0]);
-	set_sigstack(cpu_irqstacks[0], THREAD_SIZE);
-
-	init_new_thread_signals();
-
-	init_task.thread.request.thread.proc = start_kernel_proc;
-	init_task.thread.request.thread.arg = NULL;
-	return start_idle_thread(task_stack_page(&init_task),
-				 &init_task.thread.switch_buf);
-}
-
 unsigned long current_stub_stack(void)
 {
 	if (current->mm == NULL)
@@ -65,15 +40,3 @@ void current_mm_sync(void)
 
 	um_tlb_sync(current->mm);
 }
-
-static DEFINE_SPINLOCK(initial_jmpbuf_spinlock);
-
-void initial_jmpbuf_lock(void)
-{
-	spin_lock_irq(&initial_jmpbuf_spinlock);
-}
-
-void initial_jmpbuf_unlock(void)
-{
-	spin_unlock_irq(&initial_jmpbuf_spinlock);
-}
diff --git a/arch/um/os-Linux/Makefile b/arch/um/os-Linux/Makefile
index f8d672d570d9..40e3e0eab6a0 100644
--- a/arch/um/os-Linux/Makefile
+++ b/arch/um/os-Linux/Makefile
@@ -8,7 +8,8 @@ KCOV_INSTRUMENT                := n
 
 obj-y = elf_aux.o execvp.o file.o helper.o irq.o main.o mem.o process.o \
 	registers.o sigio.o signal.o start_up.o time.o tty.o \
-	umid.o user_syms.o util.o skas/
+	umid.o user_syms.o util.o
+obj-$(CONFIG_MMU) += skas/
 
 CFLAGS_signal.o += -Wframe-larger-than=4096
 
diff --git a/arch/um/os-Linux/process.c b/arch/um/os-Linux/process.c
index 3a2a84ab9325..c50fa865d8c7 100644
--- a/arch/um/os-Linux/process.c
+++ b/arch/um/os-Linux/process.c
@@ -6,6 +6,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <stdbool.h>
 #include <unistd.h>
 #include <errno.h>
 #include <signal.h>
@@ -17,10 +18,16 @@
 #include <sys/prctl.h>
 #include <sys/wait.h>
 #include <asm/unistd.h>
+#include <linux/threads.h>
 #include <init.h>
 #include <longjmp.h>
 #include <os.h>
 #include <skas/skas.h>
+#include <as-layout.h>
+#include <kern_util.h>
+
+int using_seccomp;
+static int unscheduled_userspace_iterations;
 
 void os_alarm_process(int pid)
 {
@@ -209,3 +216,125 @@ int os_futex_wake(void *uaddr)
 				NULL, NULL, 0));
 	return r < 0 ? -errno : r;
 }
+
+int is_skas_winch(int pid, int fd, void *data)
+{
+	return pid == getpgrp();
+}
+
+void new_thread(void *stack, jmp_buf *buf, void (*handler)(void))
+{
+	(*buf)[0].JB_IP = (unsigned long) handler;
+	(*buf)[0].JB_SP = (unsigned long) stack + UM_THREAD_SIZE -
+		sizeof(void *);
+}
+
+#define INIT_JMP_NEW_THREAD 0
+#define INIT_JMP_CALLBACK 1
+#define INIT_JMP_HALT 2
+#define INIT_JMP_REBOOT 3
+
+void switch_threads(jmp_buf *me, jmp_buf *you)
+{
+	unscheduled_userspace_iterations = 0;
+
+	if (UML_SETJMP(me) == 0)
+		UML_LONGJMP(you, 1);
+}
+
+static jmp_buf initial_jmpbuf;
+
+static __thread void (*cb_proc)(void *arg);
+static __thread void *cb_arg;
+static __thread jmp_buf *cb_back;
+
+int start_idle_thread(void *stack, jmp_buf *switch_buf)
+{
+	int n;
+
+	set_handler(SIGWINCH);
+
+	/*
+	 * Can't use UML_SETJMP or UML_LONGJMP here because they save
+	 * and restore signals, with the possible side-effect of
+	 * trying to handle any signals which came when they were
+	 * blocked, which can't be done on this stack.
+	 * Signals must be blocked when jumping back here and restored
+	 * after returning to the jumper.
+	 */
+	n = setjmp(initial_jmpbuf);
+	switch (n) {
+	case INIT_JMP_NEW_THREAD:
+		(*switch_buf)[0].JB_IP = (unsigned long) uml_finishsetup;
+		(*switch_buf)[0].JB_SP = (unsigned long) stack +
+			UM_THREAD_SIZE - sizeof(void *);
+		break;
+	case INIT_JMP_CALLBACK:
+		(*cb_proc)(cb_arg);
+		longjmp(*cb_back, 1);
+		break;
+	case INIT_JMP_HALT:
+		kmalloc_ok = 0;
+		return 0;
+	case INIT_JMP_REBOOT:
+		kmalloc_ok = 0;
+		return 1;
+	default:
+		printk(UM_KERN_ERR "Bad sigsetjmp return in %s - %d\n",
+		       __func__, n);
+		fatal_sigsegv();
+	}
+	longjmp(*switch_buf, 1);
+
+	/* unreachable */
+	printk(UM_KERN_ERR "impossible long jump!");
+	fatal_sigsegv();
+	return 0;
+}
+
+void initial_thread_cb_skas(void (*proc)(void *), void *arg)
+{
+	jmp_buf here;
+
+	cb_proc = proc;
+	cb_arg = arg;
+	cb_back = &here;
+
+	initial_jmpbuf_lock();
+	if (UML_SETJMP(&here) == 0)
+		UML_LONGJMP(&initial_jmpbuf, INIT_JMP_CALLBACK);
+	initial_jmpbuf_unlock();
+
+	cb_proc = NULL;
+	cb_arg = NULL;
+	cb_back = NULL;
+}
+
+void halt_skas(void)
+{
+	initial_jmpbuf_lock();
+	UML_LONGJMP(&initial_jmpbuf, INIT_JMP_HALT);
+	/* unreachable */
+}
+
+static bool noreboot;
+
+static int __init noreboot_cmd_param(char *str, int *add)
+{
+	*add = 0;
+	noreboot = true;
+	return 0;
+}
+
+__uml_setup("noreboot", noreboot_cmd_param,
+"noreboot\n"
+"    Rather than rebooting, exit always, akin to QEMU's -no-reboot option.\n"
+"    This is useful if you're using CONFIG_PANIC_TIMEOUT in order to catch\n"
+"    crashes in CI\n\n");
+
+void reboot_skas(void)
+{
+	initial_jmpbuf_lock();
+	UML_LONGJMP(&initial_jmpbuf, noreboot ? INIT_JMP_HALT : INIT_JMP_REBOOT);
+	/* unreachable */
+}
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index d6c22f8aa06d..01814ad82f5d 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -18,7 +18,6 @@
 #include <sys/stat.h>
 #include <sys/socket.h>
 #include <asm/unistd.h>
-#include <as-layout.h>
 #include <init.h>
 #include <kern_util.h>
 #include <mem.h>
@@ -29,16 +28,10 @@
 #include <sysdep/stub.h>
 #include <sysdep/mcontext.h>
 #include <linux/futex.h>
-#include <linux/threads.h>
 #include <timetravel.h>
 #include <asm-generic/rwonce.h>
 #include "../internal.h"
 
-int is_skas_winch(int pid, int fd, void *data)
-{
-	return pid == getpgrp();
-}
-
 static const char *ptrace_reg_name(int idx)
 {
 #define R(n) case HOST_##n: return #n
@@ -426,8 +419,6 @@ static int __init init_stub_exe_fd(void)
 }
 __initcall(init_stub_exe_fd);
 
-int using_seccomp;
-
 /**
  * start_userspace() - prepare a new userspace process
  * @mm_id: The corresponding struct mm_id
@@ -540,7 +531,6 @@ int start_userspace(struct mm_id *mm_id)
 	return err;
 }
 
-static int unscheduled_userspace_iterations;
 extern unsigned long tt_extra_sched_jiffies;
 
 void userspace(struct uml_pt_regs *regs)
@@ -789,120 +779,3 @@ void userspace(struct uml_pt_regs *regs)
 		}
 	}
 }
-
-void new_thread(void *stack, jmp_buf *buf, void (*handler)(void))
-{
-	(*buf)[0].JB_IP = (unsigned long) handler;
-	(*buf)[0].JB_SP = (unsigned long) stack + UM_THREAD_SIZE -
-		sizeof(void *);
-}
-
-#define INIT_JMP_NEW_THREAD 0
-#define INIT_JMP_CALLBACK 1
-#define INIT_JMP_HALT 2
-#define INIT_JMP_REBOOT 3
-
-void switch_threads(jmp_buf *me, jmp_buf *you)
-{
-	unscheduled_userspace_iterations = 0;
-
-	if (UML_SETJMP(me) == 0)
-		UML_LONGJMP(you, 1);
-}
-
-static jmp_buf initial_jmpbuf;
-
-static __thread void (*cb_proc)(void *arg);
-static __thread void *cb_arg;
-static __thread jmp_buf *cb_back;
-
-int start_idle_thread(void *stack, jmp_buf *switch_buf)
-{
-	int n;
-
-	set_handler(SIGWINCH);
-
-	/*
-	 * Can't use UML_SETJMP or UML_LONGJMP here because they save
-	 * and restore signals, with the possible side-effect of
-	 * trying to handle any signals which came when they were
-	 * blocked, which can't be done on this stack.
-	 * Signals must be blocked when jumping back here and restored
-	 * after returning to the jumper.
-	 */
-	n = setjmp(initial_jmpbuf);
-	switch (n) {
-	case INIT_JMP_NEW_THREAD:
-		(*switch_buf)[0].JB_IP = (unsigned long) uml_finishsetup;
-		(*switch_buf)[0].JB_SP = (unsigned long) stack +
-			UM_THREAD_SIZE - sizeof(void *);
-		break;
-	case INIT_JMP_CALLBACK:
-		(*cb_proc)(cb_arg);
-		longjmp(*cb_back, 1);
-		break;
-	case INIT_JMP_HALT:
-		kmalloc_ok = 0;
-		return 0;
-	case INIT_JMP_REBOOT:
-		kmalloc_ok = 0;
-		return 1;
-	default:
-		printk(UM_KERN_ERR "Bad sigsetjmp return in %s - %d\n",
-		       __func__, n);
-		fatal_sigsegv();
-	}
-	longjmp(*switch_buf, 1);
-
-	/* unreachable */
-	printk(UM_KERN_ERR "impossible long jump!");
-	fatal_sigsegv();
-	return 0;
-}
-
-void initial_thread_cb_skas(void (*proc)(void *), void *arg)
-{
-	jmp_buf here;
-
-	cb_proc = proc;
-	cb_arg = arg;
-	cb_back = &here;
-
-	initial_jmpbuf_lock();
-	if (UML_SETJMP(&here) == 0)
-		UML_LONGJMP(&initial_jmpbuf, INIT_JMP_CALLBACK);
-	initial_jmpbuf_unlock();
-
-	cb_proc = NULL;
-	cb_arg = NULL;
-	cb_back = NULL;
-}
-
-void halt_skas(void)
-{
-	initial_jmpbuf_lock();
-	UML_LONGJMP(&initial_jmpbuf, INIT_JMP_HALT);
-	/* unreachable */
-}
-
-static bool noreboot;
-
-static int __init noreboot_cmd_param(char *str, int *add)
-{
-	*add = 0;
-	noreboot = true;
-	return 0;
-}
-
-__uml_setup("noreboot", noreboot_cmd_param,
-"noreboot\n"
-"    Rather than rebooting, exit always, akin to QEMU's -no-reboot option.\n"
-"    This is useful if you're using CONFIG_PANIC_TIMEOUT in order to catch\n"
-"    crashes in CI\n\n");
-
-void reboot_skas(void)
-{
-	initial_jmpbuf_lock();
-	UML_LONGJMP(&initial_jmpbuf, noreboot ? INIT_JMP_HALT : INIT_JMP_REBOOT);
-	/* unreachable */
-}
-- 
2.43.0


