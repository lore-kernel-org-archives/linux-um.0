Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DBBDD2FEE1
	for <linux-um@archiver.kernel.org>; Tue, 27 Jan 2026 20:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QNEa4mYWEczHBci/mwpJ7O9nUgvSIDfRjPeADRaPwjc=; b=ehTrO95u/Wq056WtL9DeQv5UKS
	NXGI9oMlK4VGLVntPPczyt43z8s+T3et17TsIHgiIjOLpjk1EFoEV6y7pqTFzU4CpXAgyEXdXKiZw
	83DGEhVmHjkTvcWLQgZJ7t9iHB05SDiTOXc8W9scYMtcK5Ax8ZRzGzZiaTrWLh5V3tnwXi6Rp60A2
	NnbTpsATnPk83vREWc59qQqK8YrwIA4swL/SV1igsO8I22ZDzSVhAG9oxmIy/MB9UBRISTTDc6LkI
	1rRQVXCmRpT71xiwljRPUuhHdLXvuNhKv7Y4wql8uBaZ5d9zd1FAyxc9edt/5HLfVPHa19c/i345X
	vKLzrQPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkpxX-0000000F1iB-1TuT;
	Tue, 27 Jan 2026 20:46:47 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkpxV-0000000F1hz-49QI
	for linux-um@lists.infradead.org;
	Tue, 27 Jan 2026 20:46:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B50DE601DE;
	Tue, 27 Jan 2026 20:46:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA31C116C6;
	Tue, 27 Jan 2026 20:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1769546804;
	bh=dPe4WO5V5xGcqbRrtLSrAnb6cZI7NA2TSDIlxEHcMg0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PFrp9aENn8GkO3oMV5uU3fw/sDFm4fOIgmG6lOGNP6rxP54wuO7jQTZJOTnpGqGTk
	 NB3Sv2FHYDDBA3dsblyvixrcw3tZ4kXXeRIcFlqab7TMCcctx5uC+lfxG1L0MdwWzA
	 L7gQdZ4FA8nw9mzJUh2KfWM9LIGY8FgBJ+uk9/GM=
Date: Tue, 27 Jan 2026 12:46:42 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: david@kernel.org, andreas@gaisler.com, richard.weiyang@gmail.com,
 will@kernel.org, peterz@infradead.org, aneesh.kumar@kernel.org,
 npiggin@gmail.com, dev.jain@arm.com, ioworker0@gmail.com,
 linmag7@gmail.com, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-alpha@vger.kernel.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-um@lists.infradead.org, sparclinux@vger.kernel.org, Qi Zheng
 <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v4 0/8] enable PT_RECLAIM on more 64-bit architectures
Message-Id: <20260127124642.480123beb01ebb487f986a09@linux-foundation.org>
In-Reply-To: <cover.1769515122.git.zhengqi.arch@bytedance.com>
References: <cover.1769515122.git.zhengqi.arch@bytedance.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 27 Jan 2026 20:12:53 +0800 Qi Zheng <qi.zheng@linux.dev> wrote:

> This series aims to enable PT_RECLAIM on more 64-bit architectures.

Thanks, I updated mm.git's mm-unstable branch to v4.

> Changes in v4:
>  - convert __HAVE_ARCH_TLB_REMOVE_TABLE to CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE config
>  - fix a WARN_ON_ONCE() on sparc64 (and on ppc)
>    (reported by Andreas Larsson)
>  - collect Acked-by (Hi David, I've kept your Acked-by, feel free to drop it)
>  - rebase onto the v6.19-rc7
> 

Below is how v4 altered mm.git.

I'm not seeing the WARN_ON_ONCE() fix.  I assume that was due to the
Kconfig alterations?



--- a/arch/powerpc/include/asm/tlb.h~b
+++ a/arch/powerpc/include/asm/tlb.h
@@ -37,7 +37,6 @@ extern void tlb_flush(struct mmu_gather
  */
 #define tlb_needs_table_invalidate()	radix_enabled()
 
-#define __HAVE_ARCH_TLB_REMOVE_TABLE
 /* Get the generic bits... */
 #include <asm-generic/tlb.h>
 
--- a/arch/powerpc/Kconfig~b
+++ a/arch/powerpc/Kconfig
@@ -305,6 +305,7 @@ config PPC
 	select LOCK_MM_AND_FIND_VMA
 	select MMU_GATHER_PAGE_SIZE
 	select MMU_GATHER_RCU_TABLE_FREE
+	select HAVE_ARCH_TLB_REMOVE_TABLE
 	select MMU_GATHER_MERGE_VMAS
 	select MMU_LAZY_TLB_SHOOTDOWN		if PPC_BOOK3S_64
 	select MODULES_USE_ELF_RELA
--- a/arch/sparc/include/asm/tlb_64.h~b
+++ a/arch/sparc/include/asm/tlb_64.h
@@ -33,7 +33,6 @@ void flush_tlb_pending(void);
 #define tlb_needs_table_invalidate()	(false)
 #endif
 
-#define __HAVE_ARCH_TLB_REMOVE_TABLE
 #include <asm-generic/tlb.h>
 
 #endif /* _SPARC64_TLB_H */
--- a/arch/sparc/Kconfig~b
+++ a/arch/sparc/Kconfig
@@ -74,6 +74,7 @@ config SPARC64
 	select HAVE_KRETPROBES
 	select HAVE_KPROBES
 	select MMU_GATHER_RCU_TABLE_FREE if SMP
+	select HAVE_ARCH_TLB_REMOVE_TABLE if SMP
 	select MMU_GATHER_MERGE_VMAS
 	select MMU_GATHER_NO_FLUSH_CACHE
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
--- a/include/asm-generic/tlb.h~b
+++ a/include/asm-generic/tlb.h
@@ -213,7 +213,7 @@ struct mmu_table_batch {
 #define MAX_TABLE_BATCH		\
 	((PAGE_SIZE - sizeof(struct mmu_table_batch)) / sizeof(void *))
 
-#ifndef __HAVE_ARCH_TLB_REMOVE_TABLE
+#ifndef CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE
 static inline void __tlb_remove_table(void *table)
 {
 	struct ptdesc *ptdesc = (struct ptdesc *)table;
--- a/mm/Kconfig~b
+++ a/mm/Kconfig
@@ -1448,9 +1448,12 @@ config ARCH_HAS_USER_SHADOW_STACK
 	  The architecture has hardware support for userspace shadow call
           stacks (eg, x86 CET, arm64 GCS or RISC-V Zicfiss).
 
+config HAVE_ARCH_TLB_REMOVE_TABLE
+	def_bool n
+
 config PT_RECLAIM
 	def_bool y
-	depends on MMU_GATHER_RCU_TABLE_FREE
+	depends on MMU_GATHER_RCU_TABLE_FREE && !HAVE_ARCH_TLB_REMOVE_TABLE
 	help
 	  Try to reclaim empty user page table pages in paths other than munmap
 	  and exit_mmap path.
_


