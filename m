Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5144FC79FA1
	for <linux-um@archiver.kernel.org>; Tue,  8 Sep 2026 12:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2RQcemfGMYTiDH29zfMnTtdgj0bHtOblVlsFhLPlSxk=; b=PVTeUdqHUO/CULMBThPujzLIfQ
	Vr6kvqJEG+aZrjsUvHV+G1oNQDugoSuPDfTiOfw26RDCxW/fbk2VR2OyN3Y5141+AburWXp6Fy2Zh
	Qz+DFLiSlSTnA43QXJZstZuFsB0mvF1gLv3Bt6eUGkLTlDpSPQw6FX1xrxmK5uy+hKIjlWelBYZP7
	T4exXsYgrETGeGeSG2Ss7ssw2Ic0l0F5ko3xIL26b1W9+cVGwizrE3QR7cpHrZrAl+N6sKGJK2U9+
	BPrtgCusypCWf/Ty4p3LD8+hsRzi3WYiajI9EnxRnc15YoAlmlsmWA4BQLELAMvZ7pyCnmmozxpW2
	R3m5Oikw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3v2P-000000091QV-02cP;
	Tue, 08 Sep 2026 12:34:57 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3v2M-000000091PI-1vRW;
	Tue, 08 Sep 2026 12:34:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id DC22B601DB;
	Tue,  8 Sep 2026 12:34:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A1661F00A3A;
	Tue,  8 Sep 2026 12:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788870893;
	bh=2RQcemfGMYTiDH29zfMnTtdgj0bHtOblVlsFhLPlSxk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BkBhZQWMJaKKK3kWxqiV0sRE5ApAZKRcLKBomVjsdDgfY+tP7URW39FuystAZN++H
	 HQ7wqjHB/37EVGJIuwiSGmfTp7Vp8T/jU0DMjRS4P9klDLrGCj2Qgu+A6lGKXNczH1
	 KJk4+Exs2cODA1A1Lu3ZQULVnsj0o5ldTr8gRlTAs6WV4+Eopslz62zHBRXBjdEVtW
	 hZ/N9yTzYdMknuV+LXXwqefUBW5vIRH3y297e01EmAEhvvwopzgh/oDKM8BVvAv5W7
	 0dJYrcsCtLdY8mL+iq+uQniVYRfzb5b9GZPzOV4w5hpwmFRg+SIxYSL8Mq+929rq4+
	 Ys06pk+5Bfl3g==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Tue, 08 Sep 2026 13:32:15 +0100
Subject: [PATCH v2 06/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for sparc64
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-rcu-pagetable-freeing-v2-6-1f60b64e878e@kernel.org>
References: <20260908-rcu-pagetable-freeing-v2-0-1f60b64e878e@kernel.org>
In-Reply-To: <20260908-rcu-pagetable-freeing-v2-0-1f60b64e878e@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Guo Ren <guoren@kernel.org>, Brian Cain <bcain@kernel.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Dinh Nguyen <dinguyen@kernel.org>, 
 Simon Schuster <schuster.simon@siemens-energy.com>, 
 Jonas Bonn <jonas@southpole.se>, 
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, 
 Stafford Horne <shorne@gmail.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Russell King <linux@armlinux.org.uk>, Vineet Gupta <vgupta@kernel.org>, 
 Michal Simek <monstr@monstr.eu>, Chris Zankel <chris@zankel.net>, 
 Max Filippov <jcmvbkbc@gmail.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Mark Rutland <mark.rutland@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
 WANG Xuerui <kernel@xen0n.name>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Arnd Bergmann <arnd@arndb.de>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
 linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org, 
 linux-sh@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-snps-arc@lists.infradead.org, 
 linux-arch@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-alpha@vger.kernel.org, loongarch@lists.linux.dev, 
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
 linux-um@lists.infradead.org, Hugh Dickins <hughd@google.com>, 
 Qi Zheng <qi.zheng@linux.dev>, "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2421; i=ljs@kernel.org;
 h=from:subject:message-id; bh=+cl/mE+MMAULPxyBPFJXsNZLkn5nuULAZlZa1FGDhyY=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLIWMESv2xKd48fI8mtTui4Ta/hp+d28Xu9rvA5wmH5vi
 71/9fG/jhIWBjEuBlkxRZbnX8T3B4mEzeu84O8GM4eVCWQIAxenAExEtYzhx96CQv0jOvtW8Zx5
 zXvjpdqkgMTXKRbHTaKeac+Ii+z4y8jQsigg8NunuC3bHPzfFqmkzHQ20pkho1xRW8x8/Nbx329
 ZAA==
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14
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

Commit 4a0100f7546f ("sparc64: use RCU page table freeing") enabled
CONFIG_MMU_GATHER_RCU_TABLE_FREE for SMP sparc64 architectures, expressly
for GUP-fast page table walkers.

Naturally, UP systems do not have to worry about concurrent GUP fast
operations.

However, CONFIG_PREEMPT_RCU is also available even on a UP system, so a
future pure-RCU page table walker requires MMU_GATHER_RCU_TABLE_FREE to be
enabled on UP, even if concurrent GUP fast is not possible there.

To enable future pure-RCU page table walkers, enable
MMU_GATHER_RCU_TABLE_FREE unconditionally.

With this change, it is no longer necessary to have !CONFIG_SMP
pgtable_free_tlb(), so also remove this now dead code.

This forms part of an overall effort to switch every architecture to this
mode.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 arch/sparc/Kconfig                  | 4 ++--
 arch/sparc/include/asm/pgalloc_64.h | 8 --------
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index ab77d3f2536e..8d42ebc6d302 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -75,8 +75,8 @@ config SPARC64
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_KRETPROBES
 	select HAVE_KPROBES
-	select MMU_GATHER_RCU_TABLE_FREE if SMP
-	select HAVE_ARCH_TLB_REMOVE_TABLE if SMP
+	select MMU_GATHER_RCU_TABLE_FREE
+	select HAVE_ARCH_TLB_REMOVE_TABLE
 	select MMU_GATHER_MERGE_VMAS
 	select MMU_GATHER_NO_FLUSH_CACHE
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
diff --git a/arch/sparc/include/asm/pgalloc_64.h b/arch/sparc/include/asm/pgalloc_64.h
index caa7632be4c2..b5055d259b74 100644
--- a/arch/sparc/include/asm/pgalloc_64.h
+++ b/arch/sparc/include/asm/pgalloc_64.h
@@ -74,8 +74,6 @@ void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable);
 
 void pgtable_free(void *table, bool is_page);
 
-#ifdef CONFIG_SMP
-
 struct mmu_gather;
 void tlb_remove_table(struct mmu_gather *, void *);
 
@@ -96,12 +94,6 @@ static inline void __tlb_remove_table(void *_table)
 		is_page = true;
 	pgtable_free(table, is_page);
 }
-#else /* CONFIG_SMP */
-static inline void pgtable_free_tlb(struct mmu_gather *tlb, void *table, bool is_page)
-{
-	pgtable_free(table, is_page);
-}
-#endif /* !CONFIG_SMP */
 
 static inline void __pte_free_tlb(struct mmu_gather *tlb, pte_t *pte,
 				  unsigned long address)

-- 
2.55.0


