Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA163E92725
	for <linux-um@archiver.kernel.org>; Sun, 28 Dec 2025 12:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xFDXLTGATkroZNEN8JNWl0z6F0M9aK5uk6oqTTiy5J4=; b=BgHpGFAZVjgiqZa4hnj9+PUeQH
	l3G3FBSiitFRT2zqzL1JNvtWaDsTJYnNAalYD9uaL+pt39fOI3F4/Fi24oLzIjdx4HTap0SBXKUJv
	tGeU+uKcFC5FcP+abBGOkBEPcpqDcvXekbHunEfOE+kE/RbPgRb11gudIy4cHWegbb7gySeV8hnn2
	05kHu2rnsWGyw9Fz6q6OE1PliJlRzEkCY+Z3PC04Um/7IiKOlWuSzSAknu6BSrMktiw2CwpRhpcGK
	n18NuSgkdotvsbB3XoRJhAFVp1tJLrmCtCgLtN6gC/D0JXPWDbYfhrLoFTe24yWFaxa06ZwVvHzoq
	f1BPLVNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZqAc-00000002kUs-2ElL;
	Sun, 28 Dec 2025 12:46:50 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZqAU-00000002kRw-3SSR;
	Sun, 28 Dec 2025 12:46:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 50CE24378D;
	Sun, 28 Dec 2025 12:46:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC499C4CEFB;
	Sun, 28 Dec 2025 12:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766926002;
	bh=HLFdL0b2vHYE2Es8eysIP16cx1LQEF5ywfNPEf+XyUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qdL0kS/SmoVKxl3WK0KKH+Jldx6Q7XCWF4V+7VX9pSzxoVIkAcP2FPqqmEDdDdypd
	 cLaoKUTUDB4h90YuoSE8146Xk14NH6RwNwsudZVlWBJbL+a4t2Nqpsbk3k2ARV3+N2
	 eID7ge2FU6TWbxLFJUWNUQEm0iiU1l23JkDPBTcH2jJtDq6J+FeokyJzunQW8y6L+G
	 6DbBTj4JSTeBjvfu66zvi0Ev+Vp1cGy39Y078vptGbfRjWTon98SfWpDR6jBxZ0QHk
	 a5h2+rfUr8yvB4s2JvJiV3TjJJQjjmTYiv3y8i2jyTIREdfgCO9d8lClaXU31YpnjS
	 AuacBCA8hM+Vw==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alex Shi <alexs@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Borislav Petkov <bp@alien8.de>,
	Brian Cain <bcain@kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guo Ren <guoren@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Jonathan Corbet <corbet@lwn.net>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Hocko <mhocko@suse.com>,
	Michal Simek <monstr@monstr.eu>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Stafford Horne <shorne@gmail.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Vineet Gupta <vgupta@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Will Deacon <will@kernel.org>,
	x86@kernel.org,
	linux-alpha@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-mm@kvack.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-um@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev,
	sparclinux@vger.kernel.org
Subject: [PATCH 27/28] mm/hugetlb: drop hugetlb_cma_check()
Date: Sun, 28 Dec 2025 14:39:57 +0200
Message-ID: <20251228124001.3624742-28-rppt@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251228124001.3624742-1-rppt@kernel.org>
References: <20251228124001.3624742-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251228_044642_908379_5FE03DC7 
X-CRM114-Status: GOOD (  14.41  )
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

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

hugetlb_cma_check() was required when the ordering of hugetlb_cma_reserve()
and hugetlb_bootmem_alloc() was architecture depended.

Since hugetlb_cma_reserve() is always called before hugetlb_bootmem_alloc()
there is no need to check whether hugetlb_cma_reserve() was already called.

Drop unneeded hugetlb_cma_check() function.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/hugetlb.c     |  1 -
 mm/hugetlb_cma.c | 16 +++-------------
 mm/hugetlb_cma.h |  5 -----
 3 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 51273baec9e5..82b322ae3fdc 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4159,7 +4159,6 @@ static int __init hugetlb_init(void)
 		}
 	}
 
-	hugetlb_cma_check();
 	hugetlb_init_hstates();
 	gather_bootmem_prealloc();
 	report_hugepages();
diff --git a/mm/hugetlb_cma.c b/mm/hugetlb_cma.c
index b1eb5998282c..f5e79103e110 100644
--- a/mm/hugetlb_cma.c
+++ b/mm/hugetlb_cma.c
@@ -85,9 +85,6 @@ hugetlb_cma_alloc_bootmem(struct hstate *h, int *nid, bool node_exact)
 	return m;
 }
 
-
-static bool cma_reserve_called __initdata;
-
 static int __init cmdline_parse_hugetlb_cma(char *p)
 {
 	int nid, count = 0;
@@ -149,8 +146,10 @@ void __init hugetlb_cma_reserve(void)
 		return;
 
 	order = arch_hugetlb_cma_order();
-	if (!order)
+	if (!order) {
+		pr_warn("hugetlb_cma: the option isn't supported by current arch\n");
 		return;
+	}
 
 	/*
 	 * HugeTLB CMA reservation is required for gigantic
@@ -159,7 +158,6 @@ void __init hugetlb_cma_reserve(void)
 	 * breaking this assumption.
 	 */
 	VM_WARN_ON(order <= MAX_PAGE_ORDER);
-	cma_reserve_called = true;
 
 	hugetlb_bootmem_set_nodes();
 
@@ -253,14 +251,6 @@ void __init hugetlb_cma_reserve(void)
 		hugetlb_cma_size = 0;
 }
 
-void __init hugetlb_cma_check(void)
-{
-	if (!hugetlb_cma_size || cma_reserve_called)
-		return;
-
-	pr_warn("hugetlb_cma: the option isn't supported by current arch\n");
-}
-
 bool hugetlb_cma_exclusive_alloc(void)
 {
 	return hugetlb_cma_only;
diff --git a/mm/hugetlb_cma.h b/mm/hugetlb_cma.h
index 2c2ec8a7e134..78186839df3a 100644
--- a/mm/hugetlb_cma.h
+++ b/mm/hugetlb_cma.h
@@ -8,7 +8,6 @@ struct folio *hugetlb_cma_alloc_folio(int order, gfp_t gfp_mask,
 				      int nid, nodemask_t *nodemask);
 struct huge_bootmem_page *hugetlb_cma_alloc_bootmem(struct hstate *h, int *nid,
 						    bool node_exact);
-void hugetlb_cma_check(void);
 bool hugetlb_cma_exclusive_alloc(void);
 unsigned long hugetlb_cma_total_size(void);
 void hugetlb_cma_validate_params(void);
@@ -31,10 +30,6 @@ struct huge_bootmem_page *hugetlb_cma_alloc_bootmem(struct hstate *h, int *nid,
 	return NULL;
 }
 
-static inline void hugetlb_cma_check(void)
-{
-}
-
 static inline bool hugetlb_cma_exclusive_alloc(void)
 {
 	return false;
-- 
2.51.0


