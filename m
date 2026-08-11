Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64CA4C5B56A
	for <linux-um@archiver.kernel.org>; Tue, 11 Aug 2026 04:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EI5j2f3e0rorVshjGDKXnzZx89bDqNn4XV41gU2IJnw=; b=sjxSFUWYeK25xNwcy+xEeqam2S
	wl/fDDXalqqXaVWFcaKxqUvGLMQEObOvV9eu1i3RnBez7PU/rvfyOBePysMG5erXEVDiAFJZlBeAt
	sXZW156qGTrIl7ruL3EXd9Kui1sjp3Jm+QhQBBsIlRAy/KPOUc/26cCX0sHMRE5rFzmRF1RbJl9wN
	kGaTu3Ben7dUNLqtl4gTk4CmQ/mrVdZ9zif8oRtR46dAOGFBiFXcHvPxgr9hVocDT2C3c3ntEv/yK
	X3df2mZG+HbqbYNaqJ+fTlI4DYPnO/VUziHLi1i1crq5sxUziEQjN1zzKcJh2BHiLohGbXfgNp07G
	FFiTa2KA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtdzn-0000000DG0h-0B8j;
	Tue, 11 Aug 2026 04:21:47 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtdzd-0000000DFoT-3C9Z;
	Tue, 11 Aug 2026 04:21:39 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05D0F1688;
	Mon, 10 Aug 2026 21:21:32 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3BCE93F673;
	Mon, 10 Aug 2026 21:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786422095; bh=pfMAQ/GDECbmwo/qWefWNRsbphdRQF7xgYQeIgh1v4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eWCiC7xg6Urch6e/NkyTz2nx1jVxQ2+lXNNVl32VkpGHIvNOZKoKK7OwvEvBfhSEE
	 wJbBJKEACAKzuY3XWRWmEiavQBuGK0AQKUazXEqU1d31lkT1Spev7terS8Toxwdnjv
	 EicAFdP1tvM9H1F3vee9RdSt/Ezcn1ReEpkjAW58=
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org,
	akpm@linux-foundation.org,
	david@kernel.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC V2 3/6] sh/mm: Stop using pte_ERROR()
Date: Tue, 11 Aug 2026 09:51:16 +0530
Message-ID: <20260811042119.3652929-4-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260811042119.3652929-1-anshuman.khandual@arm.com>
References: <20260811042119.3652929-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260810_212137_965239_19C2D310 
X-CRM114-Status: UNSURE (   9.18  )
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

Directly use pr_err() in set_pte_phys() and drop pte_ERROR() which helps in
eventually dropping pte_ERROR() macro across the tree. In this new printing
__FILE__ and __LINE__ has been dropped because they are always the same and
don't really add any value.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/sh/include/asm/pgtable_32.h |  5 -----
 arch/sh/mm/init.c                | 11 ++++++++++-
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/sh/include/asm/pgtable_32.h b/arch/sh/include/asm/pgtable_32.h
index 5f51af18997b..c8eb9a7a4c4c 100644
--- a/arch/sh/include/asm/pgtable_32.h
+++ b/arch/sh/include/asm/pgtable_32.h
@@ -401,14 +401,9 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 #define pmd_page(pmd)		(virt_to_page(pmd_val(pmd)))
 
 #ifdef CONFIG_X2TLB
-#define pte_ERROR(e) \
-	printk("%s:%d: bad pte %p(%08lx%08lx).\n", __FILE__, __LINE__, \
-	       &(e), (e).pte_high, (e).pte_low)
 #define pgd_ERROR(e) \
 	printk("%s:%d: bad pgd %016llx.\n", __FILE__, __LINE__, pgd_val(e))
 #else
-#define pte_ERROR(e) \
-	printk("%s:%d: bad pte %08lx.\n", __FILE__, __LINE__, pte_val(e))
 #define pgd_ERROR(e) \
 	printk("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, pgd_val(e))
 #endif
diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index 110308bdef01..b3c7fd84ceb4 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -78,13 +78,22 @@ static pte_t *__get_pte_phys(unsigned long addr)
 	return pte_offset_kernel(pmd, addr);
 }
 
+static void print_bad_pte(pte_t pte)
+{
+#ifdef CONFIG_X2TLB
+	printk("bad pte %p(%08lx%08lx).\n", &pte, pte.pte_high, pte.pte_low);
+#else
+	printk("bad pte %08lx.\n", pte_val(pte));
+#endif
+}
+
 static void set_pte_phys(unsigned long addr, unsigned long phys, pgprot_t prot)
 {
 	pte_t *pte;
 
 	pte = __get_pte_phys(addr);
 	if (!pte_none(*pte)) {
-		pte_ERROR(*pte);
+		print_bad_pte(*pte);
 		return;
 	}
 
-- 
2.43.0


