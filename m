Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 619C3C35FE7
	for <linux-um@archiver.kernel.org>; Wed, 18 Sep 2024 06:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=GSbNvMbvlIYCPZ3mxOvNKxWg383qnaZcxNrNsAwhkbo=; b=QRRzU1EelXdOt0eFjnj0tvL8iC
	z7JYUXltzKtu5R48mutvACTIeJJ9WjAui58BBvA3+L90wqg6SDPuc1cZynrlVmNwdb/Cd6fd9EuDp
	uk6CFQLQGsofibbuQ/RJmvhdIT/yGz5XQV6kQeDzyKMtcvEYCystroFPKvvMxSI/m1z+6QipVKiNs
	kmHUncKhtREex30GarfPCvjdM4rwCEJ0NrtkvF0TTrbKCQAx6cvlj7RnPe7r9ySAnv/GM7vlbhQPb
	PM5kFuIzxkCk/8+RWG+gwaX3y45z0I02v4RbsBmkhO5Ngapr3zquebtmXs/nGK9e7W1xeJBB4bfWk
	t32XdfMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sqo0L-00000007WvR-3L4m;
	Wed, 18 Sep 2024 06:17:33 +0000
Received: from out0-198.mail.aliyun.com ([140.205.0.198])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sqo0I-00000007Wt3-3gTp
	for linux-um@lists.infradead.org;
	Wed, 18 Sep 2024 06:17:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1726640244; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=GSbNvMbvlIYCPZ3mxOvNKxWg383qnaZcxNrNsAwhkbo=;
	b=i2v4uYkEZ9Uymp4h3914hG5/qT+MIs4sFV23u/+5utOvKIMMf/61I7WptAaGT8GTuhPQ6ZxFsnKpGilNit4eAiXjcQtmhYY8zS25c0pIZFi4BLUtANMYxrvzxAzEVdnc9eorgwEjI90eC4FB5ltG9NcayzAh6ZPGpyeU9nUx80A=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.ZLyYvfD_1726640238)
          by smtp.aliyun-inc.com;
          Wed, 18 Sep 2024 14:17:23 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
   <benjamin@sipsolutions.net>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH] um: Remove 3-level page table support on i386
Date: Wed, 18 Sep 2024 14:17:02 +0800
Message-Id: <20240918061702.614837-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240917_231731_424442_1DE270E7 
X-CRM114-Status: UNSURE (   9.96  )
X-CRM114-Notice: Please train this message.
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

The highmem support has been removed by commit a98a6d864d3b ("um:
Remove broken highmem support"). The 2-level page table is sufficient
on UML/i386 now. Remove the 3-level page table support on UML/i386
which is still marked as experimental.

Suggested-by: Benjamin Berg <benjamin@sipsolutions.net>
Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/configs/i386_defconfig       |  1 -
 arch/um/include/asm/page.h           | 24 ------------------------
 arch/um/include/asm/pgtable-3level.h |  9 ---------
 arch/x86/um/Kconfig                  | 10 +---------
 4 files changed, 1 insertion(+), 43 deletions(-)

diff --git a/arch/um/configs/i386_defconfig b/arch/um/configs/i386_defconfig
index e543cbac8792..0cc717d80be6 100644
--- a/arch/um/configs/i386_defconfig
+++ b/arch/um/configs/i386_defconfig
@@ -1,4 +1,3 @@
-CONFIG_3_LEVEL_PGTABLES=y
 # CONFIG_COMPACTION is not set
 CONFIG_BINFMT_MISC=m
 CONFIG_HOSTFS=y
diff --git a/arch/um/include/asm/page.h b/arch/um/include/asm/page.h
index 9ef9a8aedfa6..8d2ac5e86cf5 100644
--- a/arch/um/include/asm/page.h
+++ b/arch/um/include/asm/page.h
@@ -32,28 +32,6 @@ struct page;
 #define clear_user_page(page, vaddr, pg)	clear_page(page)
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
 
-#if defined(CONFIG_3_LEVEL_PGTABLES) && !defined(CONFIG_64BIT)
-
-typedef struct { unsigned long pte; } pte_t;
-typedef struct { unsigned long pmd; } pmd_t;
-typedef struct { unsigned long pgd; } pgd_t;
-#define pte_val(p) ((p).pte)
-
-#define pte_get_bits(p, bits) ((p).pte & (bits))
-#define pte_set_bits(p, bits) ((p).pte |= (bits))
-#define pte_clear_bits(p, bits) ((p).pte &= ~(bits))
-#define pte_copy(to, from) ({ (to).pte = (from).pte; })
-#define pte_is_zero(p) (!((p).pte & ~_PAGE_NEWPAGE))
-#define pte_set_val(p, phys, prot) \
-	({ (p).pte = (phys) | pgprot_val(prot); })
-
-#define pmd_val(x)	((x).pmd)
-#define __pmd(x) ((pmd_t) { (x) } )
-
-typedef unsigned long long phys_t;
-
-#else
-
 typedef struct { unsigned long pte; } pte_t;
 typedef struct { unsigned long pgd; } pgd_t;
 
@@ -75,8 +53,6 @@ typedef struct { unsigned long pmd; } pmd_t;
 
 typedef unsigned long phys_t;
 
-#endif
-
 typedef struct { unsigned long pgprot; } pgprot_t;
 
 typedef struct page *pgtable_t;
diff --git a/arch/um/include/asm/pgtable-3level.h b/arch/um/include/asm/pgtable-3level.h
index 8a5032ec231f..3504a92dc485 100644
--- a/arch/um/include/asm/pgtable-3level.h
+++ b/arch/um/include/asm/pgtable-3level.h
@@ -11,11 +11,7 @@
 
 /* PGDIR_SHIFT determines what a third-level page table entry can map */
 
-#ifdef CONFIG_64BIT
 #define PGDIR_SHIFT	30
-#else
-#define PGDIR_SHIFT	31
-#endif
 #define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
 
@@ -32,13 +28,8 @@
  */
 
 #define PTRS_PER_PTE 512
-#ifdef CONFIG_64BIT
 #define PTRS_PER_PMD 512
 #define PTRS_PER_PGD 512
-#else
-#define PTRS_PER_PMD 1024
-#define PTRS_PER_PGD 1024
-#endif
 
 #define USER_PTRS_PER_PGD ((TASK_SIZE + (PGDIR_SIZE - 1)) / PGDIR_SIZE)
 
diff --git a/arch/x86/um/Kconfig b/arch/x86/um/Kconfig
index 186f13268401..7d16baba8f5f 100644
--- a/arch/x86/um/Kconfig
+++ b/arch/x86/um/Kconfig
@@ -29,15 +29,7 @@ config X86_64
 	select MODULES_USE_ELF_RELA
 
 config 3_LEVEL_PGTABLES
-	bool "Three-level pagetables" if !64BIT
-	default 64BIT
-	help
-	  Three-level pagetables will let UML have more than 4G of physical
-	  memory.  All the memory that can't be mapped directly will be treated
-	  as high memory.
-
-	  However, this it experimental on 32-bit architectures, so if unsure say
-	  N (on x86-64 it's automatically enabled, instead, as it's safe there).
+	def_bool 64BIT
 
 config ARCH_HAS_SC_SIGNALS
 	def_bool !64BIT
-- 
2.34.1


