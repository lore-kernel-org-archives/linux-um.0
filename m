Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1921CC3DA4A
	for <linux-um@archiver.kernel.org>; Wed, 14 Aug 2024 15:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=33UCl0Co8i3PNxF7TNO2g0opNXJUnYgo70pV3HV1tcI=; b=BlxhiyAxGqSNe2/0rCAq24cEVr
	CkbzdkROO+t1RcWi01oGp5yoHX/H/7Ce7xCK5lb+GIDFQnRQF07naqqnINduFzDleeOjgwcbbVuTN
	mk2WQ8wN/zAXn5FHaWXEaC+YUYgNfOaNbBYnn6UCzKqGJczWbmmcHd0qVM0sWaPBvQ8ZsFBnl5mgI
	Oc5GNv8moErMw7YYT03BpjMN/zLNbWW3zPRBiBZji/+cumRGuxvAjimF2tvyRdVmBC/3tNqaF3U0z
	kAzNxvvxi2BnZlMLCM/fky8/cZoYDwrBWkZQttrqFctpUnh482ez5ae8Yazd/G846ZwaI6X5Wctgc
	SQAx8RFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seGBG-00000007WFX-2r3s;
	Wed, 14 Aug 2024 15:44:58 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seGAt-00000007W49-1g37
	for linux-um@bombadil.infradead.org;
	Wed, 14 Aug 2024 15:44:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=33UCl0Co8i3PNxF7TNO2g0opNXJUnYgo70pV3HV1tcI=; b=dIsNq+CQflIlXtOXmQTqb8pXRY
	oZqzwxIWI5YvxpP4/j2cyaUs/F+SRrHagsggKoL0vGKsexxHrjHORIlOlRnWyWreUtLEU384QLk7G
	9xy/Kq44WGvy3tBpQggevSL4bfHSCSHK+R+SUs/YM7Nq45lxf5DNRTk/qNcXE+6Z4ZtOpYtr7rcUD
	/NZqx1otFZnfV8ukq8ni6hn+tG1lztLatVpBF+aeWCIRciarfr/XjIMiMWU7tm+LCY2pCLlsCstZF
	6gTHeQMb7xlQmbogxzWyxViBZBTk2F5stHLfKgnMSLhKKvWud5/XOuKxAevKTe+B0jdBaHDVIDD/c
	JGh0gQFA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seGAs-00000000gHM-11f1;
	Wed, 14 Aug 2024 15:44:34 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-mm@kvack.org,
	linux-arch@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org
Subject: [PATCH 3/5] um: Remove custom definition of mk_pte()
Date: Wed, 14 Aug 2024 16:44:23 +0100
Message-ID: <20240814154427.162475-4-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240814154427.162475-1-willy@infradead.org>
References: <20240814154427.162475-1-willy@infradead.org>
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

Move the pfn_pte() definitions from the 2level and 3level files to
the generic pgtable.h, move the setting of newprot and newpage bits
into pfn_pte() and delete the custom definition of mk_pte() so that
we use the central definition.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/um/include/asm/pgtable-2level.h |  1 -
 arch/um/include/asm/pgtable-3level.h |  9 ---------
 arch/um/include/asm/pgtable.h        | 17 ++++++++++-------
 3 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/arch/um/include/asm/pgtable-2level.h b/arch/um/include/asm/pgtable-2level.h
index 8256ecc5b919..2be7ba470abb 100644
--- a/arch/um/include/asm/pgtable-2level.h
+++ b/arch/um/include/asm/pgtable-2level.h
@@ -37,7 +37,6 @@ static inline void pgd_mkuptodate(pgd_t pgd)	{ }
 #define set_pmd(pmdptr, pmdval) (*(pmdptr) = (pmdval))
 
 #define pte_pfn(x) phys_to_pfn(pte_val(x))
-#define pfn_pte(pfn, prot) __pte(pfn_to_phys(pfn) | pgprot_val(prot))
 #define pfn_pmd(pfn, prot) __pmd(pfn_to_phys(pfn) | pgprot_val(prot))
 
 #endif
diff --git a/arch/um/include/asm/pgtable-3level.h b/arch/um/include/asm/pgtable-3level.h
index 8a5032ec231f..20870be83cfa 100644
--- a/arch/um/include/asm/pgtable-3level.h
+++ b/arch/um/include/asm/pgtable-3level.h
@@ -82,15 +82,6 @@ static inline unsigned long pte_pfn(pte_t pte)
 	return phys_to_pfn(pte_val(pte));
 }
 
-static inline pte_t pfn_pte(unsigned long page_nr, pgprot_t pgprot)
-{
-	pte_t pte;
-	phys_t phys = pfn_to_phys(page_nr);
-
-	pte_set_val(pte, phys, pgprot);
-	return pte;
-}
-
 static inline pmd_t pfn_pmd(unsigned long page_nr, pgprot_t pgprot)
 {
 	return __pmd((page_nr << PAGE_SHIFT) | pgprot_val(pgprot));
diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
index 5bb397b65efb..6ecc4c4ffeab 100644
--- a/arch/um/include/asm/pgtable.h
+++ b/arch/um/include/asm/pgtable.h
@@ -292,13 +292,16 @@ static inline int pte_same(pte_t pte_a, pte_t pte_b)
 #define page_to_phys(page) pfn_to_phys(page_to_pfn(page))
 #define virt_to_page(addr) __virt_to_page((const unsigned long) addr)
 
-#define mk_pte(page, pgprot) \
-	({ pte_t pte;					\
-							\
-	pte_set_val(pte, page_to_phys(page), (pgprot));	\
-	if (pte_present(pte))				\
-		pte_mknewprot(pte_mknewpage(pte));	\
-	pte;})
+static inline pte_t pfn_pte(unsigned long pfn, pgprot_t pgprot)
+{
+	pte_t pte;
+
+	pte_set_val(pte, pfn * PAGE_SIZE, pgprot);
+	if (pte_present(pte))
+		pte_mknewprot(pte_mknewpage(pte));
+
+	return pte;
+}
 
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
-- 
2.43.0


