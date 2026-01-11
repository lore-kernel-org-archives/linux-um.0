Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22530D2502E
	for <linux-um@archiver.kernel.org>; Sun, 11 Jan 2026 08:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mw+h00YB7RAVdP7poV7dkiSai2G6Gsw/ByEs2J3Zae8=; b=ZqLbxXc6xgYwG7HehHOQOhqmxG
	GL1/jECfU9wUUhIHiGR22dxZG2yw5vzIfJUEcVbdOAUoJUHMsL+cTzSIyU+G4f7XPMnIXYXtZH84w
	f6WBAekp7c89bKCMXQLWwqzfCgRF3MxODGd/a16owYoW721SfIALzIDmjvh1N1AKi/FEsJFFSM268
	/wF2Vf6OTdF4/jj6qXG1HpVIvvCoGUfEYURKCicLyorU0i6scQ0Fd1FAY7KSJYS5s2Dlb8anwOSZx
	39Qi0Y9pqWPGQm0YPvshsn6td3p2mr0gNGk9GlCSdm/TNLdcJANB7UjsThVi8P4G5Ovqr6FI6wL35
	/HsMlo6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1veqoX-000000041ej-3hxL;
	Sun, 11 Jan 2026 08:28:45 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1veqoV-000000041d6-3GIN;
	Sun, 11 Jan 2026 08:28:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 12DF960142;
	Sun, 11 Jan 2026 08:28:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 274D1C16AAE;
	Sun, 11 Jan 2026 08:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768120122;
	bh=HRLMNbJfcIyzccjy/sfTD1k/8iARayV6dPdQfJTMnWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ec2bGwWOeOjXW+ySUXXKPm6eayFRFkSmbxQ0Yi2N08exR6X1pcnRzRL1jFrEN60gu
	 EjR2EbdukWQDt0gz83zhTod3BcTK9hToNe52kcKWqr9xEFUT69+VRURPQ8b21IwNRd
	 rp3gC/u2WEVHsJheESwI5qHhh9E4BZZ1xav9luUXT439xB/CPrZE8H4fLmmGL8QILy
	 9Yfb6Y/uPZ+yYjsvo1Q90O2WW22H/avuDFr8cB76tUKXJ5Wsc0cale2xr++cTaYOu9
	 eji+2hoq7YT65edlzcRMhkEPeXUV9Ua93DTgqCtd5AaZJXvzgL4tJVCdJGBVI9moFu
	 uPmsuMV4ggZaw==
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
	Klara Modin <klarasmodin@gmail.com>,
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
	Ritesh Harjani <ritesh.list@gmail.com>,
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
Subject: [PATCH v3 29/29] Revert "mm/hugetlb: deal with multiple calls to hugetlb_bootmem_alloc"
Date: Sun, 11 Jan 2026 10:21:03 +0200
Message-ID: <20260111082105.290734-30-rppt@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260111082105.290734-1-rppt@kernel.org>
References: <20260111082105.290734-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This reverts commit d58b2498200724e4f8c12d71a5953da03c8c8bdf.

hugetlb_bootmem_alloc() is called only once, no need to check if it was
called already at its entry.

Other checks performed during HVO initialization are also no longer
necessary because sparse_init() that calls hugetlb_vmemmap_init_early()
and hugetlb_vmemmap_init_late() is always called after
hugetlb_bootmem_alloc().

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: Muchun Song <muchun.song@linux.dev>
---
 include/linux/hugetlb.h |  6 ------
 mm/hugetlb.c            | 12 ------------
 mm/hugetlb_vmemmap.c    | 11 -----------
 3 files changed, 29 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 08fc332e88a7..c8b1a6dd2d46 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -175,7 +175,6 @@ extern int sysctl_hugetlb_shm_group __read_mostly;
 extern struct list_head huge_boot_pages[MAX_NUMNODES];
 
 void hugetlb_bootmem_alloc(void);
-bool hugetlb_bootmem_allocated(void);
 extern nodemask_t hugetlb_bootmem_nodes;
 void hugetlb_bootmem_set_nodes(void);
 
@@ -1300,11 +1299,6 @@ static inline bool hugetlbfs_pagecache_present(
 static inline void hugetlb_bootmem_alloc(void)
 {
 }
-
-static inline bool hugetlb_bootmem_allocated(void)
-{
-	return false;
-}
 #endif	/* CONFIG_HUGETLB_PAGE */
 
 static inline spinlock_t *huge_pte_lock(struct hstate *h,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 82b322ae3fdc..e5a350c83d75 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4470,21 +4470,11 @@ void __init hugetlb_bootmem_set_nodes(void)
 	}
 }
 
-static bool __hugetlb_bootmem_allocated __initdata;
-
-bool __init hugetlb_bootmem_allocated(void)
-{
-	return __hugetlb_bootmem_allocated;
-}
-
 void __init hugetlb_bootmem_alloc(void)
 {
 	struct hstate *h;
 	int i;
 
-	if (__hugetlb_bootmem_allocated)
-		return;
-
 	hugetlb_bootmem_set_nodes();
 
 	for (i = 0; i < MAX_NUMNODES; i++)
@@ -4498,8 +4488,6 @@ void __init hugetlb_bootmem_alloc(void)
 		if (hstate_is_gigantic(h))
 			hugetlb_hstate_alloc_pages(h);
 	}
-
-	__hugetlb_bootmem_allocated = true;
 }
 
 /*
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 9d01f883fd71..a9280259e12a 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -794,14 +794,6 @@ void __init hugetlb_vmemmap_init_early(int nid)
 	struct huge_bootmem_page *m = NULL;
 	void *map;
 
-	/*
-	 * Noting to do if bootmem pages were not allocated
-	 * early in boot, or if HVO wasn't enabled in the
-	 * first place.
-	 */
-	if (!hugetlb_bootmem_allocated())
-		return;
-
 	if (!READ_ONCE(vmemmap_optimize_enabled))
 		return;
 
@@ -847,9 +839,6 @@ void __init hugetlb_vmemmap_init_late(int nid)
 	struct hstate *h;
 	void *map;
 
-	if (!hugetlb_bootmem_allocated())
-		return;
-
 	if (!READ_ONCE(vmemmap_optimize_enabled))
 		return;
 
-- 
2.51.0


