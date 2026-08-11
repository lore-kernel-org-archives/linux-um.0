Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B4AC5B570
	for <linux-um@archiver.kernel.org>; Tue, 11 Aug 2026 04:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9156elYbVcgOVBUlBcK8KwHSuT6KmfcOY4PjQv80+WU=; b=mM+bOwsOSZFwZu+2LP713vYiY3
	bGbDLILxUbGdW3PlYd1blpdkFP11wr9vrrPh1QU0qBMuVr9P7/nUTyWZLXHl/DdsSZjWfHiGicRFQ
	kb8idAVsBXIC7VXCAvW432tCX0mghyB+KcukzHjE4cjPEs72XvIdM1C//vyg7Jq+S2NWJV84O6K+y
	recbNIB98STqgknq80p1DShFs1INQm5fo78UOsiTWVneSEnwCwIfF1sriPO4RRbh103npld9ANiwI
	TM9FSkrr8y56d36O6sVlKe7U0bRYpOOYete73eeYX7mrR/pSKYugKRpXrAeEgFzZI5aBLoU/7CUWF
	RVgLVASA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtdzc-0000000DFnM-1TNz;
	Tue, 11 Aug 2026 04:21:36 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtdzX-0000000DFlH-0LVd;
	Tue, 11 Aug 2026 04:21:35 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB1921682;
	Mon, 10 Aug 2026 21:21:24 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D93B3F673;
	Mon, 10 Aug 2026 21:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786422088; bh=seDKsmiMOMrdwfylVhhzaffw4o0OcF7YTjTN6FBF/F4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KC7mBJJ7KWVH6Grb7zUC3NdpCyV/h1uPp7PTSBIuRmm8PBZZS6xTMV8rQbmBcb0+k
	 CrFwokBxCYlG/gET0eDkNie78MI7Otgx+fDNF63nC3bpTuLMTOYV0FYW/FoKzOsWXt
	 +rPreTXul9plA9OwBjRX3iIHmzyFZ4yyGIp2Yfrw=
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
Subject: [RFC V2 1/6] loongarch/mm: Stop using pte_ERROR()
Date: Tue, 11 Aug 2026 09:51:14 +0530
Message-ID: <20260811042119.3652929-2-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260811042119.3652929-1-anshuman.khandual@arm.com>
References: <20260811042119.3652929-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260810_212131_172268_0DA4A699 
X-CRM114-Status: UNSURE (   9.98  )
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

Directly use pr_err() in __set_fixmap() and drop pte_ERROR() which helps in
eventually dropping pte_ERROR() macro across the tree. In this new printing
__FILE__ and __LINE__ has been dropped because they are always the same and
don't really add any value.

Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: loongarch@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/loongarch/include/asm/pgtable.h | 2 --
 arch/loongarch/mm/init.c             | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
index 223528c04d73..a32a8fff70c1 100644
--- a/arch/loongarch/include/asm/pgtable.h
+++ b/arch/loongarch/include/asm/pgtable.h
@@ -128,8 +128,6 @@ struct vm_area_struct;
 #define ptep_get(ptep) READ_ONCE(*(ptep))
 #define pmdp_get(pmdp) READ_ONCE(*(pmdp))
 
-#define pte_ERROR(e) \
-	pr_err("%s:%d: bad pte %016lx.\n", __FILE__, __LINE__, pte_val(e))
 #ifndef __PAGETABLE_PMD_FOLDED
 #define pmd_ERROR(e) \
 	pr_err("%s:%d: bad pmd %016lx.\n", __FILE__, __LINE__, pmd_val(e))
diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
index 3407030f3e7a..be9b127daef2 100644
--- a/arch/loongarch/mm/init.c
+++ b/arch/loongarch/mm/init.c
@@ -203,7 +203,7 @@ void __init __set_fixmap(enum fixed_addresses idx,
 
 	ptep = populate_kernel_pte(addr);
 	if (!pte_none(ptep_get(ptep))) {
-		pte_ERROR(*ptep);
+		pr_err("bad pte %016lx\n", pte_val(*ptep));
 		return;
 	}
 
-- 
2.43.0


