Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E937C4332F
	for <linux-um@archiver.kernel.org>; Tue, 22 Nov 2022 10:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XL/gNVrLjqwbYNG+Xs8wF90+JvthMwjuy4MC0G5FleY=; b=cp55DE8ggUc3KY
	AwPTFQkBRjfkbkoeiHhJrNut6gocXuWEvUdkwj9wQEmM9feWeIJQJ1yMvszbbJF711saEWqam0mtP
	ls3ruZS9u+RjfFYXk+4spzdHNbjBpcXadGgzBH/09xDHJXd3lDhXeLb6vVm3ViEA1FjO1CiYkxDcR
	AcRGpevx3tK/AZKA4XBPmWkuRGY/LXSVQfWZZwB4joWVEfoKdFItFVMI+hWlwO13vf/MwhDuf8fjf
	jxPvdsPO4j1AWMUFLVqrheCHZR0eig6Jmt5QZsj4hEaMQVCTlUfuOOdLkPOJZy/ld6nMEAc40OORY
	s3G91YSsRzVVduMgYdaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQUd-007o5c-Og; Tue, 22 Nov 2022 10:27:07 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQTM-007nKg-Rw
	for linux-um@bombadil.infradead.org; Tue, 22 Nov 2022 10:25:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=3lJJDAv/JxGQR41iia2ptwBV555w9SpozAvbIjZ9Q2o=; b=MgPrzW2NUPH4V++2PDzQbdh6kc
	p80tkP1xf9mHRXLUhqJKP6tIZBnwT8oKIa8a76JZ1ukQW9XimR4H5oqDR50jVqrOioicIVnodUZnM
	dYqRteS74ULDAFxmNzWfwmA1fDN8MCXMA+1xfNE2YlpYmPc2KZQPX9q0V9ebyG7WE2ku+OErz6SWD
	LxNmS05kpeLpR1h6PgTEmTSeKw3vskGbrnDXesUeiRg3QShnvbM3fe7oO9OFdheFAlb5AWmxT683j
	4wxQWSDb6UTowzY5MoVtEtcjPhOIVeAMNqGLdMZSh3pKQnYmIjp04ppYxdGlTh4fzRHvL/0U8GPJ0
	uFMX1w1Q==;
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQF1-003P1p-1J
	for linux-um@lists.infradead.org; Tue, 22 Nov 2022 10:11:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=3lJJDAv/JxGQR41iia2ptwBV555w9SpozAvbIjZ9Q2o=;
	t=1669111858; x=1670321458; b=MYZJFx5JcNlqMrybRZ8ilRCduadtbmu0WvhUySuV0fXy0E0
	A8gdL47kTDtb10er949iHkBYsESvEOdUELldAoKUORNMhCsj4SgnLBbyyvTLISEFaz80Ud5es0M9J
	9IH3HZ38QNGQJZ5667gyQvGGHdRzWQsmzjy6VZMxeHtjW/KP1hdh5hpgHGhDowI+/98yUOWPXSmE1
	Y1VkBFE5di2vuZtvQxzlJccg9zcfafmqO+8k0KUI0A67eJNzb+LynQHHOlmqme208AxAuXPXpbi2j
	/RO+wk3uC8j3umeMxZU140RvnJI1qYuhpkVobBtab4f28AiUoPvlpyXc35stE7Hg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1oxQEq-006IGn-1B;
	Tue, 22 Nov 2022 11:10:48 +0100
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH v2 17/28] um: Rework syscall handling
Date: Tue, 22 Nov 2022 11:07:48 +0100
Message-Id: <20221122100759.208290-18-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221122100759.208290-1-benjamin@sipsolutions.net>
References: <20221122100759.208290-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_101059_599220_8BBBA5BF 
X-CRM114-Status: GOOD (  33.39  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

From: Benjamin Berg <benjamin@sipsolutions.net>

Rework syscall handling to be platform independent. Also create a clean
split between queueing of syscalls and flushing them out, removing the
need to keep state in the code that triggers the syscalls.

The code adds syscall_data_len to the global mm_id structure. This will
be used later to allow surrounding code to track whether syscalls still
need to run and if errors occurred.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
---
 arch/um/include/shared/os.h             |  24 ++-
 arch/um/include/shared/skas/mm_id.h     |   1 +
 arch/um/include/shared/skas/stub-data.h |  14 +-
 arch/um/include/shared/user.h           |   8 +
 arch/um/kernel/exec.c                   |  10 +-
 arch/um/kernel/skas/Makefile            |   4 +-
 arch/um/kernel/skas/clone.c             |   2 +-
 arch/um/kernel/skas/stub.c              |  47 +++++
 arch/um/kernel/tlb.c                    |  42 ++---
 arch/um/os-Linux/skas/mem.c             | 241 +++++++++++++-----------
 arch/um/os-Linux/skas/process.c         |   4 +-
 arch/x86/um/Makefile                    |   2 +-
 arch/x86/um/ldt.c                       |  47 ++---
 arch/x86/um/shared/sysdep/stub.h        |   1 +
 arch/x86/um/stub_32.S                   |  56 ------
 arch/x86/um/stub_64.S                   |  50 -----
 16 files changed, 259 insertions(+), 294 deletions(-)
 create mode 100644 arch/um/kernel/skas/stub.c
 delete mode 100644 arch/x86/um/stub_32.S
 delete mode 100644 arch/x86/um/stub_64.S

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index aff8906304ea..22ea525165b7 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -268,19 +268,17 @@ extern long long os_persistent_clock_emulation(void);
 extern long long os_nsecs(void);
 
 /* skas/mem.c */
-extern long run_syscall_stub(struct mm_id * mm_idp,
-			     int syscall, unsigned long *args, long expected,
-			     void **addr, int done);
-extern long syscall_stub_data(struct mm_id * mm_idp,
-			      unsigned long *data, int data_count,
-			      void **addr, void **stub_addr);
-extern int map(struct mm_id * mm_idp, unsigned long virt,
-	       unsigned long len, int prot, int phys_fd,
-	       unsigned long long offset, int done, void **data);
-extern int unmap(struct mm_id * mm_idp, unsigned long addr, unsigned long len,
-		 int done, void **data);
-extern int protect(struct mm_id * mm_idp, unsigned long addr,
-		   unsigned long len, unsigned int prot, int done, void **data);
+int syscall_stub_flush(struct mm_id *mm_idp);
+struct stub_syscall *syscall_stub_alloc(struct mm_id *mm_idp,
+					unsigned long data_len,
+					unsigned long *data_addr);
+
+void map(struct mm_id *mm_idp, unsigned long virt,
+	 unsigned long len, int prot, int phys_fd,
+	 unsigned long long offset);
+void unmap(struct mm_id *mm_idp, unsigned long addr, unsigned long len);
+void protect(struct mm_id *mm_idp, unsigned long addr,
+	     unsigned long len, unsigned int prot);
 
 /* skas/process.c */
 extern int is_skas_winch(int pid, int fd, void *data);
diff --git a/arch/um/include/shared/skas/mm_id.h b/arch/um/include/shared/skas/mm_id.h
index e82e203f5f41..bcb951719b51 100644
--- a/arch/um/include/shared/skas/mm_id.h
+++ b/arch/um/include/shared/skas/mm_id.h
@@ -13,6 +13,7 @@ struct mm_id {
 	} u;
 	unsigned long stack;
 	int kill;
+	int syscall_data_len;
 };
 
 #endif
diff --git a/arch/um/include/shared/skas/stub-data.h b/arch/um/include/shared/skas/stub-data.h
index 3281809a7272..821c1e98c051 100644
--- a/arch/um/include/shared/skas/stub-data.h
+++ b/arch/um/include/shared/skas/stub-data.h
@@ -11,11 +11,23 @@
 #include <linux/compiler_types.h>
 #include <as-layout.h>
 
+#define STUB_NEXT_SYSCALL(s) \
+	((struct stub_syscall *) (((unsigned long) s) + (s)->cmd_len))
+
+struct stub_syscall {
+	long syscall;
+	int cmd_len;
+	long expected_result;
+	long arg[6];
+	long data[];
+};
+
 struct stub_data {
 	unsigned long offset;
 	int fd;
-	long parent_err, child_err;
+	long err, child_err;
 
+	int syscall_data_len;
 	/* 128 leaves enough room for additional fields in the struct */
 	unsigned char syscall_data[UM_KERN_PAGE_SIZE - 128] __aligned(16);
 
diff --git a/arch/um/include/shared/user.h b/arch/um/include/shared/user.h
index bda66e5a9d4e..ee9e5ac45d02 100644
--- a/arch/um/include/shared/user.h
+++ b/arch/um/include/shared/user.h
@@ -42,11 +42,19 @@ extern void panic(const char *fmt, ...)
 #define printk(...) _printk(__VA_ARGS__)
 extern int _printk(const char *fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
+extern void print_hex_dump(const char *level, const char *prefix_str,
+			   int prefix_type, int rowsize, int groupsize,
+			   const void *buf, size_t len, _Bool ascii);
 #else
 static inline int printk(const char *fmt, ...)
 {
 	return 0;
 }
+static inline void print_hex_dump(const char *level, const char *prefix_str,
+				  int prefix_type, int rowsize, int groupsize,
+				  const void *buf, size_t len, _Bool ascii)
+{
+}
 #endif
 
 extern int in_aton(char *str);
diff --git a/arch/um/kernel/exec.c b/arch/um/kernel/exec.c
index 827a0d3fa589..5c8836b012e9 100644
--- a/arch/um/kernel/exec.c
+++ b/arch/um/kernel/exec.c
@@ -22,15 +22,11 @@
 
 void flush_thread(void)
 {
-	void *data = NULL;
-	int ret;
-
 	arch_flush_thread(&current->thread.arch);
 
-	ret = unmap(&current->mm->context.id, 0, TASK_SIZE, 1, &data);
-	if (ret) {
-		printk(KERN_ERR "%s - clearing address space failed, err = %d\n",
-		       __func__, ret);
+	unmap(&current->mm->context.id, 0, TASK_SIZE);
+	if (syscall_stub_flush(&current->mm->context.id) < 0) {
+		printk(KERN_ERR "%s - clearing address space failed", __func__);
 		force_sig(SIGKILL);
 	}
 	get_safe_registers(current_pt_regs()->regs.gp,
diff --git a/arch/um/kernel/skas/Makefile b/arch/um/kernel/skas/Makefile
index f3d494a4fd9b..a863638cc1f0 100644
--- a/arch/um/kernel/skas/Makefile
+++ b/arch/um/kernel/skas/Makefile
@@ -3,14 +3,14 @@
 # Copyright (C) 2002 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
 #
 
-obj-y := clone.o mmu.o process.o syscall.o uaccess.o
+obj-y := clone.o stub.o mmu.o process.o syscall.o uaccess.o
 
 # clone.o is in the stub, so it can't be built with profiling
 # GCC hardened also auto-enables -fpic, but we need %ebx so it can't work ->
 # disable it
 
 CFLAGS_clone.o := $(CFLAGS_NO_HARDENING)
-UNPROFILE_OBJS := clone.o
+UNPROFILE_OBJS := clone.o stub.o
 
 KCOV_INSTRUMENT := n
 
diff --git a/arch/um/kernel/skas/clone.c b/arch/um/kernel/skas/clone.c
index a631566e4a20..8b6ea9c00133 100644
--- a/arch/um/kernel/skas/clone.c
+++ b/arch/um/kernel/skas/clone.c
@@ -33,7 +33,7 @@ stub_clone_handler(void)
 					    sizeof(data->syscall_data) / 2 -
 					    sizeof(void *));
 	if (err) {
-		data->parent_err = err;
+		data->err = err;
 		goto done;
 	}
 
diff --git a/arch/um/kernel/skas/stub.c b/arch/um/kernel/skas/stub.c
new file mode 100644
index 000000000000..0a13f5d21d08
--- /dev/null
+++ b/arch/um/kernel/skas/stub.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Benjamin Berg <benjamin@sipsolutions.net>
+ */
+
+#include <sysdep/stub.h>
+
+static __always_inline int syscall_handler(struct stub_data *d)
+{
+	struct stub_syscall *sc;
+	long ret;
+
+	for (sc = (void *)&d->syscall_data;
+	     (unsigned long)sc - (unsigned long)d->syscall_data < d->syscall_data_len;
+	     sc = STUB_NEXT_SYSCALL(sc)) {
+		ret = stub_syscall6(sc->syscall,
+				    sc->arg[0], sc->arg[1], sc->arg[2],
+				    sc->arg[3], sc->arg[4], sc->arg[5]);
+
+		/*
+		 * If there was an error, then set d->err and set
+		 * d->syscall_data_len to point to the failed syscall.
+		 */
+		if (ret != sc->expected_result) {
+			d->err = ret;
+			d->syscall_data_len = (unsigned long)sc -
+					      (unsigned long)d->syscall_data;
+
+			return -1;
+		}
+	}
+
+	d->err = 0;
+	d->syscall_data_len = 0;
+
+	return 0;
+}
+
+void __section(".__syscall_stub")
+stub_syscall_handler(void)
+{
+	struct stub_data *d = get_stub_page();
+
+	syscall_handler(d);
+
+	trap_myself();
+}
diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index 3c709e6146dc..c15cac380fcd 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -70,21 +70,19 @@ static int do_ops(struct host_vm_change *hvc, int end,
 		switch (op->type) {
 		case MMAP:
 			if (hvc->userspace)
-				ret = map(&hvc->mm->context.id, op->u.mmap.addr,
-					  op->u.mmap.len, op->u.mmap.prot,
-					  op->u.mmap.fd,
-					  op->u.mmap.offset, finished,
-					  &hvc->data);
+				map(&hvc->mm->context.id, op->u.mmap.addr,
+				    op->u.mmap.len, op->u.mmap.prot,
+				    op->u.mmap.fd,
+				    op->u.mmap.offset);
 			else
 				map_memory(op->u.mmap.addr, op->u.mmap.offset,
 					   op->u.mmap.len, 1, 1, 1);
 			break;
 		case MUNMAP:
 			if (hvc->userspace)
-				ret = unmap(&hvc->mm->context.id,
-					    op->u.munmap.addr,
-					    op->u.munmap.len, finished,
-					    &hvc->data);
+				unmap(&hvc->mm->context.id,
+				      op->u.munmap.addr,
+				      op->u.munmap.len);
 			else
 				ret = os_unmap_memory(
 					(void *) op->u.munmap.addr,
@@ -93,11 +91,10 @@ static int do_ops(struct host_vm_change *hvc, int end,
 			break;
 		case MPROTECT:
 			if (hvc->userspace)
-				ret = protect(&hvc->mm->context.id,
-					      op->u.mprotect.addr,
-					      op->u.mprotect.len,
-					      op->u.mprotect.prot,
-					      finished, &hvc->data);
+				protect(&hvc->mm->context.id,
+					op->u.mprotect.addr,
+					op->u.mprotect.len,
+					op->u.mprotect.prot);
 			else
 				ret = os_protect_memory(
 					(void *) op->u.mprotect.addr,
@@ -112,6 +109,9 @@ static int do_ops(struct host_vm_change *hvc, int end,
 		}
 	}
 
+	if (hvc->userspace && finished)
+		ret = syscall_stub_flush(&hvc->mm->context.id);
+
 	if (ret == -ENOMEM)
 		report_enomem();
 
@@ -460,7 +460,6 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long address)
 	pmd_t *pmd;
 	pte_t *pte;
 	struct mm_struct *mm = vma->vm_mm;
-	void *flush = NULL;
 	int r, w, x, prot, err = 0;
 	struct mm_id *mm_id;
 
@@ -503,14 +502,13 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long address)
 			int fd;
 
 			fd = phys_mapping(pte_val(*pte) & PAGE_MASK, &offset);
-			err = map(mm_id, address, PAGE_SIZE, prot, fd, offset,
-				  1, &flush);
-		}
-		else err = unmap(mm_id, address, PAGE_SIZE, 1, &flush);
-	}
-	else if (pte_newprot(*pte))
-		err = protect(mm_id, address, PAGE_SIZE, prot, 1, &flush);
+			map(mm_id, address, PAGE_SIZE, prot, fd, offset);
+		} else
+			unmap(mm_id, address, PAGE_SIZE);
+	} else if (pte_newprot(*pte))
+		protect(mm_id, address, PAGE_SIZE, prot);
 
+	err = syscall_stub_flush(mm_id);
 	if (err) {
 		if (err == -ENOMEM)
 			report_enomem();
diff --git a/arch/um/os-Linux/skas/mem.c b/arch/um/os-Linux/skas/mem.c
index 953fb10f3f93..28e50349ab91 100644
--- a/arch/um/os-Linux/skas/mem.c
+++ b/arch/um/os-Linux/skas/mem.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
+ * Copyright (C) 2021 Benjamin Berg <benjamin@sipsolutions.net>
  * Copyright (C) 2002 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  */
 
@@ -18,11 +19,11 @@
 #include <sysdep/ptrace.h>
 #include <sysdep/stub.h>
 
-extern char batch_syscall_stub[], __syscall_stub_start[];
+extern char __syscall_stub_start[];
 
 extern void wait_stub_done(int pid);
 
-static inline unsigned long *check_init_stack(struct mm_id * mm_idp,
+static inline unsigned long *check_init_stack(struct mm_id *mm_idp,
 					      unsigned long *stack)
 {
 	if (stack == NULL) {
@@ -37,22 +38,24 @@ static unsigned long syscall_regs[MAX_REG_NR];
 static int __init init_syscall_regs(void)
 {
 	get_safe_registers(syscall_regs, NULL);
+
 	syscall_regs[REGS_IP_INDEX] = STUB_CODE +
-		((unsigned long) batch_syscall_stub -
+		((unsigned long) stub_syscall_handler -
 		 (unsigned long) __syscall_stub_start);
-	syscall_regs[REGS_SP_INDEX] = STUB_DATA;
+	syscall_regs[REGS_SP_INDEX] = STUB_DATA +
+		offsetof(struct stub_data, sigstack) +
+		sizeof(((struct stub_data *) 0)->sigstack) -
+		sizeof(void *);
 
 	return 0;
 }
 
 __initcall(init_syscall_regs);
 
-static inline long do_syscall_stub(struct mm_id * mm_idp, void **addr)
+static inline long do_syscall_stub(struct mm_id *mm_idp)
 {
+	struct stub_data *proc_data = (void *)mm_idp->stack;
 	int n, i;
-	long ret, offset;
-	unsigned long * data;
-	unsigned long * syscall;
 	int err, pid = mm_idp->u.pid;
 
 	n = ptrace_setregs(pid, syscall_regs);
@@ -64,6 +67,9 @@ static inline long do_syscall_stub(struct mm_id * mm_idp, void **addr)
 		      __func__, -n);
 	}
 
+	/* Inform process how much we have filled in. */
+	proc_data->syscall_data_len = mm_idp->syscall_data_len;
+
 	err = ptrace(PTRACE_CONT, pid, 0, 0);
 	if (err)
 		panic("Failed to continue stub, pid = %d, errno = %d\n", pid,
@@ -72,135 +78,148 @@ static inline long do_syscall_stub(struct mm_id * mm_idp, void **addr)
 	wait_stub_done(pid);
 
 	/*
-	 * When the stub stops, we find the following values on the
-	 * beginning of the stack:
-	 * (long )return_value
-	 * (long )offset to failed sycall-data (0, if no error)
+	 * proc_data->err will be non-zero if there was an (unexpected) error.
+	 * In that case, syscall_data_len points to the last executed syscall,
+	 * otherwise it will be zero (but we do not need to rely on that).
 	 */
-	ret = *((unsigned long *) mm_idp->stack);
-	offset = *((unsigned long *) mm_idp->stack + 1);
-	if (offset) {
-		data = (unsigned long *)(mm_idp->stack + offset - STUB_DATA);
-		printk(UM_KERN_ERR "%s : ret = %ld, offset = %ld, data = %p\n",
-		       __func__, ret, offset, data);
-		syscall = (unsigned long *)((unsigned long)data + data[0]);
-		printk(UM_KERN_ERR "%s: syscall %ld failed, return value = 0x%lx, expected return value = 0x%lx\n",
-		       __func__, syscall[0], ret, syscall[7]);
+	if (proc_data->err) {
+		struct stub_syscall *sc;
+
+		if (proc_data->syscall_data_len < 0 ||
+		    proc_data->syscall_data_len > (long) mm_idp->syscall_data_len - sizeof(*sc))
+			panic("Syscall data was corrupted by stub (len is: %d, expected maximum: %d)!",
+			      proc_data->syscall_data_len,
+			      mm_idp->syscall_data_len);
+
+		sc = (void *) (((unsigned long) &proc_data->syscall_data) +
+			       proc_data->syscall_data_len);
+
+		printk(UM_KERN_ERR "%s : length = %d, last offset = %d",
+		       __func__, mm_idp->syscall_data_len,
+		       proc_data->syscall_data_len);
+		printk(UM_KERN_ERR "%s : syscall %ld failed, return value = 0x%lx, expected return value = 0x%lx\n",
+		       __func__, sc->syscall, proc_data->err,
+		       sc->expected_result);
+
 		printk(UM_KERN_ERR "    syscall parameters: 0x%lx 0x%lx 0x%lx 0x%lx 0x%lx 0x%lx\n",
-		       syscall[1], syscall[2], syscall[3],
-		       syscall[4], syscall[5], syscall[6]);
-		for (n = 1; n < data[0]/sizeof(long); n++) {
-			if (n == 1)
-				printk(UM_KERN_ERR "    additional syscall data:");
-			if (n % 4 == 1)
-				printk("\n" UM_KERN_ERR "      ");
-			printk("  0x%lx", data[n]);
+		       sc->arg[0], sc->arg[1], sc->arg[2],
+		       sc->arg[3], sc->arg[4], sc->arg[5]);
+
+		n = sc->cmd_len - sizeof(*sc);
+		if (n > 0) {
+			printk(UM_KERN_ERR "    syscall data 0x%lx + %d",
+			       STUB_DATA + ((unsigned long) (&sc->data) &
+					    (UM_KERN_PAGE_SIZE - 1)),
+			       n);
+			print_hex_dump(UM_KERN_ERR,
+				       "    syscall data: ", 0,
+				       16, 4, sc->data, n, 0);
 		}
-		if (n > 1)
-			printk("\n");
-	}
-	else ret = 0;
 
-	*addr = check_init_stack(mm_idp, NULL);
+		/* Store error code in case someone tries to add more syscalls */
+		mm_idp->syscall_data_len = proc_data->err;
+	} else {
+		mm_idp->syscall_data_len = 0;
+	}
 
-	return ret;
+	return mm_idp->syscall_data_len;
 }
 
-long run_syscall_stub(struct mm_id * mm_idp, int syscall,
-		      unsigned long *args, long expected, void **addr,
-		      int done)
+int syscall_stub_flush(struct mm_id *mm_idp)
 {
-	unsigned long *stack = check_init_stack(mm_idp, *addr);
-
-	*stack += sizeof(long);
-	stack += *stack / sizeof(long);
-
-	*stack++ = syscall;
-	*stack++ = args[0];
-	*stack++ = args[1];
-	*stack++ = args[2];
-	*stack++ = args[3];
-	*stack++ = args[4];
-	*stack++ = args[5];
-	*stack++ = expected;
-	*stack = 0;
-
-	if (!done && ((((unsigned long) stack) & ~UM_KERN_PAGE_MASK) <
-		     UM_KERN_PAGE_SIZE - 10 * sizeof(long))) {
-		*addr = stack;
+	int res;
+
+	if (mm_idp->syscall_data_len == 0)
 		return 0;
+
+	/* If an error happened already, report it and reset the state. */
+	if (mm_idp->syscall_data_len < 0) {
+		res = mm_idp->syscall_data_len;
+		mm_idp->syscall_data_len = 0;
+		return res;
 	}
 
-	return do_syscall_stub(mm_idp, addr);
+	res = do_syscall_stub(mm_idp);
+	mm_idp->syscall_data_len = 0;
+
+	return res;
 }
 
-long syscall_stub_data(struct mm_id * mm_idp,
-		       unsigned long *data, int data_count,
-		       void **addr, void **stub_addr)
+struct stub_syscall *syscall_stub_alloc(struct mm_id *mm_idp,
+					unsigned long data_len,
+					unsigned long *data_addr)
 {
-	unsigned long *stack;
-	int ret = 0;
-
-	/*
-	 * If *addr still is uninitialized, it *must* contain NULL.
-	 * Thus in this case do_syscall_stub correctly won't be called.
-	 */
-	if ((((unsigned long) *addr) & ~UM_KERN_PAGE_MASK) >=
-	   UM_KERN_PAGE_SIZE - (10 + data_count) * sizeof(long)) {
-		ret = do_syscall_stub(mm_idp, addr);
-		/* in case of error, don't overwrite data on stack */
-		if (ret)
-			return ret;
+	struct stub_syscall *sc;
+	struct stub_data *proc_data = (struct stub_data *) mm_idp->stack;
+	int len;
+
+	/* Align to sizeof(long) */
+	data_len = (data_len + sizeof(long) - 1) & ~(sizeof(long) - 1);
+	len = sizeof(struct stub_syscall) + data_len;
+
+	if (len > sizeof(proc_data->syscall_data))
+		panic("Syscall data too large to marshal!");
+
+	if (mm_idp->syscall_data_len > 0 &&
+	    mm_idp->syscall_data_len + len > sizeof(proc_data->syscall_data))
+		do_syscall_stub(mm_idp);
+
+	if (mm_idp->syscall_data_len < 0) {
+		/* Return dummy without changing the syscall_next_offset to
+		 * retain error state.
+		 */
+		sc = (void *) &proc_data->syscall_data;
+	} else {
+		sc = (void *) (((unsigned long) &proc_data->syscall_data) +
+			       mm_idp->syscall_data_len);
+		mm_idp->syscall_data_len += len;
 	}
+	memset(sc, 0, len);
+	sc->cmd_len = len;
 
-	stack = check_init_stack(mm_idp, *addr);
-	*addr = stack;
-
-	*stack = data_count * sizeof(long);
+	if (data_addr)
+		*data_addr = STUB_DATA +
+			     ((unsigned long) (&sc->data) &
+			      (UM_KERN_PAGE_SIZE - 1));
 
-	memcpy(stack + 1, data, data_count * sizeof(long));
-
-	*stub_addr = (void *)(((unsigned long)(stack + 1) &
-			       ~UM_KERN_PAGE_MASK) + STUB_DATA);
-
-	return 0;
+	return sc;
 }
 
-int map(struct mm_id * mm_idp, unsigned long virt, unsigned long len, int prot,
-	int phys_fd, unsigned long long offset, int done, void **data)
-{
-	int ret;
-	unsigned long args[] = { virt, len, prot,
-				 MAP_SHARED | MAP_FIXED, phys_fd,
-				 MMAP_OFFSET(offset) };
-
-	ret = run_syscall_stub(mm_idp, STUB_MMAP_NR, args, virt,
-			       data, done);
 
-	return ret;
+void map(struct mm_id *mm_idp, unsigned long virt, unsigned long len, int prot,
+	int phys_fd, unsigned long long offset)
+{
+	struct stub_syscall *sc;
+
+	sc = syscall_stub_alloc(mm_idp, 0, NULL);
+	sc->syscall = STUB_MMAP_NR;
+	sc->expected_result = virt;
+	sc->arg[0] = virt;
+	sc->arg[1] = len;
+	sc->arg[2] = prot;
+	sc->arg[3] = MAP_SHARED | MAP_FIXED;
+	sc->arg[4] = phys_fd;
+	sc->arg[5] = MMAP_OFFSET(offset);
 }
 
-int unmap(struct mm_id * mm_idp, unsigned long addr, unsigned long len,
-	  int done, void **data)
+void unmap(struct mm_id *mm_idp, unsigned long addr, unsigned long len)
 {
-	int ret;
-	unsigned long args[] = { (unsigned long) addr, len, 0, 0, 0,
-				 0 };
+	struct stub_syscall *sc;
 
-	ret = run_syscall_stub(mm_idp, __NR_munmap, args, 0,
-			       data, done);
-
-	return ret;
+	sc = syscall_stub_alloc(mm_idp, 0, NULL);
+	sc->syscall = __NR_munmap;
+	sc->arg[0] = addr;
+	sc->arg[1] = len;
 }
 
-int protect(struct mm_id * mm_idp, unsigned long addr, unsigned long len,
-	    unsigned int prot, int done, void **data)
+void protect(struct mm_id *mm_idp, unsigned long addr, unsigned long len,
+	    unsigned int prot)
 {
-	int ret;
-	unsigned long args[] = { addr, len, prot, 0, 0, 0 };
-
-	ret = run_syscall_stub(mm_idp, __NR_mprotect, args, 0,
-			       data, done);
+	struct stub_syscall *sc;
 
-	return ret;
+	sc = syscall_stub_alloc(mm_idp, 0, NULL);
+	sc->syscall = __NR_mprotect;
+	sc->arg[0] = addr;
+	sc->arg[1] = len;
+	sc->arg[2] = prot;
 }
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 3917bd862315..17164c4a7d7c 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -499,7 +499,7 @@ int copy_context_skas0(unsigned long new_stack, int pid)
 	*data = ((struct stub_data) {
 		.offset	= MMAP_OFFSET(new_offset),
 		.fd     = new_fd,
-		.parent_err = -ESRCH,
+		.err    = -ESRCH,
 		.child_err = 0,
 	});
 
@@ -536,7 +536,7 @@ int copy_context_skas0(unsigned long new_stack, int pid)
 
 	wait_stub_done(pid);
 
-	pid = data->parent_err;
+	pid = data->err;
 	if (pid < 0) {
 		printk(UM_KERN_ERR "%s - stub-parent reports error %d\n",
 		      __func__, -pid);
diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
index 3d5cd2e57820..ab0857399b8f 100644
--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -11,7 +11,7 @@ endif
 
 obj-y = bugs_$(BITS).o delay.o fault.o ldt.o \
 	ptrace_$(BITS).o ptrace_user.o setjmp_$(BITS).o signal.o \
-	stub_$(BITS).o stub_segv.o \
+	stub_segv.o \
 	sys_call_table_$(BITS).o sysrq_$(BITS).o tls_$(BITS).o \
 	mem_$(BITS).o subarch.o os-$(OS)/
 
diff --git a/arch/x86/um/ldt.c b/arch/x86/um/ldt.c
index 255a44dd415a..56e80c626d8a 100644
--- a/arch/x86/um/ldt.c
+++ b/arch/x86/um/ldt.c
@@ -12,33 +12,26 @@
 #include <os.h>
 #include <skas.h>
 #include <sysdep/tls.h>
+#include <stub-data.h>
 
 static inline int modify_ldt (int func, void *ptr, unsigned long bytecount)
 {
 	return syscall(__NR_modify_ldt, func, ptr, bytecount);
 }
 
-static long write_ldt_entry(struct mm_id *mm_idp, int func,
-		     struct user_desc *desc, void **addr, int done)
+static void write_ldt_entry(struct mm_id *mm_idp, int func,
+		     struct user_desc *desc)
 {
-	long res;
-	void *stub_addr;
-
-	BUILD_BUG_ON(sizeof(*desc) % sizeof(long));
-
-	res = syscall_stub_data(mm_idp, (unsigned long *)desc,
-				sizeof(*desc) / sizeof(long),
-				addr, &stub_addr);
-	if (!res) {
-		unsigned long args[] = { func,
-					 (unsigned long)stub_addr,
-					 sizeof(*desc),
-					 0, 0, 0 };
-		res = run_syscall_stub(mm_idp, __NR_modify_ldt, args,
-				       0, addr, done);
-	}
-
-	return res;
+	struct stub_syscall *sc;
+	unsigned long data_addr;
+
+	sc = syscall_stub_alloc(mm_idp, sizeof(*desc), &data_addr);
+	memcpy(sc->data, desc, sizeof(*desc));
+	sc->expected_result = 0;
+	sc->syscall = __NR_modify_ldt;
+	sc->arg[0] = func;
+	sc->arg[1] = data_addr;
+	sc->arg[2] = sizeof(*desc);
 }
 
 /*
@@ -127,7 +120,6 @@ static int write_ldt(void __user * ptr, unsigned long bytecount, int func)
 	int i, err;
 	struct user_desc ldt_info;
 	struct ldt_entry entry0, *ldt_p;
-	void *addr = NULL;
 
 	err = -EINVAL;
 	if (bytecount != sizeof(ldt_info))
@@ -148,7 +140,8 @@ static int write_ldt(void __user * ptr, unsigned long bytecount, int func)
 
 	mutex_lock(&ldt->lock);
 
-	err = write_ldt_entry(mm_idp, func, &ldt_info, &addr, 1);
+	write_ldt_entry(mm_idp, func, &ldt_info);
+	err = syscall_stub_flush(mm_idp);
 	if (err)
 		goto out_unlock;
 
@@ -166,7 +159,8 @@ static int write_ldt(void __user * ptr, unsigned long bytecount, int func)
 				err = -ENOMEM;
 				/* Undo the change in host */
 				memset(&ldt_info, 0, sizeof(ldt_info));
-				write_ldt_entry(mm_idp, 1, &ldt_info, &addr, 1);
+				write_ldt_entry(mm_idp, 1, &ldt_info);
+				err = syscall_stub_flush(mm_idp);
 				goto out_unlock;
 			}
 			if (i == 0) {
@@ -303,7 +297,6 @@ long init_new_ldt(struct mm_context *new_mm, struct mm_context *from_mm)
 	short * num_p;
 	int i;
 	long page, err=0;
-	void *addr = NULL;
 
 
 	mutex_init(&new_mm->arch.ldt.lock);
@@ -318,11 +311,9 @@ long init_new_ldt(struct mm_context *new_mm, struct mm_context *from_mm)
 		ldt_get_host_info();
 		for (num_p=host_ldt_entries; *num_p != -1; num_p++) {
 			desc.entry_number = *num_p;
-			err = write_ldt_entry(&new_mm->id, 1, &desc,
-					      &addr, *(num_p + 1) == -1);
-			if (err)
-				break;
+			write_ldt_entry(&new_mm->id, 1, &desc);
 		}
+		err = syscall_stub_flush(&new_mm->id);
 		new_mm->arch.ldt.entry_count = 0;
 
 		goto out;
diff --git a/arch/x86/um/shared/sysdep/stub.h b/arch/x86/um/shared/sysdep/stub.h
index ce0ca46ad383..579681d12158 100644
--- a/arch/x86/um/shared/sysdep/stub.h
+++ b/arch/x86/um/shared/sysdep/stub.h
@@ -12,4 +12,5 @@
 #endif
 
 extern void stub_segv_handler(int, siginfo_t *, void *);
+extern void stub_syscall_handler(void);
 extern void stub_clone_handler(void);
diff --git a/arch/x86/um/stub_32.S b/arch/x86/um/stub_32.S
deleted file mode 100644
index 8291899e6aaf..000000000000
--- a/arch/x86/um/stub_32.S
+++ /dev/null
@@ -1,56 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <as-layout.h>
-
-.section .__syscall_stub, "ax"
-
-	.globl batch_syscall_stub
-batch_syscall_stub:
-	/* %esp comes in as "top of page" */
-	mov %esp, %ecx
-	/* %esp has pointer to first operation */
-	add $8, %esp
-again:
-	/* load length of additional data */
-	mov	0x0(%esp), %eax
-
-	/* if(length == 0) : end of list */
-	/* write possible 0 to header */
-	mov	%eax, 0x4(%ecx)
-	cmpl	$0, %eax
-	jz	done
-
-	/* save current pointer */
-	mov	%esp, 0x4(%ecx)
-
-	/* skip additional data */
-	add	%eax, %esp
-
-	/* load syscall-# */
-	pop	%eax
-
-	/* load syscall params */
-	pop	%ebx
-	pop	%ecx
-	pop	%edx
-	pop	%esi
- 	pop	%edi
-	pop	%ebp
-
-	/* execute syscall */
-	int	$0x80
-
-	/* restore top of page pointer in %ecx */
-	mov	%esp, %ecx
-	andl	$(~UM_KERN_PAGE_SIZE) + 1, %ecx
-
-	/* check return value */
-	pop	%ebx
-	cmp	%ebx, %eax
-	je	again
-
-done:
-	/* save return value */
-	mov	%eax, (%ecx)
-
-	/* stop */
-	int3
diff --git a/arch/x86/um/stub_64.S b/arch/x86/um/stub_64.S
deleted file mode 100644
index f3404640197a..000000000000
--- a/arch/x86/um/stub_64.S
+++ /dev/null
@@ -1,50 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <as-layout.h>
-
-.section .__syscall_stub, "ax"
-	.globl batch_syscall_stub
-batch_syscall_stub:
-	/* %rsp has the pointer to first operation */
-	mov	%rsp, %rbx
-	add	$0x10, %rsp
-again:
-	/* load length of additional data */
-	mov	0x0(%rsp), %rax
-
-	/* if(length == 0) : end of list */
-	/* write possible 0 to header */
-	mov	%rax, 8(%rbx)
-	cmp	$0, %rax
-	jz	done
-
-	/* save current pointer */
-	mov	%rsp, 8(%rbx)
-
-	/* skip additional data */
-	add	%rax, %rsp
-
-	/* load syscall-# */
-	pop	%rax
-
-	/* load syscall params */
-	pop	%rdi
-	pop	%rsi
-	pop	%rdx
-	pop	%r10
- 	pop	%r8
-	pop	%r9
-
-	/* execute syscall */
-	syscall
-
-	/* check return value */
-	pop	%rcx
-	cmp	%rcx, %rax
-	je	again
-
-done:
-	/* save return value */
-	mov	%rax, (%rbx)
-
-	/* stop */
-	int3
-- 
2.38.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
