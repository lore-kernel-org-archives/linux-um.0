Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8721ACCF9F1
	for <linux-um@archiver.kernel.org>; Tue, 28 Oct 2025 09:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=upK8e2DaCyurvlV2au3C3EMKO53/pyTE8SEh3elz5uk=; b=RL5k2otdV1zC+T0iW9uwNFunHf
	PKyQSuHEtzzPuWE08aft77UszrYzhyJEaBCzmUZC6MqRzL6m7I7wJuLOpWMyL+9bzktDc/ni4WOof
	9Gh2mSXe79lPemIC0sCp0cCeQnS5MWO1w9VqNQA44AVtqiKkz51W5oBPOYoLuVFFFJ9DAMWjk8RVC
	HV6dz1w9dDoUZKTyEckPx894BAId+q/6zcrCZB2HypvqacF549vQ9Jx5A1gchKXKWFVFezWKuYLk5
	vCasiYNgLMM8pZ849n9lZYU5svPH6wQmEH703X2T4oGak8LTY1InzUFGV0nGcGRTgfdLeE6G608yN
	8skq+bww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDfpc-0000000Fd8h-12m9;
	Tue, 28 Oct 2025 09:17:32 +0000
Received: from todd.t-8ch.de ([2a01:4f8:c010:41de::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDfpW-0000000Fd1O-1NRl
	for linux-um@lists.infradead.org;
	Tue, 28 Oct 2025 09:17:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1761643043;
	bh=dydLLqvv9GfPDw2CeThambI3wNtkxs7fMg/amODW+pI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=f4sGwxQZpk7mblNTexMQtkekFpAHFYAQrtXOCJ/5kdC9miO83xedGgFpC5+8P9VsD
	 FnkEQCobG/Fwu0j2tKtfV8f3JpnF1Hz1cZTD+BrsAXmsD1l2h2dNFnuz3Pn0az+5rg
	 deu3+/bnFxLedVyg7+dkWj1EMj8oZL0QouL3vCOI=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 28 Oct 2025 10:15:41 +0100
Subject: [PATCH 06/10] um: Remove fixaddr_user_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251028-uml-remove-32bit-pseudo-vdso-v1-6-e930063eff5f@weissschuh.net>
References: <20251028-uml-remove-32bit-pseudo-vdso-v1-0-e930063eff5f@weissschuh.net>
In-Reply-To: <20251028-uml-remove-32bit-pseudo-vdso-v1-0-e930063eff5f@weissschuh.net>
To: Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Kees Cook <kees@kernel.org>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761643036; l=3743;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=dydLLqvv9GfPDw2CeThambI3wNtkxs7fMg/amODW+pI=;
 b=FE436oxVhFe82l0jtHD/HvpcwSmrp0Hh5AuY180kd9J+qoZp3cVjbhqXIPrPYxLyuvokqHzrV
 9kUcalb4qCOBnlsULjIBymngzXQ+6WLimdvyCFPdni/Bql4qjjT7o2T
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251028_021727_886356_5CF5E86D 
X-CRM114-Status: UNSURE (   9.34  )
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

With the removal of the vDSO passthrough from the host,
FIXADDR_USER_START is always 0 and fixaddr_user_init() is dead code.

Remove it.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 arch/um/kernel/mem.c | 107 ---------------------------------------------------
 1 file changed, 107 deletions(-)

diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index dc938715ec9d..39c4a7e21c6f 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -84,109 +84,6 @@ void __init mem_init(void)
 	kmalloc_ok = 1;
 }
 
-#if IS_ENABLED(CONFIG_ARCH_REUSE_HOST_VSYSCALL_AREA)
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
-}
-#endif
-
 void __init paging_init(void)
 {
 	unsigned long max_zone_pfn[MAX_NR_ZONES] = { 0 };
@@ -199,10 +96,6 @@ void __init paging_init(void)
 
 	max_zone_pfn[ZONE_NORMAL] = high_physmem >> PAGE_SHIFT;
 	free_area_init(max_zone_pfn);
-
-#if IS_ENABLED(CONFIG_ARCH_REUSE_HOST_VSYSCALL_AREA)
-	fixaddr_user_init();
-#endif
 }
 
 /*

-- 
2.51.1.dirty


