Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 094F5C5B570
	for <linux-um@archiver.kernel.org>; Tue, 11 Aug 2026 04:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=poodNdxA7WPULNKhYdttvzFWmhwiFf+VlcVKFtQPX94=; b=hkYkQnvnjs55sLYzLo0SZlL68k
	DtvQrfdZauhxSjnQewUcBKTf8KcK4gHoS/OfdzmE/ZoDnn4vlecbRCQIvkQDo8t97rHPjKepsV0Kg
	E4D/Y4MgQB5Ht8xBUr5cJW5eGgvxkh6cVnRPEzx2dyXuzMIaj0gr6WXG8r2rk2lbWbSbeg2RElofk
	4a7OA9yF6RbgsFy+KYOjr/km4R/uxec/9TZfaX5ILGOg6PQAR0SlTt+K6fHbh6p2Z8qohDiL/PRh7
	2WtVBTb9Ul3r6YNsuiGjX/dkeI4MGekjy8wMdkztviJoqz6yIlkk+pNlgmJEwY4T8p/bVpeQnls6F
	vkJkaXAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtdzn-0000000DG28-26Oc;
	Tue, 11 Aug 2026 04:21:47 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtdzj-0000000DFwY-0yVG;
	Tue, 11 Aug 2026 04:21:45 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 977B6168F;
	Mon, 10 Aug 2026 21:21:35 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD6F33F673;
	Mon, 10 Aug 2026 21:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786422099; bh=OKKk+J7eMHIWw8QjhuEJW1LEtsSDjKpxvNzpv83/ug8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NDnTBVj22FStQ+XK0HLwvJKJro3KeX1TWQm5rzPJ0S7csuqOhawi++Hc637b87GPD
	 Hvinpr7iTMbSodkYtTOTqdZ/yXYwlvbKLRTdNZffXQArm0ptKBDdXtxSDLXybURVE7
	 0SmAxajLRK1u+03/uA3LFe6J/WvE1OGUYKFOsK0Q=
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
Subject: [RFC V2 4/6] sh/mm: Stop using [p4d|pud|pmd]_ERROR()
Date: Tue, 11 Aug 2026 09:51:17 +0530
Message-ID: <20260811042119.3652929-5-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260811042119.3652929-1-anshuman.khandual@arm.com>
References: <20260811042119.3652929-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260810_212143_327763_FA5A2B39 
X-CRM114-Status: UNSURE (   7.94  )
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

Stop using [p4d|pud|pmd]_ERROR() in __get_pte_phys() as the pgtable entries
are known to be NULL and hence could not really be accessed.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/sh/mm/init.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index b3c7fd84ceb4..0bb8555568a4 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -58,22 +58,16 @@ static pte_t *__get_pte_phys(unsigned long addr)
 	}
 
 	p4d = p4d_alloc(NULL, pgd, addr);
-	if (unlikely(!p4d)) {
-		p4d_ERROR(*p4d);
+	if (unlikely(!p4d))
 		return NULL;
-	}
 
 	pud = pud_alloc(NULL, p4d, addr);
-	if (unlikely(!pud)) {
-		pud_ERROR(*pud);
+	if (unlikely(!pud))
 		return NULL;
-	}
 
 	pmd = pmd_alloc(NULL, pud, addr);
-	if (unlikely(!pmd)) {
-		pmd_ERROR(*pmd);
+	if (unlikely(!pmd))
 		return NULL;
-	}
 
 	return pte_offset_kernel(pmd, addr);
 }
-- 
2.43.0


