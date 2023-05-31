Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA42C7EE37
	for <linux-um@archiver.kernel.org>; Wed, 31 May 2023 21:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6WEOc55WV1jU8RIPrBAXmIwjq2ufVFYFMto+y7PHO+E=; b=1rtHEi8+P2PKUj
	d3H5uWa2XH7k3FIk999lOBkaz3NiaAAvWmfoHv1acsL7r6KHyT0j/yZzH5EnwfVFl2x0XxTCQ3iUv
	ZfQbHJ4PfS+aTQsOZTqsS2XGcg7Vzam9cGMpGZTlVUDTsJQtiW/GSN+AiYIDWFCPZvIFJOEXVyoEk
	0xvg8tNp5BWlP9HEhcLCgZsxQf3COZcomAilruOFWGDrvKi8YRizHTUhtvqeAVYlyXvuSjRWD9Tr1
	tK74BLa8nswBZ0Pev2Mj4gF429Mk2GuznqVlwJt1lpZkt0pt68iriS//OGFnjhhoDrVGEGcHJQPE5
	Hp7KlY7rAKUkTsPSqJuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4TRj-001BEb-24;
	Wed, 31 May 2023 21:33:31 +0000
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4TQR-001AGH-0V;
	Wed, 31 May 2023 21:32:12 +0000
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-565ba6aee5fso826927b3.1;
        Wed, 31 May 2023 14:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685568731; x=1688160731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1GRmBDGAiDB5ohg5xpMsC/Ie0xVPC3qwwrjfZtpy6VU=;
        b=TzIQcYP8UmEvu1XoUXTmQnAashbo2T6eYaCRckVyeMmLMro7gHhzasHCkMcWFCcICP
         qASPopGO4jPsUUoq2oo54YJvtjYAvzC57SSS0Yqri4mv3NjvTdLMSdkLvvM7oA4Ee24y
         wtM1hRp99610fYgP6iNO/jZdKl6qkgz0kh/qsgBmVzQ/w0d6rCW5SOQFK0BhVT7CHUOG
         qPxfe0g3o4O3N6ywZpv0i38BDLHQS9YQOgCA2owyv5y3xv1tuRhfQmBHrNK0am7f5K2A
         BF7Ua5SoJjDL0sDtWpclX2w1tSSbohGXIW608mTIM4bjGCvoZIGoxKxNqCAe4MAT2CZW
         ovbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685568731; x=1688160731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1GRmBDGAiDB5ohg5xpMsC/Ie0xVPC3qwwrjfZtpy6VU=;
        b=mCF0uNAlU27NSKtjJkV0V+Cn9YaU2IP9ZWLTfQeIkhS4eiDzsanyftnFLs9jKNBYaJ
         fKUoutzHCB8HDjwIB4Q8i5wXYVej+3gKR7qVMaGVD8lN4sUBRJnb5Z+l1yFBMV3zmsLl
         mpCcHVnN08j+V0TsYEn9CdGs9BeoCfsnD6DV3u1QKcc3+IbUVtRAHiqAyRBmA1N3Rdgl
         LBttG2gXqT/miZYcQYepRCOz5YMnlZ6Ll8gQGyg+PrLpk4yj2xNW2F92so0ZJfIzIWlW
         Tm5HjKiTUEKZj4Wl6xDTG6qZrrr4J8QnWfleBwkZNWU9DQOilDCbqoS86DJKXO+cYWQf
         wP2Q==
X-Gm-Message-State: AC+VfDz4I56jfZRXUYSEEpnb4UGIpcT1Uye0hQ8KIT6vMmkohuTEKx6s
	f1ocv1KI+/ra4bujMkHnm9c=
X-Google-Smtp-Source: ACHHUZ5LYpeqVXEBxKdhnKxPXFX2lgcS9ekTnfnLE12pRifhXXzQCAWJFiLd7o1EIw9HUUaJU74F+Q==
X-Received: by 2002:a0d:e24d:0:b0:561:949d:a7fd with SMTP id l74-20020a0de24d000000b00561949da7fdmr7343037ywe.45.1685568730646;
        Wed, 31 May 2023 14:32:10 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::46])
        by smtp.googlemail.com with ESMTPSA id t63-20020a0dd142000000b0055aafcef659sm658905ywd.5.2023.05.31.14.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 14:32:10 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	xen-devel@lists.xenproject.org,
	kvm@vger.kernel.org,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH v3 31/34] sparc64: Convert various functions to use ptdescs
Date: Wed, 31 May 2023 14:30:29 -0700
Message-Id: <20230531213032.25338-32-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531213032.25338-1-vishal.moola@gmail.com>
References: <20230531213032.25338-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230531_143211_196393_2DC57791 
X-CRM114-Status: GOOD (  12.49  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

As part of the conversions to replace pgtable constructor/destructors with
ptdesc equivalents, convert various page table functions to use ptdescs.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/sparc/mm/init_64.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 04f9db0c3111..8a1618c3b435 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2893,14 +2893,15 @@ pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
 
 pgtable_t pte_alloc_one(struct mm_struct *mm)
 {
-	struct page *page = alloc_page(GFP_KERNEL | __GFP_ZERO);
-	if (!page)
+	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL | __GFP_ZERO, 0);
+
+	if (!ptdesc)
 		return NULL;
-	if (!pgtable_pte_page_ctor(page)) {
-		__free_page(page);
+	if (!pagetable_pte_ctor(ptdesc)) {
+		pagetable_free(ptdesc);
 		return NULL;
 	}
-	return (pte_t *) page_address(page);
+	return (pte_t *) ptdesc_address(ptdesc);
 }
 
 void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
@@ -2910,10 +2911,10 @@ void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 
 static void __pte_free(pgtable_t pte)
 {
-	struct page *page = virt_to_page(pte);
+	struct ptdesc *ptdesc = virt_to_ptdesc(pte);
 
-	pgtable_pte_page_dtor(page);
-	__free_page(page);
+	pagetable_pte_dtor(ptdesc);
+	pagetable_free(ptdesc);
 }
 
 void pte_free(struct mm_struct *mm, pgtable_t pte)
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
