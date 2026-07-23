Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 087C7C531CB
	for <linux-um@archiver.kernel.org>; Thu, 23 Jul 2026 09:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L3vP5DSsxG5Iv0u7z9OQ7fpllN0iMUDf0zJGbZqEKpA=; b=GEeCCEG6Z2oPw5VyrnvlIYvfA7
	t8TeTmeQdkMGMLLlcYR6lrk3xPFkRrScP3ImwfDHpGZ5sLgdQk65r9ywsaCYyBOCzhnmu/BXFFLT9
	9ZnoWp5PLQ1DfIzxlsHlDcBHdWH/pFnjm4m6Qr5WzEMtYggenVz5+YYn/tPR9Uxt09ZCeAzre9JaV
	V4qCZy702erZbAMAMerGai4nQ442WZHA5mbTecC2FTENp8VGnXSAWdcXqrimlHiQqRKdX4EVLTMLY
	ZDofsyy6ZmxHHOnSfYi/P+TENNMBqMvj6phLCk5KKqhbimughnF6UcUVtneUGj903sGC77LycMNaE
	InlCw2Vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmpr9-0000000Drna-2j0j;
	Thu, 23 Jul 2026 09:36:43 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmpr7-0000000Drkq-0cKt
	for linux-um@lists.infradead.org;
	Thu, 23 Jul 2026 09:36:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=L3vP5DSsxG5Iv0u7z9OQ7fpllN0iMUDf0zJGbZqEKpA=;
	t=1784799401; x=1786009001; b=tIWGs2rgsemzJwhQL7I7MMU0Tvs1e9qUGJL34cGiLFgGur4
	VuQqZc2CRSM7K4b8qhzGTBoO/JZIeHNQ/8scAjjGuF5/aU3EYmOEKCxD1u81nbz0cdHOpCid0ca6y
	0hirsUoBYADSixESdCOV1m2b3tTKvNxrsLX036MlKTVkutPdEi01jR+Iuc9k2UyfDIIUFkSc9aQ/Z
	O99ZpRDz1MXuRXMuyuhI70BDp3hH8NusTIMYmIoXg+DjgTIpZXqod0NcKiazn3Vno/DyeDJTAQvf8
	Ay9Oj49LBBb1rGuGdLU6QKjgXzkZpRrHEpblXG44/YBE1vLTpmobqDxdHqLl89uQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wmpr4-0000000Aeqq-1DT9;
	Thu, 23 Jul 2026 11:36:38 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Hajime Tazaki <thehajime@gmail.com>,
	liam@infradead.org,
	ljs@kernel.org,
	Ricardo Koller <ricarkol@google.com>
Subject: [PATCH v2 03/10] um: nommu: memory handling
Date: Thu, 23 Jul 2026 11:35:44 +0200
Message-ID: <20260723113633.1206c739d6c0.I88b7ddf5613d072b934ce5fd9ef133ea5a4aa2b6@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723093633.140989-12-johannes@sipsolutions.net>
References: <20260723093633.140989-12-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260723_023641_213920_FCECB57C 
X-CRM114-Status: GOOD (  13.29  )
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

From: Hajime Tazaki <thehajime@gmail.com>

This commit adds memory operations on UML under !MMU environment.

Some part of the original UML code relying on CONFIG_MMU are excluded
from compilation when !CONFIG_MMU.  Additionally, generic functions such as
uaccess, futex, memcpy/strnlen/strncpy can be used as user- and
kernel-space share the address space in !CONFIG_MMU mode.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Ricardo Koller <ricarkol@google.com>
[drop unnecessary bits]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/include/asm/futex.h       | 4 ++++
 arch/um/include/asm/mmu.h         | 3 +++
 arch/um/include/asm/mmu_context.h | 2 ++
 arch/um/include/asm/uaccess.h     | 6 ++++--
 arch/um/kernel/mem.c              | 3 ++-
 5 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/um/include/asm/futex.h b/arch/um/include/asm/futex.h
index 780aa6bfc050..785fd6649aa2 100644
--- a/arch/um/include/asm/futex.h
+++ b/arch/um/include/asm/futex.h
@@ -7,8 +7,12 @@
 #include <asm/errno.h>
 
 
+#ifdef CONFIG_MMU
 int arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user *uaddr);
 int futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 			      u32 oldval, u32 newval);
+#else
+#include <asm-generic/futex.h>
+#endif
 
 #endif
diff --git a/arch/um/include/asm/mmu.h b/arch/um/include/asm/mmu.h
index 82a919132aff..c0b9ce3215c4 100644
--- a/arch/um/include/asm/mmu.h
+++ b/arch/um/include/asm/mmu.h
@@ -22,10 +22,13 @@ typedef struct mm_context {
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
 
 #define INIT_MM_CONTEXT(mm)						\
diff --git a/arch/um/include/asm/mmu_context.h b/arch/um/include/asm/mmu_context.h
index c727e56ba116..528b217da285 100644
--- a/arch/um/include/asm/mmu_context.h
+++ b/arch/um/include/asm/mmu_context.h
@@ -18,11 +18,13 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 {
 }
 
+#ifdef CONFIG_MMU
 #define init_new_context init_new_context
 extern int init_new_context(struct task_struct *task, struct mm_struct *mm);
 
 #define destroy_context destroy_context
 extern void destroy_context(struct mm_struct *mm);
+#endif
 
 #include <asm-generic/mmu_context.h>
 
diff --git a/arch/um/include/asm/uaccess.h b/arch/um/include/asm/uaccess.h
index 4417c8b1d37a..e493596f6663 100644
--- a/arch/um/include/asm/uaccess.h
+++ b/arch/um/include/asm/uaccess.h
@@ -18,6 +18,7 @@
 #define __addr_range_nowrap(addr, size) \
 	((unsigned long) (addr) <= ((unsigned long) (addr) + (size)))
 
+#ifdef CONFIG_MMU
 extern unsigned long raw_copy_from_user(void *to, const void __user *from, unsigned long n);
 extern unsigned long raw_copy_to_user(void __user *to, const void *from, unsigned long n);
 extern unsigned long __clear_user(void __user *mem, unsigned long len);
@@ -29,8 +30,6 @@ static inline int __access_ok(const void __user *ptr, unsigned long size);
 
 #define INLINE_COPY_USER
 
-#include <asm-generic/uaccess.h>
-
 static inline int __access_ok(const void __user *ptr, unsigned long size)
 {
 	unsigned long addr = (unsigned long)ptr;
@@ -62,5 +61,8 @@ do {									\
 	barrier();							\
 	current->thread.segv_continue = NULL;				\
 } while (0)
+#endif
+
+#include <asm-generic/uaccess.h>
 
 #endif
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 4b84760b5e55..bc03bf3d114d 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -64,7 +64,8 @@ void __init arch_mm_preinit(void)
 	 * to be turned on.
 	 */
 	brk_end = PAGE_ALIGN((unsigned long) sbrk(0));
-	map_memory(brk_end, __pa(brk_end), uml_reserved - brk_end, 1, 1, 0);
+	map_memory(brk_end, __pa(brk_end), uml_reserved - brk_end, 1, 1,
+		   !IS_ENABLED(CONFIG_MMU));
 	memblock_free((void *)brk_end, uml_reserved - brk_end);
 	uml_reserved = brk_end;
 	min_low_pfn = PFN_UP(__pa(uml_reserved));
-- 
2.53.0


