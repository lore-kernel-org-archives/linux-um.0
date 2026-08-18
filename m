Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6740AC5DF7E
	for <linux-um@archiver.kernel.org>; Tue, 18 Aug 2026 04:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=omDZX1bufOD81zOaJjwGdpJ6E7g6fPFvf2RST58oZaE=; b=C/1btkOtnrVXczneAGO2ypLl4Y
	zIWuyW0fjgfDAB3rPYsavsfmWXnoS43P4wOw51T6Q3cCx+8FSXb2hq3NGS5PcrDnNbnCESfJm6Lit
	RsmyDFhaKmgkNvH+Y7LNj+cnPyQffixGKcRYlluXARdX07j0WPyttq/OY97nmzRUdT6/4r5qXrqtB
	NUTNq47cV/2Mrvx2fTpDVNt4K3en3c+2zYQgan3jpGQAGyFQdMt82XQqKykqZCEgwW3OIP4A5z48S
	qZyDcu4/kiZMSV272W4uPm4kvbUu8kmz+lG3FP1xzC8F5jiULMLrz9x8Y84BuaImXsQw0jO1ShBUb
	mrpbWW4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwB1J-00000007F1J-3SnY;
	Tue, 18 Aug 2026 04:01:49 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwB0e-00000007EIQ-3AEY;
	Tue, 18 Aug 2026 04:01:41 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFC681A00;
	Mon, 17 Aug 2026 21:01:03 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E3D303F66F;
	Mon, 17 Aug 2026 21:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787025667; bh=fvWsPm2RhovRhyeQja3vObvDm/dQnZu4xzhWldyViFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mayvk+7YyBI2v2eqdqjZoS2Z0dSe2CBNgITCjGmuVovDxkhyBaxSP1dLk5kNH1nez
	 idT86Nq/jZBkUaXw0freV4r8tdOSXnkHA9v9bqHpKf4rUtAsLWC+ksnp8Cx/gdMRyF
	 17IZ3guv1INHQU+zfmWJE2RLFpqbe6NzJqmu5VKg=
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
Subject: [RFC V3 6/8] sh/mm: Stop using [p4d|pud|pmd]_ERROR()
Date: Tue, 18 Aug 2026 09:30:39 +0530
Message-ID: <20260818040041.1891769-7-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818040041.1891769-1-anshuman.khandual@arm.com>
References: <20260818040041.1891769-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260817_210108_857983_2734F710 
X-CRM114-Status: UNSURE (   8.25  )
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
Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Changes in RFC V3

- Added some pr_error() messages in __get_pte_phys()

 arch/sh/mm/init.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index 9466ae6f9f16..8d65e60688dc 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -59,19 +59,19 @@ static pte_t *__get_pte_phys(unsigned long addr)
 
 	p4d = p4d_alloc(NULL, pgd, addr);
 	if (unlikely(!p4d)) {
-		p4d_ERROR(*p4d);
+		pr_err("allocating p4d table failed\n");
 		return NULL;
 	}
 
 	pud = pud_alloc(NULL, p4d, addr);
 	if (unlikely(!pud)) {
-		pud_ERROR(*pud);
+		pr_err("allocating pud table failed\n");
 		return NULL;
 	}
 
 	pmd = pmd_alloc(NULL, pud, addr);
 	if (unlikely(!pmd)) {
-		pmd_ERROR(*pmd);
+		pr_err("allocating pmd table failed\n");
 		return NULL;
 	}
 
-- 
2.43.0


