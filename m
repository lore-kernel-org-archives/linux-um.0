Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE68CE8E6D
	for <linux-um@archiver.kernel.org>; Thu, 24 Oct 2024 12:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7HVu/xpbgTfEr4XXH3VyBLzi6M13RQjH86LLo3hFd0M=; b=OLD91R0gJb4jgriZMy3U6140Lu
	Wu6tPMzDU9tbbg3IStyA/4OsZczt3Lcl0JEBWNS0MAka1w48uREo/9Ls3pEAogWxQrpD4NDehTmxA
	kVJsZCyNBlMpLwA/AeOT3SBVRnt0YPTO9y7uD03b0G1axi26PoYurrdv15MTR1+Rf5bZMsiApfDgV
	28PKXXLfNkZjQO+IEjAW0gBtX0+e8ayHhFYfTUNkZuQBTSo699vAX77EG8Kmg9JK+wMUrFLblqqx6
	5TBhMfTk8/qNaD7Qrh0RO1LUMXAxMjsQzzzlZO9ZURpsG5EtaMLyxoKF+8FRk5mUb1gqOqd7uYXh/
	2I5ct4Rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3wgT-00000000IpO-1fmW;
	Thu, 24 Oct 2024 12:11:21 +0000
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3wfD-00000000IYM-0OTW
	for linux-um@lists.infradead.org;
	Thu, 24 Oct 2024 12:10:04 +0000
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-2e34a089cd3so669377a91.3
        for <linux-um@lists.infradead.org>; Thu, 24 Oct 2024 05:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729771802; x=1730376602; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7HVu/xpbgTfEr4XXH3VyBLzi6M13RQjH86LLo3hFd0M=;
        b=EQ0uExQO2GFmcx3LFtPzyy0v63/rbCUhODpuyXnANFmvFTRXSYIHmrJCbJtiJQ2FJP
         a1v89UsZt2hHNKtc5tnhOtg6NKKu0mRPKVlcwTOTEL4zoaVFHhdqsiq4VkdHUBbDLEj0
         dfQDOE/VPOpagnpGbyCy/vRdnWWb+AuNyQZhYq6SOH5RBgz8+wmmcX3Lb1CGFKoPWWEH
         /slO/19rn+EG/NXq9GmhIb1ySFXe/O8gqcqTMMXWQPgT40yfqhJTchE1g/2ti3/kX7DM
         gddHqeFWAv9KACtXWAcHEmQpseuD/BWDsfM2ypKKWHfUaSyH7rahcNEKHwcIhu/Wa8mv
         l6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729771802; x=1730376602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7HVu/xpbgTfEr4XXH3VyBLzi6M13RQjH86LLo3hFd0M=;
        b=u3AHfoDAj3FqcITavBrm8x1FJshf/3cA3aOXxLyUJrlbHYCRRfBVXQN7MwH5hLf54w
         7BYHjMUR0VHtYzA4YZP7EOCD+HID3agjKkO1SQMERBH8gZYB6uosgeyVhM3GEKrzJV49
         +g5gr1sPbbXYQI6tR+BUxa9f3CdtBbuGg/PmrUwKSxnZS0cloVf2UujvzvA+TwgM945f
         gVTCyShj9NA+1EFjhM+sIyOe3t9KAi36z4VMSKLVNk5+WkE+y7M0Bmi1SIZG5OIanOu7
         cKcFLz2pRdNRzbcY5Y+2fVEsjetrwxniqsnN2dc+5KQ/S6ITx0sKxBEqJaB+w639tuzT
         k0Aw==
X-Gm-Message-State: AOJu0YyVKS/iIpKM9IM5dgHCt/2SMnDK6k/D7HIWrxxepKmVm5N6O5AI
	MfnbAfjAkxW9GWmWFLbeZSR5kWPxHEtFjJOJ0MloluF9BdH7gY8O
X-Google-Smtp-Source: AGHT+IFc+tEkvpOlN5Z7sD3WZTdK+P73UggVxu2QfHuFxSxz6errsDqovoGUmzSwAwsIE4QzLr4fKQ==
X-Received: by 2002:a17:90b:1b03:b0:2e1:89aa:65b7 with SMTP id 98e67ed59e1d1-2e77f4355b1mr1972644a91.9.1729771801672;
        Thu, 24 Oct 2024 05:10:01 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e7867fd63csm597734a91.1.2024.10.24.05.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 05:10:01 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 1D99DD5124D; Thu, 24 Oct 2024 21:09:59 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org,
	jdike@addtoit.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: thehajime@gmail.com,
	ricarkol@google.com
Subject: [RFC PATCH 03/13] um: nommu: memory handling
Date: Thu, 24 Oct 2024 21:09:11 +0900
Message-ID: <304383e5c9b2bba18678598bbdacadc9126d8f74.1729770373.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729770373.git.thehajime@gmail.com>
References: <cover.1729770373.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241024_051003_167552_D582E625 
X-CRM114-Status: GOOD (  22.19  )
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

This commit adds memory operations on UML under !MMU environment.

Some part of the original UML code relying on CONFIG_MMU are excluded
from compilation when !CONFIG_MMU.  Additionally, generic functions such as
uaccess, futex, memcpy/strnlen/strncpy can be used as user- and
kernel-space share the address space in !CONFIG_MMU mode.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Ricardo Koller <ricarkol@google.com>
---
 arch/um/include/asm/futex.h       |  4 ++++
 arch/um/include/asm/mmu.h         |  3 +++
 arch/um/include/asm/mmu_context.h | 14 ++++++++++++--
 arch/um/include/asm/tlbflush.h    | 23 ++++++++++++++++++++++-
 arch/um/include/asm/uaccess.h     |  7 ++++---
 arch/um/include/shared/os.h       |  6 ++++++
 arch/um/kernel/Makefile           |  3 ++-
 arch/um/kernel/mem.c              | 13 +++++++++++++
 arch/um/kernel/physmem.c          |  6 ++++++
 arch/um/kernel/process.c          |  1 +
 arch/um/kernel/skas/Makefile      |  3 ++-
 arch/um/kernel/trap.c             |  4 ++++
 arch/um/os-Linux/process.c        |  5 +++++
 13 files changed, 84 insertions(+), 8 deletions(-)

diff --git a/arch/um/include/asm/futex.h b/arch/um/include/asm/futex.h
index 780aa6bfc050..89a8ac0b6963 100644
--- a/arch/um/include/asm/futex.h
+++ b/arch/um/include/asm/futex.h
@@ -8,7 +8,11 @@
 
 
 int arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user *uaddr);
+#ifdef CONFIG_MMU
 int futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 			      u32 oldval, u32 newval);
+#else
+#include <asm-generic/futex.h>
+#endif
 
 #endif
diff --git a/arch/um/include/asm/mmu.h b/arch/um/include/asm/mmu.h
index 01422b761aa0..d4087f9499e2 100644
--- a/arch/um/include/asm/mmu.h
+++ b/arch/um/include/asm/mmu.h
@@ -15,10 +15,13 @@ typedef struct mm_context {
 	unsigned long sync_tlb_range_from;
 	unsigned long sync_tlb_range_to;
 
+#ifndef CONFIG_MMU
+	unsigned long   end_brk;
 #ifdef CONFIG_BINFMT_ELF_FDPIC
 	unsigned long   exec_fdpic_loadmap;
 	unsigned long   interp_fdpic_loadmap;
 #endif
+#endif /* !CONFIG_MMU */
 } mm_context_t;
 
 #endif
diff --git a/arch/um/include/asm/mmu_context.h b/arch/um/include/asm/mmu_context.h
index 23dcc914d44e..279351beede5 100644
--- a/arch/um/include/asm/mmu_context.h
+++ b/arch/um/include/asm/mmu_context.h
@@ -37,10 +37,20 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 }
 
 #define init_new_context init_new_context
-extern int init_new_context(struct task_struct *task, struct mm_struct *mm);
-
 #define destroy_context destroy_context
+#ifdef CONFIG_MMU
+extern int init_new_context(struct task_struct *task, struct mm_struct *mm);
 extern void destroy_context(struct mm_struct *mm);
+#else
+static inline int init_new_context(struct task_struct *task, struct mm_struct *mm)
+{
+	return 0;
+}
+static inline void destroy_context(struct mm_struct *mm)
+{
+}
+#endif
+
 
 #include <asm-generic/mmu_context.h>
 
diff --git a/arch/um/include/asm/tlbflush.h b/arch/um/include/asm/tlbflush.h
index db997976b6ea..620debb84956 100644
--- a/arch/um/include/asm/tlbflush.h
+++ b/arch/um/include/asm/tlbflush.h
@@ -29,7 +29,7 @@
  *  - flush_tlb_range(vma, start, end) flushes a range of pages
  *  - flush_tlb_kernel_range(start, end) flushes a range of kernel pages
  */
-
+#ifdef CONFIG_MMU
 extern int um_tlb_sync(struct mm_struct *mm);
 
 extern void flush_tlb_all(void);
@@ -55,5 +55,26 @@ static inline void flush_tlb_kernel_range(unsigned long start,
 	/* Kernel needs to be synced immediately */
 	um_tlb_sync(&init_mm);
 }
+#else
+static inline int um_tlb_sync(struct mm_struct *mm)
+{
+	return 0;
+}
+
+static inline void flush_tlb_page(struct vm_area_struct *vma,
+				  unsigned long address)
+{
+}
+
+static inline void flush_tlb_range(struct vm_area_struct *vma,
+				   unsigned long start, unsigned long end)
+{
+}
+
+static inline void flush_tlb_kernel_range(unsigned long start,
+					  unsigned long end)
+{
+}
+#endif
 
 #endif
diff --git a/arch/um/include/asm/uaccess.h b/arch/um/include/asm/uaccess.h
index 1d4b6bbc1b65..9bfee12cb6b7 100644
--- a/arch/um/include/asm/uaccess.h
+++ b/arch/um/include/asm/uaccess.h
@@ -22,6 +22,7 @@
 #define __addr_range_nowrap(addr, size) \
 	((unsigned long) (addr) <= ((unsigned long) (addr) + (size)))
 
+#ifdef CONFIG_MMU
 extern unsigned long raw_copy_from_user(void *to, const void __user *from, unsigned long n);
 extern unsigned long raw_copy_to_user(void __user *to, const void *from, unsigned long n);
 extern unsigned long __clear_user(void __user *mem, unsigned long len);
@@ -33,9 +34,6 @@ static inline int __access_ok(const void __user *ptr, unsigned long size);
 
 #define INLINE_COPY_FROM_USER
 #define INLINE_COPY_TO_USER
-
-#include <asm-generic/uaccess.h>
-
 static inline int __access_ok(const void __user *ptr, unsigned long size)
 {
 	unsigned long addr = (unsigned long)ptr;
@@ -43,6 +41,9 @@ static inline int __access_ok(const void __user *ptr, unsigned long size)
 		(__under_task_size(addr, size) ||
 		 __access_ok_vsyscall(addr, size));
 }
+#endif
+
+#include <asm-generic/uaccess.h>
 
 /* no pagefaults for kernel addresses in um */
 #define __get_kernel_nofault(dst, src, type, err_label)			\
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 9a039d6f1f74..f6d3f3d7eade 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -196,7 +196,13 @@ extern void get_host_cpu_features(
 extern int create_mem_file(unsigned long long len);
 
 /* tlb.c */
+#ifdef CONFIG_MMU
 extern void report_enomem(void);
+#else
+static inline void report_enomem(void)
+{
+}
+#endif
 
 /* process.c */
 extern unsigned long os_process_pc(int pid);
diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
index f8567b933ffa..b41e9bcabbe3 100644
--- a/arch/um/kernel/Makefile
+++ b/arch/um/kernel/Makefile
@@ -16,9 +16,10 @@ extra-y := vmlinux.lds
 
 obj-y = config.o exec.o exitcode.o irq.o ksyms.o mem.o \
 	physmem.o process.o ptrace.o reboot.o sigio.o \
-	signal.o sysrq.o time.o tlb.o trap.o \
+	signal.o sysrq.o time.o trap.o \
 	um_arch.o umid.o maccess.o kmsg_dump.o capflags.o skas/
 obj-y += load_file.o
+obj-$(CONFIG_MMU) += tlb.o
 
 obj-$(CONFIG_BLK_DEV_INITRD) += initrd.o
 obj-$(CONFIG_GPROF)	+= gprof_syms.o
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index a5b4fe2ad931..c7498d609f0f 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -67,7 +67,11 @@ void __init mem_init(void)
 	 * to be turned on.
 	 */
 	brk_end = (unsigned long) UML_ROUND_UP(sbrk(0));
+#ifdef CONFIG_MMU
 	map_memory(brk_end, __pa(brk_end), uml_reserved - brk_end, 1, 1, 0);
+#else
+	map_memory(brk_end, __pa(brk_end), uml_reserved - brk_end, 1, 1, 1);
+#endif
 	memblock_free((void *)brk_end, uml_reserved - brk_end);
 	uml_reserved = brk_end;
 
@@ -81,6 +85,7 @@ void __init mem_init(void)
  * Create a page table and place a pointer to it in a middle page
  * directory entry.
  */
+#ifdef CONFIG_MMU
 static void __init one_page_table_init(pmd_t *pmd)
 {
 	if (pmd_none(*pmd)) {
@@ -137,6 +142,12 @@ static void __init fixrange_init(unsigned long start, unsigned long end,
 		j = 0;
 	}
 }
+#else
+static void __init fixrange_init(unsigned long start, unsigned long end,
+				 pgd_t *pgd_base)
+{
+}
+#endif
 
 static void __init fixaddr_user_init( void)
 {
@@ -218,6 +229,7 @@ void *uml_kmalloc(int size, int flags)
 	return kmalloc(size, flags);
 }
 
+#ifdef CONFIG_MMU
 static const pgprot_t protection_map[16] = {
 	[VM_NONE]					= PAGE_NONE,
 	[VM_READ]					= PAGE_READONLY,
@@ -237,3 +249,4 @@ static const pgprot_t protection_map[16] = {
 	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= PAGE_SHARED
 };
 DECLARE_VM_GET_PAGE_PROT
+#endif
diff --git a/arch/um/kernel/physmem.c b/arch/um/kernel/physmem.c
index fb2adfb49945..00ed840301ca 100644
--- a/arch/um/kernel/physmem.c
+++ b/arch/um/kernel/physmem.c
@@ -90,7 +90,11 @@ void __init setup_physmem(unsigned long start, unsigned long reserve_end,
 		exit(1);
 	}
 
+#ifdef CONFIG_MMU
 	physmem_fd = create_mem_file(len + highmem);
+#else
+	physmem_fd = -1;
+#endif
 
 	err = os_map_memory((void *) reserve_end, physmem_fd, reserve,
 			    map_size, 1, 1, 1);
@@ -101,6 +105,7 @@ void __init setup_physmem(unsigned long start, unsigned long reserve_end,
 		exit(1);
 	}
 
+#ifdef CONFIG_MMU
 	/*
 	 * Special kludge - This page will be mapped in to userspace processes
 	 * from physmem_fd, so it needs to be written out there.
@@ -108,6 +113,7 @@ void __init setup_physmem(unsigned long start, unsigned long reserve_end,
 	os_seek_file(physmem_fd, __pa(__syscall_stub_start));
 	os_write_file(physmem_fd, __syscall_stub_start, PAGE_SIZE);
 	os_fsync_file(physmem_fd);
+#endif
 
 	memblock_add(__pa(start), len + highmem);
 	memblock_reserve(__pa(start), reserve);
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index be2856af6d4c..b1b608afa036 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -29,6 +29,7 @@
 #include <asm/mmu_context.h>
 #include <asm/switch_to.h>
 #include <asm/exec.h>
+#include <asm/tlbflush.h>
 #include <linux/uaccess.h>
 #include <as-layout.h>
 #include <kern_util.h>
diff --git a/arch/um/kernel/skas/Makefile b/arch/um/kernel/skas/Makefile
index 6f86d53e3d69..97ea2d393e92 100644
--- a/arch/um/kernel/skas/Makefile
+++ b/arch/um/kernel/skas/Makefile
@@ -3,7 +3,8 @@
 # Copyright (C) 2002 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
 #
 
-obj-y := stub.o mmu.o process.o syscall.o uaccess.o
+obj-y := stub.o process.o
+obj-$(CONFIG_MMU) += mmu.o syscall.o uaccess.o
 
 # stub.o is in the stub, so it can't be built with profiling
 # GCC hardened also auto-enables -fpic, but we need %ebx so it can't work ->
diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index 97c8df9c4401..079f33d7d20c 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -24,6 +24,7 @@
 int handle_page_fault(unsigned long address, unsigned long ip,
 		      int is_write, int is_user, int *code_out)
 {
+#ifdef CONFIG_MMU
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
 	pmd_t *pmd;
@@ -129,6 +130,9 @@ int handle_page_fault(unsigned long address, unsigned long ip,
 		goto out_nosemaphore;
 	pagefault_out_of_memory();
 	return 0;
+#else
+	return -EFAULT;
+#endif
 }
 
 static void show_segv_info(struct uml_pt_regs *regs)
diff --git a/arch/um/os-Linux/process.c b/arch/um/os-Linux/process.c
index e52dd37ddadc..b164873da2db 100644
--- a/arch/um/os-Linux/process.c
+++ b/arch/um/os-Linux/process.c
@@ -144,8 +144,13 @@ int os_map_memory(void *virt, int fd, unsigned long long off, unsigned long len,
 	prot = (r ? PROT_READ : 0) | (w ? PROT_WRITE : 0) |
 		(x ? PROT_EXEC : 0);
 
+#ifdef UML_CONFIG_MMU
 	loc = mmap64((void *) virt, len, prot, MAP_SHARED | MAP_FIXED,
 		     fd, off);
+#else
+	loc = mmap64((void *) virt, len, prot, MAP_SHARED | MAP_FIXED | MAP_ANONYMOUS,
+		     fd, off);
+#endif
 	if (loc == MAP_FAILED)
 		return -errno;
 	return 0;
-- 
2.43.0


