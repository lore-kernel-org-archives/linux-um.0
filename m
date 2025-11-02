Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F9E1CCFA06
	for <linux-um@archiver.kernel.org>; Sun,  2 Nov 2025 09:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w5g26G/COfPvrLkIRmt5b7hYWmBBdOf28rjYEzX22+c=; b=24MPMVTnYTvnvv7+NZH5nTXQTk
	fNfZwH6XRGMIKqPAK1xf9Qf36wj3trCrfiLFC63AD1kZPpSi9qIbkdljorRWbCFulOW9OdQluCmiI
	y6JLrdlPbv+R9HrWLepSW2qwQzmQ4DAUs+pZ8zHyZ93MEvDhXX6Zuy4YjDhXyZmkTrGFlPW+9Zhnr
	Td5gMOB6iedVveiS0KOsnuJHGrpS+2sVPH7qO9/1gYKHHTkPY6ZJOvKg5yyeR7u02Ob+xNXZePwBe
	bdTqRtQMcwFQMg0N7L4IgmKHGPbUc2WomUGVPgbbGPuU0p26M8pcnAgiW0fu+BPg5JNlcRrppIk/r
	VM7ARI2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFUii-00000008RnC-0238;
	Sun, 02 Nov 2025 09:49:56 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFUif-00000008Rlj-1Df8
	for linux-um@lists.infradead.org;
	Sun, 02 Nov 2025 09:49:54 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-294fb21b068so40003125ad.1
        for <linux-um@lists.infradead.org>; Sun, 02 Nov 2025 01:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762076992; x=1762681792; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5g26G/COfPvrLkIRmt5b7hYWmBBdOf28rjYEzX22+c=;
        b=k2etDjU7/FsHyz/r0KExZG7w1rmu0RO1/S96Ivezk0H6+t0C2ps3OkXETZXJHUfEdw
         w0H2ZG9F5IZfCDSSZUCNMxFxcxriI96ceVeEegGw3zpE9dqbAr0a4Oly/qLhGAYdvD8d
         O8gj9OcmofSiPoI1djJNryaZM9k3FNv26vy5AXUJt0arn/HOWgwegarlgCQk8735DREY
         clfePjZ4rMUuuFdAjW3Ki3S+QItQ2phQBbbewiGEAsqsyxTa+lNuWiH9cCVCloIqwDUz
         zF0Xr5RIYXgp+KiWAjPdme9DdaUGwjYHt1eFt8Nf+ysBW105a0xrhzZuOOGlkTm8siMJ
         I3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762076992; x=1762681792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w5g26G/COfPvrLkIRmt5b7hYWmBBdOf28rjYEzX22+c=;
        b=s7HXIkawmFwaWdeUi7lVMlIxAbvKL4NQP+rR6YFw8TrHWRkL0FVCeEl2mjkn9Mvt4Z
         x09gfn8jewXmMr/araQrVGI9iwvDRFkcqkCdvagdx/WUmYHZsq1STdPmziH/42MDuj0v
         uzNPuADjM+7H4j+fU2E8nwLTzzXQP6gVCjUveaeJiM5snkwkT2gF5Hb5+AD8cm3/tWCb
         Vab5IXzItUrllUh8KLO2i/6T4Gh6dPu6C0N/JmFnCUuNJQuv2tAOghw2XZ+eIV5t0U6S
         KpJNp9LF9u48EXOybvSEKyF1xak/6+Xnlnz4M6eXPwEH8TL2OVjb2PiY7ySRI5yxmQ3B
         nzkA==
X-Gm-Message-State: AOJu0Yz69M0Tg+NRpUQcJc+lwk5pteJgKWghuxIdCCZgvF6nOd0gLOGw
	uhQPXZ+nZe0CRSXaefNEn4uyeT3THCp/IimVGrMcopEPnDwchsL2DhxF
X-Gm-Gg: ASbGncvzvwxW1lo1OKUHUw6qxEo06kxikLWFB96oM/O75BjBtqGaT8zit1GJjwSlq9q
	EnNubOXu6/Fw25liyU2zHA9OFk1UW4mREM3EazKHOsLZVB+mY2VGxqF5Bo7ENV8JMQ1/O/kH126
	7w/4LY3s7FKOO9QRvZpnLs1fcrgZ02fjhc/1mmrupho+vfyvD57NoDzbIrbjBn8GhVin0ArFndD
	9Qj4KuciCmchNGdRaRUcPDXeSHZCsoMJuVfyPwE9ZIttv9CLmP7yEmelmL0sV5SP78Vt9HcsgS+
	mlE0drVx9xJLO1IeCItPEoLN3lyVqfXmrWCZnUyl72is15PrXvIR1HVfT25YmBSu/egRHUJTv+I
	kMA22km4RMKixHPo0Gv+iE9zFs23TgWyJFEcmNRrzv0qN5bfyDr59JS97jFVAND8jCdRT4H9VGK
	tRISOzpcz3CVCePIUPTsx337iFPrXfVrnP1mVa455AMlBtpA==
X-Google-Smtp-Source: AGHT+IE4ZJuOJv/lZZjeLKVBUjHez5Y01sXUDedOJUP9w8GA2DbzhYNRv1LwyZd82LKqaI0ufh3+IQ==
X-Received: by 2002:a17:902:d2d0:b0:295:49ab:3593 with SMTP id d9443c01a7336-29549ab53edmr87061675ad.29.1762076992361;
        Sun, 02 Nov 2025 01:49:52 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29554cba950sm50950775ad.97.2025.11.02.01.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 01:49:50 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id AAAAD1123801; Sun,  2 Nov 2025 18:49:44 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v12 02/13] um: decouple MMU specific code from the common part
Date: Sun,  2 Nov 2025 18:49:27 +0900
Message-ID: <08489faaad68a17037e1f24b2a39d8fc3b021c61.1762075876.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762075876.git.thehajime@gmail.com>
References: <cover.1762075876.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251102_014953_374492_F20FEF2B 
X-CRM114-Status: GOOD (  22.13  )
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
index dc938715ec9d..52cd906e3896 100644
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
@@ -214,45 +213,11 @@ void free_initmem(void)
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
index 70c73c22f715..051679d78aae 100644
--- a/arch/um/os-Linux/Makefile
+++ b/arch/um/os-Linux/Makefile
@@ -8,7 +8,8 @@ KCOV_INSTRUMENT                := n
 
 obj-y = execvp.o file.o helper.o irq.o main.o mem.o process.o \
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


