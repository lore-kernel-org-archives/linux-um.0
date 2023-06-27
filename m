Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75CEBEB64DD
	for <linux-um@archiver.kernel.org>; Tue, 27 Jun 2023 03:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7ad8amYvZsePfvXywWgG8TUbn/SxCAFzV0Jv+QGgwkM=; b=QK4JYKHwHE+HbG
	wgOCjQEq+vDt1kMhg5kSOetx0IrvSv1MEHu5y4uRPvXf5SrlDbA7a5zW9jEYveyAB8F9Pbpm8PbVg
	BEkEHDLl1X7Z2fVP8x3sZmRdl0TQjHmrmPa410S3nlMCL2yt7kv7rS18CVhFpnxotmiMyYxRGHrf1
	lI5ef97UEegmowYYLFn996Swb0CuixfK597AtV7lY4JbyLGIqc5zXQ6Cewx08Ed/1HtzhCN8mwhnS
	U3rQGUC54BF78rVsapBQe20mAmxMKPtN/uNK/1AfKehytEgLmv5Uu8DYAL1jhfDZEVzNxqhzmmq/8
	raF8FFCQSPWSkXsqqUyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qDzEe-00BZA7-2s;
	Tue, 27 Jun 2023 03:19:20 +0000
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qDzBc-00BWL6-0m;
	Tue, 27 Jun 2023 03:16:15 +0000
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-57026f4bccaso42392317b3.2;
        Mon, 26 Jun 2023 20:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687835771; x=1690427771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2x+E7/HO6cxS1FKNHsH+YAjV99GeoJ7wX0XOkEEtc8g=;
        b=PChVo0lfe7Am1Juwq3iG7RGGrP0XqVtToprVlSbVPrmyTboyAd49pm1+evSB9B2tFw
         kXjlu6Q/E8ApcKDqDyfQ8SExeWZmFlXQXipKcu1XJWfNM69YhOWXhf3ISbUTXIBhFgb0
         96QCzhEZra+XSmonTSpvrhyWNfhcBtgM1hIeMstisaUf5aqytakahkQIURxFAuMmzadV
         6ZXbtsztDtfR61NxP+OmIDHBWYbrG0Ze8ny7+vi6zis0kg+kLkgyVN6ua8e4P9XYJM+O
         StKP4NZwkZwEtlTvPnxWtxrHSt+7T/pJDNCTHMVfEfjXHYKpAk/tbkRioOk7ft8zrct2
         Kzpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687835771; x=1690427771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2x+E7/HO6cxS1FKNHsH+YAjV99GeoJ7wX0XOkEEtc8g=;
        b=OPc+XgynmWVtOHncyKstweY3ZkloKS6+FMDLp+25+rJeb/Bf0nDliy6Kj0ub6PALUi
         XVGgM0pzLh5mtPFaVx43EjAaSagZOgg8r4PxnhwqrXhzx+Zky3jbqHXpSwT6bKTrPlfz
         9EKYOB2Fz3te41vTR2skD15TzPryJ96QdOc7+TTS4IbhOjLLl5gDziZPVAtDZrPExpLJ
         Mimia7Mspc3qavTUrdkxNZ+1gmE1Fm2GdUlUzdsqgChjmNV1NXjEIm6nH/hfIC4FxNQb
         4b6a1RcvLtlbygkSDGTMls7PH6IHxQf+ctR9c8GAowu0woLthw3k/Srv/eCBrn61kJL6
         OtUg==
X-Gm-Message-State: AC+VfDyisoKcmPDzStxVExTVevRwpm5zCAyzT2aZJovyMqPA2O2e+h3+
	sbFdtLimajj8jvNM/lI5sPw=
X-Google-Smtp-Source: ACHHUZ6W45+nYYtPli9FO9SD+YRunw+Uuhdk8hdZzeF/68wsjhLAFg0GoFHHxkB57Ykeq0XvBZGu+Q==
X-Received: by 2002:a0d:e293:0:b0:561:d25b:672a with SMTP id l141-20020a0de293000000b00561d25b672amr31395214ywe.21.1687835771352;
        Mon, 26 Jun 2023 20:16:11 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s4-20020a0dd004000000b0057399b3bd26sm1614798ywd.33.2023.06.26.20.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 20:16:10 -0700 (PDT)
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
	Hugh Dickins <hughd@google.com>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v6 30/33] sparc64: Convert various functions to use ptdescs
Date: Mon, 26 Jun 2023 20:14:28 -0700
Message-Id: <20230627031431.29653-31-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230627031431.29653-1-vishal.moola@gmail.com>
References: <20230627031431.29653-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230626_201612_301888_16CBBF34 
X-CRM114-Status: GOOD (  12.39  )
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
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/sparc/mm/init_64.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 04f9db0c3111..105915cd2eee 100644
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
+	return ptdesc_address(ptdesc);
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
