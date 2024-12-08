Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF1CFE7717F
	for <linux-um@archiver.kernel.org>; Sun,  8 Dec 2024 10:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5b8IVGRN6hSzKR2GLhryAMYxKrZ0FxMVKwADuX72vsY=; b=iU/UiLeXauFiqbYp7DsgYBvNrb
	YGk6KFMx4BAamUdm0GFVOcBnq/s4cq9fFoWBDGTgK9uxNaF2vPek14qi4m4JKfHlSdvYnWxsgSsYk
	mzq/CStKd8TdESTcdd4NUbk+BXDRAxuh6vh5SKSOnE7upvVGvcVLsulV1Gd7gvQ/v+hFv9a2Ngn8e
	F/GOQZa1DSDcvBjTvv064iVV+x1FmF/FTJC6ysdnyFc2yoenBCg7DV/Fg6OWX9DogC73qPLzzyxQ/
	ti6EC/kyTAw0lMweFGp3y4TcGPuVMIrsFwWCSwttC8foov72hAlBKiat+AQoEbHfXrfsC4zvTOk57
	wQgrnnyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKEKY-000000057UK-1tDx;
	Sun, 08 Dec 2024 10:16:02 +0000
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKEKV-000000057T9-2nG5
	for linux-um@lists.infradead.org;
	Sun, 08 Dec 2024 10:16:00 +0000
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-725ea1e19f0so74387b3a.3
        for <linux-um@lists.infradead.org>; Sun, 08 Dec 2024 02:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733652959; x=1734257759; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5b8IVGRN6hSzKR2GLhryAMYxKrZ0FxMVKwADuX72vsY=;
        b=l1775L6DtYPg7mj2/h/Z1XdG1y3tygjB5SznOkMLNztJqGdc0bcsZI0sChjoKsXCuM
         KmGnFajbjjxmg87LPdTHNrA7UtxetDP9IuBo9Vt1fc/7KPVPutE8UnTaqqKcIhxuQFe9
         oL5rWJIcRxetosyn/57aQ9NJlx0dxUC79rQT9DOZekUP3XCugtay38vNt/wj50G0BVYp
         r8JvVVLKHFWuBhWonl0PrajzODqDVdaqE0KiCGKeMJoSLzEXliIWHk2YHltc1HfY3mkp
         sbqED6eutFNuli3+sZ4Kps9FlMjW8Dp5aUg5p/++PuZeaRHU31wuiD5sGy5iB1Bmvqdq
         57iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733652959; x=1734257759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5b8IVGRN6hSzKR2GLhryAMYxKrZ0FxMVKwADuX72vsY=;
        b=U+O29Q6yU/AoN7QdwCVkuhWys3xOYzrzZLI546U/4d0t6mhhLjIyhFOTE2js8Zf9GL
         QwsjeNSKQFJ09aomf9QJomtluQ0OWGxHS/J7NO0PQcCxFEzUw3SLDNJvhPph2tPcmgno
         Ouk6VXU4tUQ03im/+lvWWiWbTbYHQStbtwDrVh7I/qePL2MF6JBEGoa3acTA4bv2r0gk
         EdlPMJWCwiTiR7Hi4uB1anUr1nGcT807FqlcRyCciIBX3InkhDScqxSGF40qjSltFrL3
         WwaBzNboFMTaeFlp8i3Ke6sqA1I1mMm7h01yAra0RyIR+Aor+JfCHy/+KttftFT801lp
         RBPg==
X-Gm-Message-State: AOJu0YwBL+JeeY0SwiSqCoyyYTs4dTrG9p+bHqcUimD4Xce3Q1KxP7SY
	SZi1anN3o4eyNOiRRc9Q+vk5Cbflq5ZjtdrfM29Pa25vy+ot4O2/
X-Gm-Gg: ASbGncvOMoZ9RCGdaBumC1a/dXtXIEhF3OoHOGUlSUqAsRwuregZuUblLaXZRScR4oS
	bZ9d4WSKcEuGVT63K4JncBaI2k83c7dsBozTdR1DjQNHnNrTHkIEsvie09JBDHVTnA1ifOUX+SU
	0LzWq+j8M/Um0LXeiI0fQRLsO7P9R/imnGGRsnFVXATGmFD9P8VhR0TPpnTwBeDB9XTVo+qPg+X
	UjhqA5yOl8H6FIdqMbdww/JN3d2f9Lhn41n1iNyysYtnKBWM4Ly3oFBUuA+7CLZWRtt0n0HsBQr
	kSyUlDX6cvvcayfwNgzj
X-Google-Smtp-Source: AGHT+IFzlYUn4NGVFknzhv+FVWsMcO7wOzvahUuZCaoClcRWB7TV8jvDG/QqSrtT1cpuN1g63jVHCA==
X-Received: by 2002:a05:6a00:17a9:b0:71d:fe64:e3fa with SMTP id d2e1a72fcca58-725b81f2514mr15163804b3a.19.1733652958561;
        Sun, 08 Dec 2024 02:15:58 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725c9ec7217sm2726746b3a.60.2024.12.08.02.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 02:15:57 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 549A4DDB024; Sun,  8 Dec 2024 19:15:56 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [PATCH v4 03/13] um: decouple MMU specific code from the common part
Date: Sun,  8 Dec 2024 19:15:30 +0900
Message-ID: <1bd611ff1f796b75a43faefcb81d24b3cedd4a87.1733652929.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733652929.git.thehajime@gmail.com>
References: <cover.1733652929.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241208_021559_713476_62E17B77 
X-CRM114-Status: GOOD (  21.20  )
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
 arch/um/include/shared/mem.h    |   8 ++
 arch/um/kernel/Makefile         |   5 +-
 arch/um/kernel/mem-pgtable.c    | 175 ++++++++++++++++++++++++++++++++
 arch/um/kernel/mem.c            | 149 +--------------------------
 arch/um/kernel/process.c        |  25 +++++
 arch/um/kernel/skas/process.c   |  27 -----
 arch/um/os-Linux/Makefile       |   3 +-
 arch/um/os-Linux/internal.h     |   5 +
 arch/um/os-Linux/process.c      | 133 ++++++++++++++++++++++++
 arch/um/os-Linux/skas/process.c | 132 ------------------------
 10 files changed, 352 insertions(+), 310 deletions(-)
 create mode 100644 arch/um/kernel/mem-pgtable.c

diff --git a/arch/um/include/shared/mem.h b/arch/um/include/shared/mem.h
index 98aacd544108..c5dfca3bf4d5 100644
--- a/arch/um/include/shared/mem.h
+++ b/arch/um/include/shared/mem.h
@@ -19,4 +19,12 @@ static inline void *uml_to_virt(unsigned long phys)
 	return((void *) uml_physmem + phys);
 }
 
+#ifdef CONFIG_MMU
+extern void um_fixrange_init(void);
+#else
+static inline void um_fixrange_init(void)
+{
+}
+#endif
+
 #endif
diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
index f8567b933ffa..eec6682812ce 100644
--- a/arch/um/kernel/Makefile
+++ b/arch/um/kernel/Makefile
@@ -16,9 +16,10 @@ extra-y := vmlinux.lds
 
 obj-y = config.o exec.o exitcode.o irq.o ksyms.o mem.o \
 	physmem.o process.o ptrace.o reboot.o sigio.o \
-	signal.o sysrq.o time.o tlb.o trap.o \
-	um_arch.o umid.o maccess.o kmsg_dump.o capflags.o skas/
+	signal.o sysrq.o time.o \
+	um_arch.o umid.o maccess.o kmsg_dump.o capflags.o
 obj-y += load_file.o
+obj-$(CONFIG_MMU) += mem-pgtable.o tlb.o trap.o skas/
 
 obj-$(CONFIG_BLK_DEV_INITRD) += initrd.o
 obj-$(CONFIG_GPROF)	+= gprof_syms.o
diff --git a/arch/um/kernel/mem-pgtable.c b/arch/um/kernel/mem-pgtable.c
new file mode 100644
index 000000000000..8c977bda601d
--- /dev/null
+++ b/arch/um/kernel/mem-pgtable.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
+ */
+
+#include <linux/stddef.h>
+#include <linux/module.h>
+#include <linux/memblock.h>
+#include <linux/mm.h>
+#include <linux/swap.h>
+#include <linux/slab.h>
+#include <asm/fixmap.h>
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
+/*
+ * Create a page table and place a pointer to it in a middle page
+ * directory entry.
+ */
+static void __init one_page_table_init(pmd_t *pmd)
+{
+	if (pmd_none(*pmd)) {
+		pte_t *pte = (pte_t *) memblock_alloc_low(PAGE_SIZE,
+							  PAGE_SIZE);
+		if (!pte)
+			panic("%s: Failed to allocate %lu bytes align=%lx\n",
+			      __func__, PAGE_SIZE, PAGE_SIZE);
+
+		set_pmd(pmd, __pmd(_KERNPG_TABLE +
+					   (unsigned long) __pa(pte)));
+		WARN_ON_ONCE(pte != pte_offset_kernel(pmd, 0));
+	}
+}
+
+static void __init one_md_table_init(pud_t *pud)
+{
+#if CONFIG_PGTABLE_LEVELS > 2
+	pmd_t *pmd_table = (pmd_t *) memblock_alloc_low(PAGE_SIZE, PAGE_SIZE);
+
+	if (!pmd_table)
+		panic("%s: Failed to allocate %lu bytes align=%lx\n",
+		      __func__, PAGE_SIZE, PAGE_SIZE);
+
+	set_pud(pud, __pud(_KERNPG_TABLE + (unsigned long) __pa(pmd_table)));
+	WARN_ON_ONCE(pmd_table != pmd_offset(pud, 0));
+#endif
+}
+
+static void __init one_ud_table_init(p4d_t *p4d)
+{
+#if CONFIG_PGTABLE_LEVELS > 3
+	pud_t *pud_table = (pud_t *) memblock_alloc_low(PAGE_SIZE, PAGE_SIZE);
+
+	if (!pud_table)
+		panic("%s: Failed to allocate %lu bytes align=%lx\n",
+		      __func__, PAGE_SIZE, PAGE_SIZE);
+
+	set_p4d(p4d, __p4d(_KERNPG_TABLE + (unsigned long) __pa(pud_table)));
+	WARN_ON_ONCE(pud_table != pud_offset(p4d, 0));
+#endif
+}
+
+static void __init fixrange_init(unsigned long start, unsigned long end,
+				 pgd_t *pgd_base)
+{
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+	int i, j;
+	unsigned long vaddr;
+
+	vaddr = start;
+	i = pgd_index(vaddr);
+	j = pmd_index(vaddr);
+	pgd = pgd_base + i;
+
+	for ( ; (i < PTRS_PER_PGD) && (vaddr < end); pgd++, i++) {
+		p4d = p4d_offset(pgd, vaddr);
+		if (p4d_none(*p4d))
+			one_ud_table_init(p4d);
+		pud = pud_offset(p4d, vaddr);
+		if (pud_none(*pud))
+			one_md_table_init(pud);
+		pmd = pmd_offset(pud, vaddr);
+		for (; (j < PTRS_PER_PMD) && (vaddr < end); pmd++, j++) {
+			one_page_table_init(pmd);
+			vaddr += PMD_SIZE;
+		}
+		j = 0;
+	}
+}
+
+static void __init fixaddr_user_init(void)
+{
+#ifdef CONFIG_ARCH_REUSE_HOST_VSYSCALL_AREA
+	long size = FIXADDR_USER_END - FIXADDR_USER_START;
+	pte_t *pte;
+	phys_t p;
+	unsigned long v, vaddr = FIXADDR_USER_START;
+
+	if (!size)
+		return;
+
+	fixrange_init(FIXADDR_USER_START, FIXADDR_USER_END, swapper_pg_dir);
+	v = (unsigned long) memblock_alloc_low(size, PAGE_SIZE);
+	if (!v)
+		panic("%s: Failed to allocate %lu bytes align=%lx\n",
+		      __func__, size, PAGE_SIZE);
+
+	memcpy((void *) v, (void *) FIXADDR_USER_START, size);
+	p = __pa(v);
+	for ( ; size > 0; size -= PAGE_SIZE, vaddr += PAGE_SIZE,
+		      p += PAGE_SIZE) {
+		pte = virt_to_kpte(vaddr);
+		pte_set_val(*pte, p, PAGE_READONLY);
+	}
+#endif
+}
+
+void __init um_fixrange_init(void)
+{
+	unsigned long vaddr;
+
+	/*
+	 * Fixed mappings, only the page table structure has to be
+	 * created - mappings will be set by set_fixmap():
+	 */
+	vaddr = __fix_to_virt(__end_of_fixed_addresses - 1) & PMD_MASK;
+	fixrange_init(vaddr, FIXADDR_TOP, swapper_pg_dir);
+
+	fixaddr_user_init();
+}
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
index 53248ed04771..e3a7ec32d6c7 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -6,7 +6,6 @@
 #include <linux/stddef.h>
 #include <linux/module.h>
 #include <linux/memblock.h>
-#include <linux/mm.h>
 #include <linux/swap.h>
 #include <linux/slab.h>
 #include <asm/fixmap.h>
@@ -74,113 +73,9 @@ void __init mem_init(void)
 	kmalloc_ok = 1;
 }
 
-/*
- * Create a page table and place a pointer to it in a middle page
- * directory entry.
- */
-static void __init one_page_table_init(pmd_t *pmd)
-{
-	if (pmd_none(*pmd)) {
-		pte_t *pte = (pte_t *) memblock_alloc_low(PAGE_SIZE,
-							  PAGE_SIZE);
-		if (!pte)
-			panic("%s: Failed to allocate %lu bytes align=%lx\n",
-			      __func__, PAGE_SIZE, PAGE_SIZE);
-
-		set_pmd(pmd, __pmd(_KERNPG_TABLE +
-					   (unsigned long) __pa(pte)));
-		BUG_ON(pte != pte_offset_kernel(pmd, 0));
-	}
-}
-
-static void __init one_md_table_init(pud_t *pud)
-{
-#if CONFIG_PGTABLE_LEVELS > 2
-	pmd_t *pmd_table = (pmd_t *) memblock_alloc_low(PAGE_SIZE, PAGE_SIZE);
-	if (!pmd_table)
-		panic("%s: Failed to allocate %lu bytes align=%lx\n",
-		      __func__, PAGE_SIZE, PAGE_SIZE);
-
-	set_pud(pud, __pud(_KERNPG_TABLE + (unsigned long) __pa(pmd_table)));
-	BUG_ON(pmd_table != pmd_offset(pud, 0));
-#endif
-}
-
-static void __init one_ud_table_init(p4d_t *p4d)
-{
-#if CONFIG_PGTABLE_LEVELS > 3
-	pud_t *pud_table = (pud_t *) memblock_alloc_low(PAGE_SIZE, PAGE_SIZE);
-	if (!pud_table)
-		panic("%s: Failed to allocate %lu bytes align=%lx\n",
-		      __func__, PAGE_SIZE, PAGE_SIZE);
-
-	set_p4d(p4d, __p4d(_KERNPG_TABLE + (unsigned long) __pa(pud_table)));
-	BUG_ON(pud_table != pud_offset(p4d, 0));
-#endif
-}
-
-static void __init fixrange_init(unsigned long start, unsigned long end,
-				 pgd_t *pgd_base)
-{
-	pgd_t *pgd;
-	p4d_t *p4d;
-	pud_t *pud;
-	pmd_t *pmd;
-	int i, j;
-	unsigned long vaddr;
-
-	vaddr = start;
-	i = pgd_index(vaddr);
-	j = pmd_index(vaddr);
-	pgd = pgd_base + i;
-
-	for ( ; (i < PTRS_PER_PGD) && (vaddr < end); pgd++, i++) {
-		p4d = p4d_offset(pgd, vaddr);
-		if (p4d_none(*p4d))
-			one_ud_table_init(p4d);
-		pud = pud_offset(p4d, vaddr);
-		if (pud_none(*pud))
-			one_md_table_init(pud);
-		pmd = pmd_offset(pud, vaddr);
-		for (; (j < PTRS_PER_PMD) && (vaddr < end); pmd++, j++) {
-			one_page_table_init(pmd);
-			vaddr += PMD_SIZE;
-		}
-		j = 0;
-	}
-}
-
-static void __init fixaddr_user_init( void)
-{
-#ifdef CONFIG_ARCH_REUSE_HOST_VSYSCALL_AREA
-	long size = FIXADDR_USER_END - FIXADDR_USER_START;
-	pte_t *pte;
-	phys_t p;
-	unsigned long v, vaddr = FIXADDR_USER_START;
-
-	if (!size)
-		return;
-
-	fixrange_init( FIXADDR_USER_START, FIXADDR_USER_END, swapper_pg_dir);
-	v = (unsigned long) memblock_alloc_low(size, PAGE_SIZE);
-	if (!v)
-		panic("%s: Failed to allocate %lu bytes align=%lx\n",
-		      __func__, size, PAGE_SIZE);
-
-	memcpy((void *) v , (void *) FIXADDR_USER_START, size);
-	p = __pa(v);
-	for ( ; size > 0; size -= PAGE_SIZE, vaddr += PAGE_SIZE,
-		      p += PAGE_SIZE) {
-		pte = virt_to_kpte(vaddr);
-		pte_set_val(*pte, p, PAGE_READONLY);
-	}
-#endif
-}
-
 void __init paging_init(void)
 {
 	unsigned long max_zone_pfn[MAX_NR_ZONES] = { 0 };
-	unsigned long vaddr;
 
 	empty_zero_page = (unsigned long *) memblock_alloc_low(PAGE_SIZE,
 							       PAGE_SIZE);
@@ -191,14 +86,7 @@ void __init paging_init(void)
 	max_zone_pfn[ZONE_NORMAL] = end_iomem >> PAGE_SHIFT;
 	free_area_init(max_zone_pfn);
 
-	/*
-	 * Fixed mappings, only the page table structure has to be
-	 * created - mappings will be set by set_fixmap():
-	 */
-	vaddr = __fix_to_virt(__end_of_fixed_addresses - 1) & PMD_MASK;
-	fixrange_init(vaddr, FIXADDR_TOP, swapper_pg_dir);
-
-	fixaddr_user_init();
+	um_fixrange_init();
 }
 
 /*
@@ -210,42 +98,7 @@ void free_initmem(void)
 {
 }
 
-/* Allocate and free page tables. */
-
-pgd_t *pgd_alloc(struct mm_struct *mm)
-{
-	pgd_t *pgd = (pgd_t *)__get_free_page(GFP_KERNEL);
-
-	if (pgd) {
-		memset(pgd, 0, USER_PTRS_PER_PGD * sizeof(pgd_t));
-		memcpy(pgd + USER_PTRS_PER_PGD,
-		       swapper_pg_dir + USER_PTRS_PER_PGD,
-		       (PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
-	}
-	return pgd;
-}
-
 void *uml_kmalloc(int size, int flags)
 {
 	return kmalloc(size, flags);
 }
-
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
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 30bdc0a87dc8..aaf7bcff235c 100644
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
@@ -46,6 +47,8 @@
 struct task_struct *cpu_tasks[NR_CPUS];
 EXPORT_SYMBOL(cpu_tasks);
 
+static char cpu0_irqstack[THREAD_SIZE] __aligned(THREAD_SIZE);
+
 void free_stack(unsigned long stack, int order)
 {
 	free_pages(stack, order);
@@ -295,3 +298,25 @@ unsigned long __get_wchan(struct task_struct *p)
 
 	return 0;
 }
+
+
+static int __init start_kernel_proc(void *unused)
+{
+	block_signals_trace();
+
+	start_kernel();
+	return 0;
+}
+
+int __init start_uml(void)
+{
+	stack_protections((unsigned long) &cpu0_irqstack);
+	set_sigstack(cpu0_irqstack, THREAD_SIZE);
+
+	init_new_thread_signals();
+
+	init_task.thread.request.thread.proc = start_kernel_proc;
+	init_task.thread.request.thread.arg = NULL;
+	return start_idle_thread(task_stack_page(&init_task),
+				 &init_task.thread.switch_buf);
+}
diff --git a/arch/um/kernel/skas/process.c b/arch/um/kernel/skas/process.c
index 05dcdc057af9..5247121d3419 100644
--- a/arch/um/kernel/skas/process.c
+++ b/arch/um/kernel/skas/process.c
@@ -16,33 +16,6 @@
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
-extern int userspace_pid[];
-
-static char cpu0_irqstack[THREAD_SIZE] __aligned(THREAD_SIZE);
-
-int __init start_uml(void)
-{
-	stack_protections((unsigned long) &cpu0_irqstack);
-	set_sigstack(cpu0_irqstack, THREAD_SIZE);
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
diff --git a/arch/um/os-Linux/Makefile b/arch/um/os-Linux/Makefile
index 049dfa5bc9c6..331564888400 100644
--- a/arch/um/os-Linux/Makefile
+++ b/arch/um/os-Linux/Makefile
@@ -8,7 +8,8 @@ KCOV_INSTRUMENT                := n
 
 obj-y = execvp.o file.o helper.o irq.o main.o mem.o process.o \
 	registers.o sigio.o signal.o start_up.o time.o tty.o \
-	umid.o user_syms.o util.o drivers/ skas/
+	umid.o user_syms.o util.o drivers/
+obj-$(CONFIG_MMU) += skas/
 
 CFLAGS_signal.o += -Wframe-larger-than=4096
 
diff --git a/arch/um/os-Linux/internal.h b/arch/um/os-Linux/internal.h
index 317fca190c2b..bcbf64ce8cd1 100644
--- a/arch/um/os-Linux/internal.h
+++ b/arch/um/os-Linux/internal.h
@@ -2,6 +2,11 @@
 #ifndef __UM_OS_LINUX_INTERNAL_H
 #define __UM_OS_LINUX_INTERNAL_H
 
+/*
+ * process.c
+ */
+extern int userspace_pid[];
+
 /*
  * elf_aux.c
  */
diff --git a/arch/um/os-Linux/process.c b/arch/um/os-Linux/process.c
index 9f086f939420..6df378639880 100644
--- a/arch/um/os-Linux/process.c
+++ b/arch/um/os-Linux/process.c
@@ -6,6 +6,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <stdbool.h>
 #include <unistd.h>
 #include <errno.h>
 #include <signal.h>
@@ -15,9 +16,15 @@
 #include <sys/prctl.h>
 #include <sys/wait.h>
 #include <asm/unistd.h>
+#include <linux/threads.h>
 #include <init.h>
 #include <longjmp.h>
 #include <os.h>
+#include <as-layout.h>
+#include <kern_util.h>
+
+int userspace_pid[NR_CPUS];
+int unscheduled_userspace_iterations;
 
 void os_alarm_process(int pid)
 {
@@ -209,3 +216,129 @@ void os_set_pdeathsig(void)
 {
 	prctl(PR_SET_PDEATHSIG, SIGKILL);
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
+/* XXX Make these percpu */
+static void (*cb_proc)(void *arg);
+static void *cb_arg;
+static jmp_buf *cb_back;
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
+	block_signals_trace();
+	if (UML_SETJMP(&here) == 0)
+		UML_LONGJMP(&initial_jmpbuf, INIT_JMP_CALLBACK);
+	unblock_signals_trace();
+
+	cb_proc = NULL;
+	cb_arg = NULL;
+	cb_back = NULL;
+}
+
+void halt_skas(void)
+{
+	block_signals_trace();
+	UML_LONGJMP(&initial_jmpbuf, INIT_JMP_HALT);
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
+"    crashes in CI\n");
+
+void reboot_skas(void)
+{
+	block_signals_trace();
+	UML_LONGJMP(&initial_jmpbuf, noreboot ? INIT_JMP_HALT : INIT_JMP_REBOOT);
+}
+
+void __switch_mm(struct mm_id *mm_idp)
+{
+	userspace_pid[0] = mm_idp->pid;
+}
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index f683cfc9e51a..555eb4905f70 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -5,7 +5,6 @@
  */
 
 #include <stdlib.h>
-#include <stdbool.h>
 #include <unistd.h>
 #include <sched.h>
 #include <errno.h>
@@ -16,7 +15,6 @@
 #include <sys/wait.h>
 #include <sys/stat.h>
 #include <asm/unistd.h>
-#include <as-layout.h>
 #include <init.h>
 #include <kern_util.h>
 #include <mem.h>
@@ -25,15 +23,9 @@
 #include <registers.h>
 #include <skas.h>
 #include <sysdep/stub.h>
-#include <linux/threads.h>
 #include <timetravel.h>
 #include "../internal.h"
 
-int is_skas_winch(int pid, int fd, void *data)
-{
-	return pid == getpgrp();
-}
-
 static const char *ptrace_reg_name(int idx)
 {
 #define R(n) case HOST_##n: return #n
@@ -305,8 +297,6 @@ static int __init init_stub_exe_fd(void)
 }
 __initcall(init_stub_exe_fd);
 
-int userspace_pid[NR_CPUS];
-
 /**
  * start_userspace() - prepare a new userspace process
  * @stub_stack:	pointer to the stub stack.
@@ -388,7 +378,6 @@ int start_userspace(unsigned long stub_stack)
 	return err;
 }
 
-int unscheduled_userspace_iterations;
 extern unsigned long tt_extra_sched_jiffies;
 
 void userspace(struct uml_pt_regs *regs)
@@ -550,124 +539,3 @@ void userspace(struct uml_pt_regs *regs)
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
-/* XXX Make these percpu */
-static void (*cb_proc)(void *arg);
-static void *cb_arg;
-static jmp_buf *cb_back;
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
-	block_signals_trace();
-	if (UML_SETJMP(&here) == 0)
-		UML_LONGJMP(&initial_jmpbuf, INIT_JMP_CALLBACK);
-	unblock_signals_trace();
-
-	cb_proc = NULL;
-	cb_arg = NULL;
-	cb_back = NULL;
-}
-
-void halt_skas(void)
-{
-	block_signals_trace();
-	UML_LONGJMP(&initial_jmpbuf, INIT_JMP_HALT);
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
-"    crashes in CI\n");
-
-void reboot_skas(void)
-{
-	block_signals_trace();
-	UML_LONGJMP(&initial_jmpbuf, noreboot ? INIT_JMP_HALT : INIT_JMP_REBOOT);
-}
-
-void __switch_mm(struct mm_id *mm_idp)
-{
-	userspace_pid[0] = mm_idp->pid;
-}
-- 
2.43.0


