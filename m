Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 763D1E6C5FB
	for <linux-um@archiver.kernel.org>; Tue,  3 Dec 2024 04:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=atqGgfG+Flv1+OZ98qKLKwYRgW3U+66JPKscHncRmPM=; b=gzWFbn5YGyyQfSGJrEr0EWNEap
	OFx7L9MRQ8lo7HjnfxaoAhWiAQUB0xRd0Kk9fi8OCoSHo6IZfIODXsjxrNGNvU/atc2HAa7MoLOoy
	ZZZks3ImNqsaXZeZjj0JVNC7I3+sVBatQLfDbuMYw7XcOaTQTVOU82l4TjQKBRFPFONuo5Twg0wrb
	zoez//Rfu2xe2hJIH23AnBd8+SxqJIorpFImX+DvIOsfN8Z4aWIqcgkFk+WzAsfGNQEz2MDCse9uX
	2fbWZ/qoKrFmxVhF7yXDrwOhn3hOZgWZnZ1pK/+hWkg87dfVBGiiY33kaWkYmh2pfKcOtbgn8Hc1T
	4S+WgcMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIKRm-00000008DJz-0TRP;
	Tue, 03 Dec 2024 04:23:38 +0000
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIKRj-00000008DI7-29u7
	for linux-um@lists.infradead.org;
	Tue, 03 Dec 2024 04:23:36 +0000
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-724fc1aaa91so4588136b3a.3
        for <linux-um@lists.infradead.org>; Mon, 02 Dec 2024 20:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733199815; x=1733804615; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=atqGgfG+Flv1+OZ98qKLKwYRgW3U+66JPKscHncRmPM=;
        b=XhtdclHGQwTHuN6A5aIO9+4QDZkbJpnBujWaqA1yDYhjPuJLNP/fWnQpjhhi2G0/vd
         RRLXBy0USyv13n/L9sI5paCB8ylDcIqgC5pM5i0CM0Odoi6So3ZZXeTPNK8GmEnZtUfI
         7ZCuI3F0D/izjIYyqXyH4zxaaPo8QyhOs/3h9HHL62+DKXTZ1izvTN6LCQGZHEMSf2yb
         7g2xXEACVDOXHdpSrMectGFGG5roumawWVshrNa0IpyWh+e9FWQVQEJfE6+fRgQSAdSu
         khSubtovaLosnxk7GfMREGjTr7VPv8N2Fjm9tgW/OGFophf4ViMxnlkm4UAC4h5GlpJ5
         edTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733199815; x=1733804615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=atqGgfG+Flv1+OZ98qKLKwYRgW3U+66JPKscHncRmPM=;
        b=cYW06pYlAgzaSfY+QtwolZZo+4K67i0fimvdG3bXLVt8HtOkArR244CFgkqVFQ2+y8
         b/wFsgVv5maSeRxqLIrnM23835dyY2Nb8aiRWQalK+LdunXhHkZ8kJanm39LqCWsl3eo
         Ew2vQ1wPLy7YRw4dBQ0J6tLdCs8c5rXeU9YlCI59rgRLb7Alpjxlii4FPXr+5x86f5Rt
         v5mh/yOSciWq/lU6suGW7CdpACA9Bfx4EcGAd9f5/u6rTqmTd59zTrMc4o8hfROcMHQJ
         sinqY6opGIIBDqRX7PCrOoINjn+C23bLevd9sGtiTFdfpnfzYrXXsxr1wqCEVlIp6x0Q
         UQ+w==
X-Gm-Message-State: AOJu0YxF0XVJefCIr8osGZIvsOV8XnKWvpacN3SdTPV1NSE6V8uYM/GO
	vDzTqD+iU15CZpJn3Wr0NoFYswPW69pfi3Wg0KUFM9YXDNhx9tI75xs/Gw==
X-Gm-Gg: ASbGncu1lmPQ/HGR9gztW+SLRDBj5b9Kcls+VBNbSDfD/ngSpnzv03l/mdPn8vBQEnZ
	SdB0f20LErW8gwHO4FXX6/AmWcT1Gg25RDuqJyFViFHaK+DE3Vbihey4+3u3jisoH4gQ1U7Z1JB
	OecTglWmlDa74iGmUNwOfXVbK1QX2QV7dAEeuQ6Ibt5EWSCcmD3odHGOHXY36SppPCBq/RGLV+/
	pPUBTKMkRk3WKaiSQIW1PwXxA2QLYLmnKnQaK7BnrayMTox+UZlIenOQKQZfBF68faWBefIP0Vn
	PsR/WS1ysMh66j0+TrVR
X-Google-Smtp-Source: AGHT+IGAjIYXM+RTSI0JiFyrMbMSCB9Mxd+aYdmw9qKpJm8VXi7wQXZQrEjfNnDya3uzL+xYLV5c1A==
X-Received: by 2002:a05:6a00:3a1b:b0:725:48e6:10a4 with SMTP id d2e1a72fcca58-7257fa44b24mr1367866b3a.4.1733199814588;
        Mon, 02 Dec 2024 20:23:34 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c385eecsm8672209a12.68.2024.12.02.20.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 20:23:33 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 202FDDD39FD; Tue,  3 Dec 2024 13:23:31 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [PATCH v3 03/13] um: nommu: memory handling
Date: Tue,  3 Dec 2024 13:23:02 +0900
Message-ID: <1400de8bca3dc72df563156fcbc6eaaf54e2e58a.1733199769.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733199769.git.thehajime@gmail.com>
References: <cover.1733199769.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_202335_553798_CAF9D0F4 
X-CRM114-Status: GOOD (  21.24  )
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
 arch/um/include/asm/mmu_context.h | 13 +++++++++++--
 arch/um/include/asm/tlbflush.h    | 22 ++++++++++++++++++++++
 arch/um/include/asm/uaccess.h     |  7 ++++---
 arch/um/include/shared/os.h       |  6 ++++++
 arch/um/kernel/Makefile           |  3 ++-
 arch/um/kernel/mem.c              | 12 +++++++++++-
 arch/um/kernel/physmem.c          |  6 ++++++
 arch/um/kernel/skas/Makefile      |  4 ++--
 arch/um/kernel/trap.c             |  4 ++++
 arch/um/os-Linux/process.c        |  4 ++--
 12 files changed, 77 insertions(+), 11 deletions(-)

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
index 23dcc914d44e..da287e8c86b3 100644
--- a/arch/um/include/asm/mmu_context.h
+++ b/arch/um/include/asm/mmu_context.h
@@ -37,10 +37,19 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
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
 
 #include <asm-generic/mmu_context.h>
 
diff --git a/arch/um/include/asm/tlbflush.h b/arch/um/include/asm/tlbflush.h
index 13a3009942be..9157f71695c6 100644
--- a/arch/um/include/asm/tlbflush.h
+++ b/arch/um/include/asm/tlbflush.h
@@ -30,6 +30,7 @@
  *  - flush_tlb_kernel_range(start, end) flushes a range of kernel pages
  */
 
+#ifdef CONFIG_MMU
 extern int um_tlb_sync(struct mm_struct *mm);
 
 extern void flush_tlb_all(void);
@@ -55,5 +56,26 @@ static inline void flush_tlb_kernel_range(unsigned long start,
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
index 5babad8c5f75..6874be0c38a8 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -195,7 +195,13 @@ extern void get_host_cpu_features(
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
 extern void os_alarm_process(int pid);
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
index 53248ed04771..b674017d9871 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -64,7 +64,8 @@ void __init mem_init(void)
 	 * to be turned on.
 	 */
 	brk_end = (unsigned long) UML_ROUND_UP(sbrk(0));
-	map_memory(brk_end, __pa(brk_end), uml_reserved - brk_end, 1, 1, 0);
+	map_memory(brk_end, __pa(brk_end), uml_reserved - brk_end, 1, 1,
+		   !IS_ENABLED(CONFIG_MMU));
 	memblock_free((void *)brk_end, uml_reserved - brk_end);
 	uml_reserved = brk_end;
 
@@ -78,6 +79,7 @@ void __init mem_init(void)
  * Create a page table and place a pointer to it in a middle page
  * directory entry.
  */
+#ifdef CONFIG_MMU
 static void __init one_page_table_init(pmd_t *pmd)
 {
 	if (pmd_none(*pmd)) {
@@ -149,6 +151,12 @@ static void __init fixrange_init(unsigned long start, unsigned long end,
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
@@ -230,6 +238,7 @@ void *uml_kmalloc(int size, int flags)
 	return kmalloc(size, flags);
 }
 
+#ifdef CONFIG_MMU
 static const pgprot_t protection_map[16] = {
 	[VM_NONE]					= PAGE_NONE,
 	[VM_READ]					= PAGE_READONLY,
@@ -249,3 +258,4 @@ static const pgprot_t protection_map[16] = {
 	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= PAGE_SHARED
 };
 DECLARE_VM_GET_PAGE_PROT
+#endif
diff --git a/arch/um/kernel/physmem.c b/arch/um/kernel/physmem.c
index a74f17b033c4..f55d46dbe173 100644
--- a/arch/um/kernel/physmem.c
+++ b/arch/um/kernel/physmem.c
@@ -84,7 +84,11 @@ void __init setup_physmem(unsigned long start, unsigned long reserve_end,
 		exit(1);
 	}
 
+#ifdef CONFIG_MMU
 	physmem_fd = create_mem_file(len);
+#else
+	physmem_fd = -1;
+#endif
 
 	err = os_map_memory((void *) reserve_end, physmem_fd, reserve,
 			    map_size, 1, 1, 1);
@@ -95,12 +99,14 @@ void __init setup_physmem(unsigned long start, unsigned long reserve_end,
 		exit(1);
 	}
 
+#ifdef CONFIG_MMU
 	/*
 	 * Special kludge - This page will be mapped in to userspace processes
 	 * from physmem_fd, so it needs to be written out there.
 	 */
 	os_seek_file(physmem_fd, __pa(__syscall_stub_start));
 	os_write_file(physmem_fd, __syscall_stub_start, PAGE_SIZE);
+#endif
 
 	memblock_add(__pa(start), len);
 	memblock_reserve(__pa(start), reserve);
diff --git a/arch/um/kernel/skas/Makefile b/arch/um/kernel/skas/Makefile
index 3384be42691f..64d7ba803b1a 100644
--- a/arch/um/kernel/skas/Makefile
+++ b/arch/um/kernel/skas/Makefile
@@ -3,8 +3,8 @@
 # Copyright (C) 2002 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
 #
 
-obj-y := stub.o mmu.o process.o syscall.o uaccess.o \
-	 stub_exe_embed.o
+obj-y := stub.o process.o stub_exe_embed.o
+obj-$(CONFIG_MMU) += mmu.o syscall.o uaccess.o
 
 # Stub executable
 
diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index cdaee3e94273..a7519b3de4bf 100644
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
index 9f086f939420..ef1a2f0aa06a 100644
--- a/arch/um/os-Linux/process.c
+++ b/arch/um/os-Linux/process.c
@@ -63,8 +63,8 @@ int os_map_memory(void *virt, int fd, unsigned long long off, unsigned long len,
 	prot = (r ? PROT_READ : 0) | (w ? PROT_WRITE : 0) |
 		(x ? PROT_EXEC : 0);
 
-	loc = mmap64((void *) virt, len, prot, MAP_SHARED | MAP_FIXED,
-		     fd, off);
+	loc = mmap64((void *) virt, len, prot, MAP_SHARED | MAP_FIXED |
+		     (!IS_ENABLED(CONFIG_MMU) ? MAP_ANONYMOUS : 0), fd, off);
 	if (loc == MAP_FAILED)
 		return -errno;
 	return 0;
-- 
2.43.0


