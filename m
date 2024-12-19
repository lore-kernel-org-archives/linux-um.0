Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EBD5E7718B
	for <linux-um@archiver.kernel.org>; Thu, 19 Dec 2024 16:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t3fKHZ/NfJbP47FxINHB8YXuPoD7xscOU0RHBymSX5Y=; b=1nsczDpzvgZDskYz9hC6/0HeYh
	6obRmjA3UFyIt1GhVemeon/qN2+CBd4J47r+i0ThXvITa4Pw65OzdotsFDZZElEeoIU9bpA+C1Pbh
	7+PpHTmsGq8SgwxY8SU+iHq+ybKNlzQ3h0rEO7hO23tNo/BXVme5stXgYjd1giqO+rCCTLorAKykA
	cy2s4S1Y2qcrhKb/kOkkLXm6atSMu+862rstGZgSrvnD4j4hI1elVdhntjdxli68N14VGUOEt5OPT
	W9IOFwN8nHGKov2vwracVXvjMi4d6L85IB3ao7gK7bk1VxQipwJ36kmoot7l+q4gAgHVrRCUoXeWM
	d1vFY+uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tOJoX-00000002Rz9-0EsC;
	Thu, 19 Dec 2024 16:55:53 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tOJfh-00000002PWE-02wF;
	Thu, 19 Dec 2024 16:46:46 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC7B11480;
	Thu, 19 Dec 2024 08:47:12 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB7743F58B;
	Thu, 19 Dec 2024 08:46:40 -0800 (PST)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-mm@kvack.org
Cc: Kevin Brodsky <kevin.brodsky@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Will Deacon <will@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	linux-alpha@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-um@lists.infradead.org,
	loongarch@lists.linux.dev,
	x86@kernel.org
Subject: [PATCH 08/10] ARM: mm: Rename PGD helpers
Date: Thu, 19 Dec 2024 16:44:23 +0000
Message-ID: <20241219164425.2277022-9-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241219164425.2277022-1-kevin.brodsky@arm.com>
References: <20241219164425.2277022-1-kevin.brodsky@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241219_084645_096284_2C7F7EEC 
X-CRM114-Status: UNSURE (   9.85  )
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

Generic implementations of __pgd_alloc and __pgd_free are about to
be introduced. Rename the macros in arch/arm/mm/pgd.c to avoid
clashes. While we're at it, also pass down the mm as argument to
those helpers, as it will be needed to call the generic
__pgd_{alloc,free}.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm/mm/pgd.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mm/pgd.c b/arch/arm/mm/pgd.c
index f8e9bc58a84f..2a1077747758 100644
--- a/arch/arm/mm/pgd.c
+++ b/arch/arm/mm/pgd.c
@@ -17,11 +17,11 @@
 #include "mm.h"
 
 #ifdef CONFIG_ARM_LPAE
-#define __pgd_alloc()	kmalloc_array(PTRS_PER_PGD, sizeof(pgd_t), GFP_KERNEL)
-#define __pgd_free(pgd)	kfree(pgd)
+#define _pgd_alloc(mm)		kmalloc_array(PTRS_PER_PGD, sizeof(pgd_t), GFP_KERNEL)
+#define _pgd_free(mm, pgd)	kfree(pgd)
 #else
-#define __pgd_alloc()	(pgd_t *)__get_free_pages(GFP_KERNEL, 2)
-#define __pgd_free(pgd)	free_pages((unsigned long)pgd, 2)
+#define _pgd_alloc(mm)		(pgd_t *)__get_free_pages(GFP_KERNEL, 2)
+#define _pgd_free(mm, pgd)	free_pages((unsigned long)pgd, 2)
 #endif
 
 /*
@@ -35,7 +35,7 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 	pmd_t *new_pmd, *init_pmd;
 	pte_t *new_pte, *init_pte;
 
-	new_pgd = __pgd_alloc();
+	new_pgd = _pgd_alloc(mm);
 	if (!new_pgd)
 		goto no_pgd;
 
@@ -134,7 +134,7 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 no_pud:
 	p4d_free(mm, new_p4d);
 no_p4d:
-	__pgd_free(new_pgd);
+	_pgd_free(mm, new_pgd);
 no_pgd:
 	return NULL;
 }
@@ -207,5 +207,5 @@ void pgd_free(struct mm_struct *mm, pgd_t *pgd_base)
 		p4d_free(mm, p4d);
 	}
 #endif
-	__pgd_free(pgd_base);
+	_pgd_free(mm, pgd_base);
 }
-- 
2.47.0


