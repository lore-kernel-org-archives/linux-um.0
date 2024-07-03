Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D8EC2BD09
	for <linux-um@archiver.kernel.org>; Wed,  3 Jul 2024 15:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rOiuN8k3ORWNFEm0oXH4Hxilb9NPN0ah39F1RbhmbF8=; b=i1XwfHOOHmocjQHpcN6y3cveOA
	Asab9LxGyPlXjB+Pb36NTeorDnUyk/7gTW461PiYBn7pcCKe+LRz6L4yvO2S1LOfykgVoYoVCpoFk
	J2CfGmTgFjWdny7a6Xry+/V/YDwe8V7BgYlBawqiE8sTz41huwpTB8ieMXrLLlhnUGVBTBLrMvxTA
	vjkToVIj8HRkjD/vCWOgqsjD+wOvUlVabj8vIBx1q6trBdN8Mpy3HPE49J7l4tae3m6WRlRQk3j7r
	T6U48lInFUdnpL3yG/Xfb1plAMqaJLab7Efrqsabs5rEI+8EHHNn6I9KugXRFmzFLY6ZWPHfhzp+X
	qzOO3vuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP1TW-0000000Aadd-2tYG;
	Wed, 03 Jul 2024 15:00:50 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP0JW-0000000ALJj-1iEQ
	for linux-um@bombadil.infradead.org;
	Wed, 03 Jul 2024 13:46:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=rOiuN8k3ORWNFEm0oXH4Hxilb9NPN0ah39F1RbhmbF8=; b=DXoSwkuwD/qz0C/Z/UVdXh/g9l
	ZqJXiOlJHuo6BJMLIrXJRWjlKFgn3uLjcZ61QsX2dVO1XV8tMNMPawPNSw3YmHJYhjdY0KJtANTkL
	EdmxpdzUOVIwAvFBO+Pt2RPn3I/GOdljp5P7mT2fPO70Cjxfq7ltGQG4+2kvCgoqOjfmRFowZp7bx
	FGlW2ee9DBYhssitJlq66hnnhueBnJcmDVU1G8nbBY0z7fc6uN3CQMCY/bs3g5hlqzjxrxRj2uG5z
	/OndXQgXmBYOdoZ9UId5Nwr55Is3x45zxHwCoxtjiIiq0LKEazisvJ9DSbv8y35866FfJzErXuoYz
	WWzJI/Dw==;
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP0JS-0000000A1I6-3DSK
	for linux-um@lists.infradead.org;
	Wed, 03 Jul 2024 13:46:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=rOiuN8k3ORWNFEm0oXH4Hxilb9NPN0ah39F1RbhmbF8=;
	t=1720014382; x=1721223982; b=mVXJueD9KejxHBRv4Fza+JYh5sz7XD7ZsDhw0hWUyZWKAYw
	Uzj5rklHZ8rHfMwe4Q61U5QqEAu4WTte35u58B6NwuCDeLirlGBdpsssnotOJAUpLppIrPOuVfRJ+
	kOG+y+lPctzxs6PUcE2gAV7O2uo/4aeJVUnFpkczyhUzwgEmr4mNna0FS5NvN1CGoepShe7vU/yeU
	6fkGeYz4I43P297YWJW/VXEa0xJZJ8x0EVK0xBlA+BXGUtDNS+9ZENq1XQE+iT6KwuBTVfiKieVt7
	wm3nsoh42dQ3MhkcmoywLM845xHg9vau7uON5oe9OYo2V+Pwmf1S1b9IxA2VSh0Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sP0JQ-000000094nb-3VQB;
	Wed, 03 Jul 2024 15:46:21 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v4 07/12] um: remove copy_context_skas0
Date: Wed,  3 Jul 2024 15:45:31 +0200
Message-ID: <20240703134536.1161108-8-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703134536.1161108-1-benjamin@sipsolutions.net>
References: <20240703134536.1161108-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_144623_429379_3D46592A 
X-CRM114-Status: GOOD (  20.72  )
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

From: Benjamin Berg <benjamin.berg@intel.com>

The kernel flushes the memory ranges anyway for CoW and does not assume
that the userspace process has anything set up already. So, start with a
fresh process for the new mm context.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/include/shared/os.h             |   1 -
 arch/um/include/shared/skas/stub-data.h |   1 -
 arch/um/kernel/skas/Makefile            |   8 +-
 arch/um/kernel/skas/clone.c             |  50 -----------
 arch/um/kernel/skas/mmu.c               |  20 ++---
 arch/um/os-Linux/skas/process.c         | 108 ------------------------
 arch/x86/um/shared/sysdep/stub.h        |   1 -
 arch/x86/um/shared/sysdep/stub_32.h     |  24 ------
 arch/x86/um/shared/sysdep/stub_64.h     |  26 ------
 9 files changed, 10 insertions(+), 229 deletions(-)
 delete mode 100644 arch/um/kernel/skas/clone.c

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index d1331d20fd2b..d12fec5d0b4d 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -285,7 +285,6 @@ void protect(struct mm_id *mm_idp, unsigned long addr,
 /* skas/process.c */
 extern int is_skas_winch(int pid, int fd, void *data);
 extern int start_userspace(unsigned long stub_stack);
-extern int copy_context_skas0(unsigned long stack, int pid);
 extern void userspace(struct uml_pt_regs *regs, unsigned long *aux_fp_regs);
 extern void new_thread(void *stack, jmp_buf *buf, void (*handler)(void));
 extern void switch_threads(jmp_buf *me, jmp_buf *you);
diff --git a/arch/um/include/shared/skas/stub-data.h b/arch/um/include/shared/skas/stub-data.h
index 6b8caf6b8283..2b6b44759dfa 100644
--- a/arch/um/include/shared/skas/stub-data.h
+++ b/arch/um/include/shared/skas/stub-data.h
@@ -36,7 +36,6 @@ struct stub_syscall {
 
 struct stub_data {
 	unsigned long offset;
-	int fd;
 	long err, child_err;
 
 	int syscall_data_len;
diff --git a/arch/um/kernel/skas/Makefile b/arch/um/kernel/skas/Makefile
index dd8bc2167e36..6f86d53e3d69 100644
--- a/arch/um/kernel/skas/Makefile
+++ b/arch/um/kernel/skas/Makefile
@@ -3,16 +3,14 @@
 # Copyright (C) 2002 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
 #
 
-obj-y := clone.o stub.o mmu.o process.o syscall.o uaccess.o
+obj-y := stub.o mmu.o process.o syscall.o uaccess.o
 
-# clone.o and stub.o are in the stub, so it can't be built with profiling
+# stub.o is in the stub, so it can't be built with profiling
 # GCC hardened also auto-enables -fpic, but we need %ebx so it can't work ->
 # disable it
 
-CFLAGS_clone.o := $(CFLAGS_NO_HARDENING)
 CFLAGS_stub.o := $(CFLAGS_NO_HARDENING)
-UNPROFILE_OBJS := clone.o stub.o
-
+UNPROFILE_OBJS := stub.o
 KCOV_INSTRUMENT := n
 
 include $(srctree)/arch/um/scripts/Makefile.rules
diff --git a/arch/um/kernel/skas/clone.c b/arch/um/kernel/skas/clone.c
deleted file mode 100644
index b59fa43d68ce..000000000000
--- a/arch/um/kernel/skas/clone.c
+++ /dev/null
@@ -1,50 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2015 Thomas Meyer (thomas@m3y3r.de)
- * Copyright (C) 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- */
-
-#include <signal.h>
-#include <sched.h>
-#include <asm/unistd.h>
-#include <sys/time.h>
-#include <as-layout.h>
-#include <ptrace_user.h>
-#include <stub-data.h>
-#include <sysdep/stub.h>
-
-/*
- * This is in a separate file because it needs to be compiled with any
- * extraneous gcc flags (-pg, -fprofile-arcs, -ftest-coverage) disabled
- *
- * Use UM_KERN_PAGE_SIZE instead of PAGE_SIZE because that calls getpagesize
- * on some systems.
- */
-
-void __attribute__ ((__section__ (".__syscall_stub")))
-stub_clone_handler(void)
-{
-	struct stub_data *data = get_stub_data();
-	long err;
-
-	/* syscall data as a temporary stack area (bottom half). */
-	err = stub_syscall2(__NR_clone, CLONE_PARENT | CLONE_FILES | SIGCHLD,
-			    (unsigned long) data->syscall_data +
-					    sizeof(data->syscall_data) / 2 -
-					    sizeof(void *));
-	if (err) {
-		data->err = err;
-		goto done;
-	}
-
-	err = stub_syscall4(__NR_ptrace, PTRACE_TRACEME, 0, 0, 0);
-	if (err) {
-		data->child_err = err;
-		goto done;
-	}
-
-	remap_stack_and_trap();
-
- done:
-	trap_myself();
-}
diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
index 968e254cf709..697dad49c36b 100644
--- a/arch/um/kernel/skas/mmu.c
+++ b/arch/um/kernel/skas/mmu.c
@@ -21,8 +21,7 @@ static_assert(sizeof(struct stub_data) == STUB_DATA_PAGES * UM_KERN_PAGE_SIZE);
 
 int init_new_context(struct task_struct *task, struct mm_struct *mm)
 {
- 	struct mm_context *from_mm = NULL;
-	struct mm_context *to_mm = &mm->context;
+	struct mm_id *new_id = &mm->context.id;
 	unsigned long stack = 0;
 	int ret = -ENOMEM;
 
@@ -30,27 +29,22 @@ int init_new_context(struct task_struct *task, struct mm_struct *mm)
 	if (stack == 0)
 		goto out;
 
-	to_mm->id.stack = stack;
-	if (current->mm != NULL && current->mm != &init_mm)
-		from_mm = &current->mm->context;
+	new_id->stack = stack;
 
 	block_signals_trace();
-	if (from_mm)
-		to_mm->id.u.pid = copy_context_skas0(stack,
-						     from_mm->id.u.pid);
-	else to_mm->id.u.pid = start_userspace(stack);
+	new_id->u.pid = start_userspace(stack);
 	unblock_signals_trace();
 
-	if (to_mm->id.u.pid < 0) {
-		ret = to_mm->id.u.pid;
+	if (new_id->u.pid < 0) {
+		ret = new_id->u.pid;
 		goto out_free;
 	}
 
 	return 0;
 
  out_free:
-	if (to_mm->id.stack != 0)
-		free_pages(to_mm->id.stack, ilog2(STUB_DATA_PAGES));
+	if (new_id->stack != 0)
+		free_pages(new_id->stack, ilog2(STUB_DATA_PAGES));
  out:
 	return ret;
 }
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index f49683ba186f..566b8ecccc3f 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -464,114 +464,6 @@ void userspace(struct uml_pt_regs *regs, unsigned long *aux_fp_regs)
 	}
 }
 
-static unsigned long thread_regs[MAX_REG_NR];
-static unsigned long thread_fp_regs[FP_SIZE];
-
-static int __init init_thread_regs(void)
-{
-	get_safe_registers(thread_regs, thread_fp_regs);
-	/* Set parent's instruction pointer to start of clone-stub */
-	thread_regs[REGS_IP_INDEX] = STUB_CODE +
-				(unsigned long) stub_clone_handler -
-				(unsigned long) __syscall_stub_start;
-
-	/* syscall data as a temporary stack area (top half). */
-	thread_regs[REGS_SP_INDEX] = STUB_DATA +
-				     offsetof(struct stub_data, syscall_data) +
-				     sizeof(((struct stub_data *) 0)->syscall_data) -
-				     sizeof(void *);
-	return 0;
-}
-
-__initcall(init_thread_regs);
-
-int copy_context_skas0(unsigned long new_stack, int pid)
-{
-	int err;
-	unsigned long current_stack = current_stub_stack();
-	struct stub_data *data = (struct stub_data *) current_stack;
-	struct stub_data *child_data = (struct stub_data *) new_stack;
-	unsigned long long new_offset;
-	int new_fd = phys_mapping(uml_to_phys((void *)new_stack), &new_offset);
-
-	/*
-	 * prepare offset and fd of child's stack as argument for parent's
-	 * and child's mmap2 calls
-	 */
-	*data = ((struct stub_data) {
-		.offset	= MMAP_OFFSET(new_offset),
-		.fd     = new_fd,
-		.err    = -ESRCH,
-		.child_err = 0,
-	});
-
-	*child_data = ((struct stub_data) {
-		.child_err = -ESRCH,
-	});
-
-	err = ptrace_setregs(pid, thread_regs);
-	if (err < 0) {
-		err = -errno;
-		printk(UM_KERN_ERR "%s : PTRACE_SETREGS failed, pid = %d, errno = %d\n",
-		      __func__, pid, -err);
-		return err;
-	}
-
-	err = put_fp_registers(pid, thread_fp_regs);
-	if (err < 0) {
-		printk(UM_KERN_ERR "%s : put_fp_registers failed, pid = %d, err = %d\n",
-		       __func__, pid, err);
-		return err;
-	}
-
-	/*
-	 * Wait, until parent has finished its work: read child's pid from
-	 * parent's stack, and check, if bad result.
-	 */
-	err = ptrace(PTRACE_CONT, pid, 0, 0);
-	if (err) {
-		err = -errno;
-		printk(UM_KERN_ERR "Failed to continue new process, pid = %d, errno = %d\n",
-		       pid, errno);
-		return err;
-	}
-
-	wait_stub_done(pid);
-
-	pid = data->err;
-	if (pid < 0) {
-		printk(UM_KERN_ERR "%s - stub-parent reports error %d\n",
-		      __func__, -pid);
-		return pid;
-	}
-
-	/*
-	 * Wait, until child has finished too: read child's result from
-	 * child's stack and check it.
-	 */
-	wait_stub_done(pid);
-	if (child_data->child_err != STUB_DATA) {
-		printk(UM_KERN_ERR "%s - stub-child %d reports error %ld\n",
-		       __func__, pid, data->child_err);
-		err = data->child_err;
-		goto out_kill;
-	}
-
-	if (ptrace(PTRACE_SETOPTIONS, pid, NULL,
-		   (void *)PTRACE_O_TRACESYSGOOD) < 0) {
-		err = -errno;
-		printk(UM_KERN_ERR "%s : PTRACE_SETOPTIONS failed, errno = %d\n",
-		       __func__, errno);
-		goto out_kill;
-	}
-
-	return pid;
-
- out_kill:
-	os_kill_ptraced_process(pid, 1);
-	return err;
-}
-
 void new_thread(void *stack, jmp_buf *buf, void (*handler)(void))
 {
 	(*buf)[0].JB_IP = (unsigned long) handler;
diff --git a/arch/x86/um/shared/sysdep/stub.h b/arch/x86/um/shared/sysdep/stub.h
index 579681d12158..dc89f4423454 100644
--- a/arch/x86/um/shared/sysdep/stub.h
+++ b/arch/x86/um/shared/sysdep/stub.h
@@ -13,4 +13,3 @@
 
 extern void stub_segv_handler(int, siginfo_t *, void *);
 extern void stub_syscall_handler(void);
-extern void stub_clone_handler(void);
diff --git a/arch/x86/um/shared/sysdep/stub_32.h b/arch/x86/um/shared/sysdep/stub_32.h
index ab08a69fb57f..0b44a86dd346 100644
--- a/arch/x86/um/shared/sysdep/stub_32.h
+++ b/arch/x86/um/shared/sysdep/stub_32.h
@@ -107,30 +107,6 @@ static __always_inline void trap_myself(void)
 	__asm("int3");
 }
 
-static __always_inline void remap_stack_and_trap(void)
-{
-	__asm__ volatile (
-		"movl %%esp,%%ebx ;"
-		"andl %0,%%ebx ;"
-		"movl %1,%%eax ;"
-		"movl %%ebx,%%edi ; addl %2,%%edi ; movl (%%edi),%%edi ;"
-		"movl %%ebx,%%ebp ; addl %3,%%ebp ; movl (%%ebp),%%ebp ;"
-		"int $0x80 ;"
-		"addl %4,%%ebx ; movl %%eax, (%%ebx) ;"
-		"int $3"
-		: :
-		"g" (~(STUB_DATA_PAGES * UM_KERN_PAGE_SIZE - 1)),
-		"g" (STUB_MMAP_NR),
-		"g" (offsetof(struct stub_data, fd)),
-		"g" (offsetof(struct stub_data, offset)),
-		"g" (offsetof(struct stub_data, child_err)),
-		"c" (STUB_DATA_PAGES * UM_KERN_PAGE_SIZE),
-		"d" (PROT_READ | PROT_WRITE),
-		"S" (MAP_FIXED | MAP_SHARED)
-		:
-		"memory");
-}
-
 static __always_inline void *get_stub_data(void)
 {
 	unsigned long ret;
diff --git a/arch/x86/um/shared/sysdep/stub_64.h b/arch/x86/um/shared/sysdep/stub_64.h
index d27b34d75d70..67f44284f1aa 100644
--- a/arch/x86/um/shared/sysdep/stub_64.h
+++ b/arch/x86/um/shared/sysdep/stub_64.h
@@ -101,32 +101,6 @@ static __always_inline void trap_myself(void)
 	__asm("int3");
 }
 
-static __always_inline void remap_stack_and_trap(void)
-{
-	__asm__ volatile (
-		"movq %0,%%rax ;"
-		"movq %%rsp,%%rdi ;"
-		"andq %1,%%rdi ;"
-		"movq %2,%%r10 ;"
-		"movq %%rdi,%%r8 ; addq %3,%%r8 ; movq (%%r8),%%r8 ;"
-		"movq %%rdi,%%r9 ; addq %4,%%r9 ; movq (%%r9),%%r9 ;"
-		__syscall ";"
-		"movq %%rsp,%%rdi ; andq %1,%%rdi ;"
-		"addq %5,%%rdi ; movq %%rax, (%%rdi) ;"
-		"int3"
-		: :
-		"g" (STUB_MMAP_NR),
-		"g" (~(STUB_DATA_PAGES * UM_KERN_PAGE_SIZE - 1)),
-		"g" (MAP_FIXED | MAP_SHARED),
-		"g" (offsetof(struct stub_data, fd)),
-		"g" (offsetof(struct stub_data, offset)),
-		"g" (offsetof(struct stub_data, child_err)),
-		"S" (STUB_DATA_PAGES * UM_KERN_PAGE_SIZE),
-		"d" (PROT_READ | PROT_WRITE)
-		:
-		__syscall_clobber, "r10", "r8", "r9");
-}
-
 static __always_inline void *get_stub_data(void)
 {
 	unsigned long ret;
-- 
2.45.2


