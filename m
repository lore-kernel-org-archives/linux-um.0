Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 176D6E92725
	for <linux-um@archiver.kernel.org>; Sun, 28 Dec 2025 12:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OA0kYSCHWPTEWVF3qtan8c1YW24ugV0bVMLBsJ5bJns=; b=ImePd1hww+tbmuylF4Z36HAj0p
	b1XPoi5DVgsLIPC3EOOPeSt1unJmEqCP9TXlgPAWPa0+Fm+GTkIStqyMVJHVSj1/al4shM0+LYTa2
	cJWsC4iZpWQ/XTFmHlxBy5BVGfu2wR6tt9uEXsKiOrB19Kmjhzi7M2IzvUHmMkj+ZcivxKalGtoMw
	wW0u7yBLlbMbY4PMQMFYdFzXL85jgAKkC7CBNgs0ktzYW2xSISoEGAJc1t0WwJ9451IbIsF5jWk8B
	20IpE11Cur7m4bM9kwd4/7011GTMhqBjLe1t/qaWuus5R776zeXgDSU+E2o1Cp8qckCNUN/MGewf1
	Cb1JD1qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZqAm-00000002kZT-3TmK;
	Sun, 28 Dec 2025 12:47:00 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZqAj-00000002kW1-1veU;
	Sun, 28 Dec 2025 12:46:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 77B79600AA;
	Sun, 28 Dec 2025 12:46:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9132C4CEFB;
	Sun, 28 Dec 2025 12:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766926016;
	bh=zJEIy7O/CTkdhQmMkACZcULIRougkhyexygWc4ZDAXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CUM35TWv/cMbcrOeR73n+XHNIa0BmyPC6QF36LaL20Yna6xWY0BSLgjEuB9NNQVFs
	 xNgPahJssiqOsbE9daKLMR7RnvAjtHzSJrJwXaBKr1VZ2hmtoHuKqqj/Ei3WWyVnyR
	 Wh9FJBMTwNv7vmoGVNVBHufARIfuWEgzOKFYbpxpdKPvSpUfd7Cv9IO1T53Wmkuk0g
	 eTkgXuXNAJmvtbrLMYLsdFLyK5kO0YcuaWIYnLXROnMlWOeCSui3e7muw2Lh0uwkGX
	 kMLPW+nF7Pn138We0BaiaTiOz67ixNks7n7EVEQ8aFn6s9NF7PTZZssQ5hCt3c+BXR
	 5rgqGKWhVXizA==
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
Subject: [PATCH 28/28] Revert "mm/hugetlb: deal with multiple calls to hugetlb_bootmem_alloc"
Date: Sun, 28 Dec 2025 14:39:58 +0200
Message-ID: <20251228124001.3624742-29-rppt@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251228124001.3624742-1-rppt@kernel.org>
References: <20251228124001.3624742-1-rppt@kernel.org>
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

hugetlb_bootmem_alloc() is called only once, no need to check if it was
called aready at its entry.

Other checks performed during HVO initialization are also no longer
necessary because sparse_init() that calls hugetlb_vmemmap_init_early()
and hugetlb_vmemmap_init_late() is alaways called after
hugetlb_bootmem_alloc().

This reverts commit d58b2498200724e4f8c12d71a5953da03c8c8bdf.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
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


