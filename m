Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F6B8D690EA
	for <linux-um@archiver.kernel.org>; Thu, 28 Nov 2024 08:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g2sf686PpDWZ2cN+mtjQYq55ZfvXoQI1ImwFDg0LeDo=; b=FYqhzDzWK3+R+MT0sBoUrHtO8D
	0Br6BABkjcYTg/YQCT0i2+t7Jo8aKNCZrWjrtlbJDgagOxmsvlZVqEO/5HYCxD4UHLLd025VrMQMr
	/CQKNECbaSOMphblkWBALxfO155iG0mnSCB5ZHpmApzitBE7q27Gsp7SYRjhY7kKfDnHCoIkRTRgy
	ofGnEH7A9lrODXQRWkZY3tGHWWPO6b0YtjJtw5ID9GEYLcx+qtEmdsiY5TyeyjI5kljcq1RmjwanB
	qttljzghuuuyDkVpDKY9EBNIxIynkir8nRAFj6IwIYQJGqPI/56qBZjM7q+lpGAKeYLfZG0F7lkUO
	keHgOIQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGZlW-0000000EyXZ-17cN;
	Thu, 28 Nov 2024 08:20:46 +0000
Received: from out0-216.mail.aliyun.com ([140.205.0.216])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGZkg-0000000EyIQ-33hO
	for linux-um@lists.infradead.org;
	Thu, 28 Nov 2024 08:19:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1732781990; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=g2sf686PpDWZ2cN+mtjQYq55ZfvXoQI1ImwFDg0LeDo=;
	b=rhGJsxdOceLA+LumO90l33oZLpc05qr5mwSW/eVyvoAqt7RQ5awGlbpi8az5yyx2s+/rYkAFurw/oD3DxRqSL4IuxvByUj/6cc7rIj+DumBIuRoh6k/tZApMrlbIrN+3f1iKN0sSQEkNemKpbQhnbA0z/Fv1XEv4buy5orya8AQ=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.aP-8foL_1732781988 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 28 Nov 2024 16:19:49 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 2/3] um: Remove obsolete fixmap support
Date: Thu, 28 Nov 2024 16:19:38 +0800
Message-Id: <20241128081939.2216246-3-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128081939.2216246-1-tiwei.btw@antgroup.com>
References: <20241128081939.2216246-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241128_001954_911709_73FBFF04 
X-CRM114-Status: GOOD (  17.30  )
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

It was added to support highmem. But since the highmem support has
been removed by commit a98a6d864d3b ("um: Remove broken highmem
support"), it is no longer needed. Remove it to simplify the code.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/asm/fixmap.h  | 56 -----------------------------------
 arch/um/include/asm/pgtable.h |  5 +---
 arch/um/kernel/mem.c          | 15 +++-------
 3 files changed, 5 insertions(+), 71 deletions(-)
 delete mode 100644 arch/um/include/asm/fixmap.h

diff --git a/arch/um/include/asm/fixmap.h b/arch/um/include/asm/fixmap.h
deleted file mode 100644
index 2efac5827188..000000000000
--- a/arch/um/include/asm/fixmap.h
+++ /dev/null
@@ -1,56 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __UM_FIXMAP_H
-#define __UM_FIXMAP_H
-
-#include <asm/processor.h>
-#include <asm/archparam.h>
-#include <asm/page.h>
-#include <linux/threads.h>
-
-/*
- * Here we define all the compile-time 'special' virtual
- * addresses. The point is to have a constant address at
- * compile time, but to set the physical address only
- * in the boot process. We allocate these special  addresses
- * from the end of virtual memory (0xfffff000) backwards.
- * Also this lets us do fail-safe vmalloc(), we
- * can guarantee that these special addresses and
- * vmalloc()-ed addresses never overlap.
- *
- * these 'compile-time allocated' memory buffers are
- * fixed-size 4k pages. (or larger if used with an increment
- * highger than 1) use fixmap_set(idx,phys) to associate
- * physical memory with fixmap indices.
- *
- * TLB entries of such buffers will not be flushed across
- * task switches.
- */
-
-/*
- * on UP currently we will have no trace of the fixmap mechanizm,
- * no page table allocations, etc. This might change in the
- * future, say framebuffers for the console driver(s) could be
- * fix-mapped?
- */
-enum fixed_addresses {
-	__end_of_fixed_addresses
-};
-
-extern void __set_fixmap (enum fixed_addresses idx,
-			  unsigned long phys, pgprot_t flags);
-
-/*
- * used by vmalloc.c.
- *
- * Leave one empty page between vmalloc'ed areas and
- * the start of the fixmap, and leave one page empty
- * at the top of mem..
- */
-
-#define FIXADDR_TOP	(TASK_SIZE - 2 * PAGE_SIZE)
-#define FIXADDR_SIZE	(__end_of_fixed_addresses << PAGE_SHIFT)
-#define FIXADDR_START	(FIXADDR_TOP - FIXADDR_SIZE)
-
-#include <asm-generic/fixmap.h>
-
-#endif
diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
index 79ff979520bb..97d8b18c224e 100644
--- a/arch/um/include/asm/pgtable.h
+++ b/arch/um/include/asm/pgtable.h
@@ -8,8 +8,6 @@
 #ifndef __UM_PGTABLE_H
 #define __UM_PGTABLE_H
 
-#include <asm/fixmap.h>
-
 #define _PAGE_PRESENT	0x001
 #define _PAGE_NEEDSYNC	0x002
 #define _PAGE_RW	0x020
@@ -48,8 +46,7 @@ extern unsigned long end_iomem;
 
 #define VMALLOC_OFFSET	(__va_space)
 #define VMALLOC_START ((end_iomem + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1))
-#define PKMAP_BASE ((FIXADDR_START - LAST_PKMAP * PAGE_SIZE) & PMD_MASK)
-#define VMALLOC_END	(FIXADDR_START-2*PAGE_SIZE)
+#define VMALLOC_END	(TASK_SIZE-2*PAGE_SIZE)
 #define MODULES_VADDR	VMALLOC_START
 #define MODULES_END	VMALLOC_END
 
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 53248ed04771..8a0e74ad00d1 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -9,7 +9,6 @@
 #include <linux/mm.h>
 #include <linux/swap.h>
 #include <linux/slab.h>
-#include <asm/fixmap.h>
 #include <asm/page.h>
 #include <asm/pgalloc.h>
 #include <as-layout.h>
@@ -74,6 +73,7 @@ void __init mem_init(void)
 	kmalloc_ok = 1;
 }
 
+#if IS_ENABLED(CONFIG_ARCH_REUSE_HOST_VSYSCALL_AREA)
 /*
  * Create a page table and place a pointer to it in a middle page
  * directory entry.
@@ -152,7 +152,6 @@ static void __init fixrange_init(unsigned long start, unsigned long end,
 
 static void __init fixaddr_user_init( void)
 {
-#ifdef CONFIG_ARCH_REUSE_HOST_VSYSCALL_AREA
 	long size = FIXADDR_USER_END - FIXADDR_USER_START;
 	pte_t *pte;
 	phys_t p;
@@ -174,13 +173,12 @@ static void __init fixaddr_user_init( void)
 		pte = virt_to_kpte(vaddr);
 		pte_set_val(*pte, p, PAGE_READONLY);
 	}
-#endif
 }
+#endif
 
 void __init paging_init(void)
 {
 	unsigned long max_zone_pfn[MAX_NR_ZONES] = { 0 };
-	unsigned long vaddr;
 
 	empty_zero_page = (unsigned long *) memblock_alloc_low(PAGE_SIZE,
 							       PAGE_SIZE);
@@ -191,14 +189,9 @@ void __init paging_init(void)
 	max_zone_pfn[ZONE_NORMAL] = end_iomem >> PAGE_SHIFT;
 	free_area_init(max_zone_pfn);
 
-	/*
-	 * Fixed mappings, only the page table structure has to be
-	 * created - mappings will be set by set_fixmap():
-	 */
-	vaddr = __fix_to_virt(__end_of_fixed_addresses - 1) & PMD_MASK;
-	fixrange_init(vaddr, FIXADDR_TOP, swapper_pg_dir);
-
+#if IS_ENABLED(CONFIG_ARCH_REUSE_HOST_VSYSCALL_AREA)
 	fixaddr_user_init();
+#endif
 }
 
 /*
-- 
2.34.1


