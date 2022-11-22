Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6993EC433FE
	for <linux-um@archiver.kernel.org>; Tue, 22 Nov 2022 10:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4o9WIY8EUijQE2CYU8HXMxhRGc7B9xAzaBhBNX13dBE=; b=EwPg99E/aq1qvd
	EQjBFQiMsp9ZmPQXzkKIPX5hgi/Bsl01N0dcQcYPUua+ptFyNhpC58r+38EESUIu4RvKuTDLS7YPE
	7hAVy9CWhgHyy60e0THNH3twzvbweeui5RMVw7dpIK2ncu+QVjxZfjtoghJ909qCxh/QPoj9pwl5H
	+TOFcz2qAjNW6GVIRTTpMKQerhyjs4dEohwLd41p9sh7Lu/vUW3pJckcQBWsZM+sbyo1k0CwdPAjI
	sFQdagiJQvuDdz1TuKXvX9gyzXG+IPRV/jAnj3kzzvjINXtTkptdvgd+WkDB9BFiAFwSKK2Q05s+x
	Gtk0uRGW9Bd1hhoNBI0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQUS-007nuy-RM; Tue, 22 Nov 2022 10:26:56 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQTL-007nKg-7F
	for linux-um@bombadil.infradead.org; Tue, 22 Nov 2022 10:25:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=96ItsAytwJTttTAMWODMnbHwjuNRvBXmNArE3fyRN6c=; b=EsygNAtZwxGtNrApwH35oVzpt1
	dGgv1D+oG6SO8gs1DvcfSbGJKN3aowiIVoHmulM9gZ9ILOR6ldwfUJ9WpgCLe49RVsjB806NQ041+
	W6MoLah/I/t2in1numrGpH5Q2AkA0gXaK/SYsVzqHqaJ9u4svLlWH9rDrNjvMIzRjvAC+xcCgOpux
	tAz2okCk+eJa1b/XsmW45nHEr+3ENVYMY0Ro0rv/D8uPrjkhwjIpWB+fhCZplaGHj8+YKSMi5VE9c
	X0j1I/4Zb4aUtv0EuK6MnDsdGthAW6LwMIdxVSyLWwgVLFPGTVu5mfXeg72Gl5APcqpC/37YjgARz
	I/hOFPnA==;
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQF1-003P1k-0L
	for linux-um@lists.infradead.org; Tue, 22 Nov 2022 10:11:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=96ItsAytwJTttTAMWODMnbHwjuNRvBXmNArE3fyRN6c=;
	t=1669111857; x=1670321457; b=dapKscrsqXC9TDhj7Gd2UaeR4Z5psXX2k0H13D2orLyC9U4
	6fUtu+z8/3ukvLv1yYD0whkPNp4X3G/LF+TTa6GYHnx476TK0yHAUUMSybF/tMm4TjmqdcFbSjKxr
	wPDm3Pqw/Q0PLf8HFjtJ7mKLtlHK+UOKs54DGiaJHgz33mBU9pTlNidijLlRNilsAl6XrM8u+mB9N
	KQ+8QxkSFlvHXkkzFsm9i8GLPsjGwL0d/eq2CgZQBPIcufcpEPOimGprjJ4DfMNhFzdR4zQFW0w2d
	3xPCpluGpof9Bjn6Q02vTQjijgGuUPp9aJKHimdgcZ6mJw6imICdqOe1Z+dVtj3g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1oxQEp-006IGn-34;
	Tue, 22 Nov 2022 11:10:48 +0100
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH v2 15/28] um: Create signal stack memory assignment in stub_data
Date: Tue, 22 Nov 2022 11:07:46 +0100
Message-Id: <20221122100759.208290-16-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221122100759.208290-1-benjamin@sipsolutions.net>
References: <20221122100759.208290-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_101101_456189_7B6A16CC 
X-CRM114-Status: GOOD (  17.45  )
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

When we switch to use seccomp, we need both the signal stack and other
data (i.e. syscall information) to co-exist in the stub data. To
facilitate this, start by defining separate memory areas for the stack
and syscall data.

This moves the signal stack onto a new page as the memory area is not
sufficient to hold both signal stack and syscall information.

Only change the signal stack setup for now, as the syscall code will be
reworked later.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
---
 arch/um/include/shared/as-layout.h      |  2 +-
 arch/um/include/shared/skas/stub-data.h | 12 ++++++++++++
 arch/um/kernel/skas/clone.c             |  7 +++++--
 arch/um/kernel/skas/mmu.c               |  6 +++---
 arch/um/os-Linux/skas/process.c         | 17 ++++++++++-------
 arch/x86/um/shared/sysdep/stub_32.h     |  3 ++-
 arch/x86/um/shared/sysdep/stub_64.h     |  5 +++--
 7 files changed, 36 insertions(+), 16 deletions(-)

diff --git a/arch/um/include/shared/as-layout.h b/arch/um/include/shared/as-layout.h
index 9a0bd648d872..70d3df8ae814 100644
--- a/arch/um/include/shared/as-layout.h
+++ b/arch/um/include/shared/as-layout.h
@@ -23,7 +23,7 @@
 #define STUB_START stub_start
 #define STUB_CODE STUB_START
 #define STUB_DATA (STUB_CODE + UM_KERN_PAGE_SIZE)
-#define STUB_END (STUB_DATA + UM_KERN_PAGE_SIZE)
+#define STUB_END (STUB_DATA + 2*UM_KERN_PAGE_SIZE)
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/um/include/shared/skas/stub-data.h b/arch/um/include/shared/skas/stub-data.h
index 5e3ade3fb38b..3281809a7272 100644
--- a/arch/um/include/shared/skas/stub-data.h
+++ b/arch/um/include/shared/skas/stub-data.h
@@ -8,10 +8,22 @@
 #ifndef __STUB_DATA_H
 #define __STUB_DATA_H
 
+#include <linux/compiler_types.h>
+#include <as-layout.h>
+
 struct stub_data {
 	unsigned long offset;
 	int fd;
 	long parent_err, child_err;
+
+	/* 128 leaves enough room for additional fields in the struct */
+	unsigned char syscall_data[UM_KERN_PAGE_SIZE - 128] __aligned(16);
+
+	/* Stack for our signal handlers and for calling into . */
+	unsigned char sigstack[UM_KERN_PAGE_SIZE] __aligned(UM_KERN_PAGE_SIZE);
 };
 
+typedef char stub_data_sizecheck
+	[sizeof(struct stub_data) == 2*UM_KERN_PAGE_SIZE ? 1 : -1] __always_unused;
+
 #endif
diff --git a/arch/um/kernel/skas/clone.c b/arch/um/kernel/skas/clone.c
index ff5061f29167..a631566e4a20 100644
--- a/arch/um/kernel/skas/clone.c
+++ b/arch/um/kernel/skas/clone.c
@@ -24,11 +24,14 @@
 void __attribute__ ((__section__ (".__syscall_stub")))
 stub_clone_handler(void)
 {
-	struct stub_data *data = get_stub_page();
+	struct stub_data *data = get_stub_page() + UM_KERN_PAGE_SIZE;
 	long err;
 
+	/* syscall data as a temporary stack area (bottom half). */
 	err = stub_syscall2(__NR_clone, CLONE_PARENT | CLONE_FILES | SIGCHLD,
-			    (unsigned long)data + UM_KERN_PAGE_SIZE / 2);
+			    (unsigned long) data->syscall_data +
+					    sizeof(data->syscall_data) / 2 -
+					    sizeof(void *));
 	if (err) {
 		data->parent_err = err;
 		goto done;
diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
index 125df465e8ea..6ccb561b4373 100644
--- a/arch/um/kernel/skas/mmu.c
+++ b/arch/um/kernel/skas/mmu.c
@@ -21,7 +21,7 @@ int init_new_context(struct task_struct *task, struct mm_struct *mm)
 	unsigned long stack = 0;
 	int ret = -ENOMEM;
 
-	stack = get_zeroed_page(GFP_KERNEL);
+	stack = __get_free_pages(GFP_KERNEL|__GFP_ZERO, 1);
 	if (stack == 0)
 		goto out;
 
@@ -52,7 +52,7 @@ int init_new_context(struct task_struct *task, struct mm_struct *mm)
 
  out_free:
 	if (to_mm->id.stack != 0)
-		free_page(to_mm->id.stack);
+		free_pages(to_mm->id.stack, 1);
  out:
 	return ret;
 }
@@ -74,6 +74,6 @@ void destroy_context(struct mm_struct *mm)
 	}
 	os_kill_ptraced_process(mmu->id.u.pid, 1);
 
-	free_page(mmu->id.stack);
+	free_pages(mmu->id.stack, 1);
 	free_ldt(mmu);
 }
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 4198ca21e4ab..3917bd862315 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -205,6 +205,7 @@ extern char __syscall_stub_start[];
 static int userspace_tramp(void *stack)
 {
 	struct sigaction sa;
+	struct stub_data *data;
 	void *addr;
 	int fd;
 	unsigned long long offset;
@@ -228,15 +229,16 @@ static int userspace_tramp(void *stack)
 
 	fd = phys_mapping(uml_to_phys(stack), &offset);
 	addr = mmap((void *) STUB_DATA,
-		    UM_KERN_PAGE_SIZE, PROT_READ | PROT_WRITE,
+		    sizeof(struct stub_data), PROT_READ | PROT_WRITE,
 		    MAP_FIXED | MAP_SHARED, fd, offset);
 	if (addr == MAP_FAILED) {
 		os_info("mapping segfault stack at 0x%lx failed, errno = %d\n",
 			STUB_DATA, errno);
 		exit(1);
 	}
+	data = (void *) addr;
 
-	set_sigstack((void *) STUB_DATA, UM_KERN_PAGE_SIZE);
+	set_sigstack((void *) &data->sigstack, sizeof(data->sigstack));
 	sigemptyset(&sa.sa_mask);
 	sa.sa_flags = SA_ONSTACK | SA_NODEFER | SA_SIGINFO;
 	sa.sa_sigaction = (void *) segv_handler;
@@ -470,11 +472,12 @@ static int __init init_thread_regs(void)
 	thread_regs[REGS_IP_INDEX] = STUB_CODE +
 				(unsigned long) stub_clone_handler -
 				(unsigned long) __syscall_stub_start;
-	thread_regs[REGS_SP_INDEX] = STUB_DATA + UM_KERN_PAGE_SIZE -
-		sizeof(void *);
-#ifdef __SIGNAL_FRAMESIZE
-	thread_regs[REGS_SP_INDEX] -= __SIGNAL_FRAMESIZE;
-#endif
+
+	/* syscall data as a temporary stack area (top half). */
+	thread_regs[REGS_SP_INDEX] = STUB_DATA +
+				     offsetof(struct stub_data, syscall_data) +
+				     sizeof(((struct stub_data *) 0)->syscall_data) -
+				     sizeof(void *);
 	return 0;
 }
 
diff --git a/arch/x86/um/shared/sysdep/stub_32.h b/arch/x86/um/shared/sysdep/stub_32.h
index c413927c6ad0..85a224506530 100644
--- a/arch/x86/um/shared/sysdep/stub_32.h
+++ b/arch/x86/um/shared/sysdep/stub_32.h
@@ -87,6 +87,7 @@ static __always_inline void trap_myself(void)
 
 static __always_inline void remap_stack_and_trap(void)
 {
+	/* The stack here is in syscall data (i.e. on the first page) */
 	__asm__ volatile (
 		"movl %%esp,%%ebx ;"
 		"andl %0,%%ebx ;"
@@ -102,7 +103,7 @@ static __always_inline void remap_stack_and_trap(void)
 		"g" (offsetof(struct stub_data, fd)),
 		"g" (offsetof(struct stub_data, offset)),
 		"g" (offsetof(struct stub_data, child_err)),
-		"c" (UM_KERN_PAGE_SIZE),
+		"c" (2*UM_KERN_PAGE_SIZE),
 		"d" (PROT_READ | PROT_WRITE),
 		"S" (MAP_FIXED | MAP_SHARED)
 		:
diff --git a/arch/x86/um/shared/sysdep/stub_64.h b/arch/x86/um/shared/sysdep/stub_64.h
index 361a6a9fe1e4..2e7acba74dc3 100644
--- a/arch/x86/um/shared/sysdep/stub_64.h
+++ b/arch/x86/um/shared/sysdep/stub_64.h
@@ -87,6 +87,7 @@ static __always_inline void trap_myself(void)
 
 static __always_inline void remap_stack_and_trap(void)
 {
+	/* The stack here is in syscall data (i.e. on the first page) */
 	__asm__ volatile (
 		"movq %0,%%rax ;"
 		"movq %%rsp,%%rdi ;"
@@ -105,7 +106,7 @@ static __always_inline void remap_stack_and_trap(void)
 		"g" (offsetof(struct stub_data, fd)),
 		"g" (offsetof(struct stub_data, offset)),
 		"g" (offsetof(struct stub_data, child_err)),
-		"S" (UM_KERN_PAGE_SIZE),
+		"S" (2*UM_KERN_PAGE_SIZE),
 		"d" (PROT_READ | PROT_WRITE)
 		:
 		__syscall_clobber, "r10", "r8", "r9");
@@ -121,6 +122,6 @@ static __always_inline void *get_stub_page(void)
 		: "=a" (ret)
 		: "g" (~(UM_KERN_PAGE_SIZE - 1)));
 
-	return (void *)ret;
+	return (void *)ret - UM_KERN_PAGE_SIZE;
 }
 #endif
-- 
2.38.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
