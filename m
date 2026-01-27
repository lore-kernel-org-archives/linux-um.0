Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E7FD2F004
	for <linux-um@archiver.kernel.org>; Tue, 27 Jan 2026 12:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cQBzLGwNWLhDwXoP+ZRSwxq1ZRzbrKmRMjKOPlq54sI=; b=hB5c0bhejHcsVtC1T0Ff+20i5s
	nLySrzAzYecJ6P5mr7HUV+TN7+o8MHno5f/x/3cn8CgmqZo3716CONUEKeDYmQ8wIaHZGOkzaK2L+
	DzEhNs41MFeFRYuX9YWrwLt7iu8tzaumB+iFVcg6nfJzYuG7eqOKbywVztaKG7XiinxNppWuBir2/
	+kNsYZBjYWM0WXzE7u+6hAD5ZD5Hw7Bq/Ud1XArHL7Viv3mAWvKHARyA8Pob/2lW+QWKxPt4wT7FX
	2zi5DAVjv7+D1VXRfu+ZrzX2cVJ7gVrjKpgAjnl1oMijonIrLI5bUeNWbHFm3DBN3jYolVfppP/gM
	Er8AsqQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vki0E-0000000EE4B-2KJo;
	Tue, 27 Jan 2026 12:17:02 +0000
Received: from out-170.mta1.migadu.com ([95.215.58.170])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vki0C-0000000EE33-1VHz
	for linux-um@lists.infradead.org;
	Tue, 27 Jan 2026 12:17:01 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769516217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cQBzLGwNWLhDwXoP+ZRSwxq1ZRzbrKmRMjKOPlq54sI=;
	b=jSGS7Oe7flEf1a3jjawW71oBSQhZPtzIf1jHxOLDpEaGXg/8H0JQMtgOEgm1lxSI0nFjif
	CMLoz1yjkN0nwmCjWOwy4dWfqN8+bvppy0gq8toChP4Uc6ASbK4hQf7zJ4fTJfyy7Xu7HL
	RfqIvb9PoL98f2B3qx4iqWkzECkNTi0=
From: Qi Zheng <qi.zheng@linux.dev>
To: david@kernel.org,
	andreas@gaisler.com,
	richard.weiyang@gmail.com,
	will@kernel.org,
	peterz@infradead.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	dev.jain@arm.com,
	ioworker0@gmail.com,
	linmag7@gmail.com,
	akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-alpha@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-um@lists.infradead.org,
	sparclinux@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v4 7/8] mm: convert __HAVE_ARCH_TLB_REMOVE_TABLE to CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE config
Date: Tue, 27 Jan 2026 20:13:00 +0800
Message-ID: <5ebfa3d4b56e63c6906bda5eccaa9f7194d3a86b.1769515122.git.zhengqi.arch@bytedance.com>
In-Reply-To: <cover.1769515122.git.zhengqi.arch@bytedance.com>
References: <cover.1769515122.git.zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260127_041700_550509_639DD27D 
X-CRM114-Status: GOOD (  11.22  )
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

From: Qi Zheng <zhengqi.arch@bytedance.com>

For architectures that define __HAVE_ARCH_TLB_REMOVE_TABLE, the page
tables at the pmd/pud level are generally not of struct ptdesc type, and
do not have pt_rcu_head member, thus these architectures cannot support
PT_RECLAIM.

In preparation for enabling PT_RECLAIM on more architectures, convert
__HAVE_ARCH_TLB_REMOVE_TABLE to CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE config,
so that we can make conditional judgments in Kconfig.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 arch/powerpc/Kconfig            | 1 +
 arch/powerpc/include/asm/tlb.h  | 1 -
 arch/sparc/Kconfig              | 1 +
 arch/sparc/include/asm/tlb_64.h | 1 -
 include/asm-generic/tlb.h       | 2 +-
 mm/Kconfig                      | 3 +++
 6 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 9537a61ebae02..b47aa8fd62742 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -304,6 +304,7 @@ config PPC
 	select LOCK_MM_AND_FIND_VMA
 	select MMU_GATHER_PAGE_SIZE
 	select MMU_GATHER_RCU_TABLE_FREE
+	select HAVE_ARCH_TLB_REMOVE_TABLE
 	select MMU_GATHER_MERGE_VMAS
 	select MMU_LAZY_TLB_SHOOTDOWN		if PPC_BOOK3S_64
 	select MODULES_USE_ELF_RELA
diff --git a/arch/powerpc/include/asm/tlb.h b/arch/powerpc/include/asm/tlb.h
index 2058e8d3e0138..1ca7d4c4b90db 100644
--- a/arch/powerpc/include/asm/tlb.h
+++ b/arch/powerpc/include/asm/tlb.h
@@ -37,7 +37,6 @@ extern void tlb_flush(struct mmu_gather *tlb);
  */
 #define tlb_needs_table_invalidate()	radix_enabled()
 
-#define __HAVE_ARCH_TLB_REMOVE_TABLE
 /* Get the generic bits... */
 #include <asm-generic/tlb.h>
 
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index a630d373e6453..25fa2908d6152 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -74,6 +74,7 @@ config SPARC64
 	select HAVE_KRETPROBES
 	select HAVE_KPROBES
 	select MMU_GATHER_RCU_TABLE_FREE if SMP
+	select HAVE_ARCH_TLB_REMOVE_TABLE if SMP
 	select MMU_GATHER_MERGE_VMAS
 	select MMU_GATHER_NO_FLUSH_CACHE
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
diff --git a/arch/sparc/include/asm/tlb_64.h b/arch/sparc/include/asm/tlb_64.h
index 1a6e694418e39..3037187482db7 100644
--- a/arch/sparc/include/asm/tlb_64.h
+++ b/arch/sparc/include/asm/tlb_64.h
@@ -33,7 +33,6 @@ void flush_tlb_pending(void);
 #define tlb_needs_table_invalidate()	(false)
 #endif
 
-#define __HAVE_ARCH_TLB_REMOVE_TABLE
 #include <asm-generic/tlb.h>
 
 #endif /* _SPARC64_TLB_H */
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 4d679d2a206b4..3427b8036ba33 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -213,7 +213,7 @@ struct mmu_table_batch {
 #define MAX_TABLE_BATCH		\
 	((PAGE_SIZE - sizeof(struct mmu_table_batch)) / sizeof(void *))
 
-#ifndef __HAVE_ARCH_TLB_REMOVE_TABLE
+#ifndef CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE
 static inline void __tlb_remove_table(void *table)
 {
 	struct ptdesc *ptdesc = (struct ptdesc *)table;
diff --git a/mm/Kconfig b/mm/Kconfig
index a992f2203eb91..456e9eaedca39 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1451,6 +1451,9 @@ config ARCH_HAS_USER_SHADOW_STACK
 	  The architecture has hardware support for userspace shadow call
           stacks (eg, x86 CET, arm64 GCS or RISC-V Zicfiss).
 
+config HAVE_ARCH_TLB_REMOVE_TABLE
+	def_bool n
+
 config ARCH_SUPPORTS_PT_RECLAIM
 	def_bool n
 
-- 
2.20.1


