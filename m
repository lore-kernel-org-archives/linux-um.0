Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4EDCC77B76
	for <linux-um@archiver.kernel.org>; Mon, 17 Apr 2023 21:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LTyFPXZoOp9sk9pWO6JMYM6c4cOrghK01Y411qmcez4=; b=NrDCAykpz69ewg
	1nkexlVu7hV3yCW8G9ANjm0qVpZY2QfJvzW33qDsMEK/tB9hfPiz/1CrbkE05N/CUM7gdlyXc2dMV
	3si0G61ahJfw0mQJoCxubjd5CJ4J+GA1N54MBaQdtaO8LEeqO9+GBEaWK7aCtEqTSbho0NCzZAbTU
	d++wQHsGuGLOtUrHve8ogAmD7t0FirarwbfOyw8vGExtBYTWtDY9shkevi+LRjBuj0cm9OHUy9INU
	Y3224t2YpcAM5enCUfIytlXFPYkZkRFqsQKH739Xc6kzflLSEm3VtzRZIRK9a1yWi5hPb3e0vcK8j
	IDhh1FoQaFzo0JIv2IYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poWrR-000BJH-1j;
	Mon, 17 Apr 2023 21:58:09 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poWrO-000BHS-13;
	Mon, 17 Apr 2023 21:58:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=uIsUNYOwSPNxjYFxvF4LgB4Ah8JH2T7Nmtlw8Cz+gsw=; b=MUgeBlDZd8hORC3p1LrvRlnYgd
	bp+hMlFvnjZoRBKOs4i7riPxSLSdcUPGMUI79v3nix8fqxeD/dHTXJJ8WTb3kf6FB26MC2GpnF/WY
	R0PwE/guHb/MzX233jectdKVyzqDgG5Pf7zGkx4IqdW+wEh5hz/389ZvmX2JB3xiYm5HgRHP6lfgL
	VchMdhhfQG+TaiApA8b+BIUD/d38jyomYp/Stkrpj6e9iRHDA0Mf3WH8t01y9qkSh4rlOMPWiDySZ
	HDuyaebZvHlWkBZZCO4Omd69IgmpQn6Adk8pr3fDaKBfOoqAB4E6hGt5F146TsXbucR4A2TDGEffs
	PAw5VqQA==;
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poVxi-00HSUH-2Z;
	Mon, 17 Apr 2023 21:00:36 +0000
Received: by mail-qt1-x82c.google.com with SMTP id m21so15723153qtg.0;
        Mon, 17 Apr 2023 14:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681765230; x=1684357230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uIsUNYOwSPNxjYFxvF4LgB4Ah8JH2T7Nmtlw8Cz+gsw=;
        b=aDScVHqh/zzMmXfLSVT4ULnHtSp4Cqx3/qQ5GaZLrokgeMipovWdw6CnWl4VEYb6a+
         +trRIH3WlHPts6m0DGjq69/7pWsBrHAMS567isfPXlFEpQ8g/yptm8rqkFc0po28g+RQ
         Mn7hFb4x2V+6PtVK8Oh//ep6wUQqoy4DEyRGg89P4VUp/3bOD7YjL+KAHNI8l3KLjXlI
         ZiquaM585jmZins1X6A5bEGRqrJlJooD0XjMLXihEMjD+CBAVneD0ab3wvpR1wEP77E/
         /kgpk7q43Y1vOGO5FmKoadjAHPbUaX1iGGdxM4oeDJCuZ/UZL9MYwXbwW3myiT3CcttC
         5Fgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681765230; x=1684357230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uIsUNYOwSPNxjYFxvF4LgB4Ah8JH2T7Nmtlw8Cz+gsw=;
        b=RJrzqkEkJAe46eK8tuJgyUSuEdAXcYj217yQ/5YtwS7mrfkFrpVSLDhbT64f8t5wEE
         W34Rg3Xh+s1y/GJgQkTDi//+8IOuNJByF3GvylhRmTZE+x4L1ubnFWbGaTXTphA1TBHH
         CqC0MikrQ9Nv7o6Qp7OXrs+89pJberNn9wIx0Vg/aOywceMHE/djCVqUf8gFYGGnyqiD
         emCerm1cAEYAvMqCxAdEuTLOBzO0BbHLPTO9LfaeuOw5P3NsD+3+6AlEvl+FxeExbON5
         /n+lJsNHYZDa34t/UGb7tA/mvXeBfGLLkthFMjVE4lHX4N9lWRlYObIm598X7VET6T2K
         Gw3w==
X-Gm-Message-State: AAQBX9exGPICCksWwgA+3g/H6vu/bO4sGxePtcVfXLgznlmvYzLR+N0i
	iHspSpzO8N8J0PwlvSI6ogx1OEhVrbDkLw==
X-Google-Smtp-Source: AKy350YfnaT8KE6LOLQ9wRoeSIO99cnRXYKnv4nnzRXnI3u1QAONlMDFC8rrZFtHP4TZD3hWsCKEag==
X-Received: by 2002:a17:90a:fa3:b0:237:3dfb:9095 with SMTP id 32-20020a17090a0fa300b002373dfb9095mr16284735pjz.6.1681764806946;
        Mon, 17 Apr 2023 13:53:26 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::c139])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm7609707pjt.22.2023.04.17.13.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:53:26 -0700 (PDT)
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
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 30/33] sparc64: Convert various functions to use ptdescs
Date: Mon, 17 Apr 2023 13:50:45 -0700
Message-Id: <20230417205048.15870-31-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417205048.15870-1-vishal.moola@gmail.com>
References: <20230417205048.15870-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_220035_074902_86DA05FE 
X-CRM114-Status: GOOD (  11.34  )
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
index 04f9db0c3111..eedb3e03b1fe 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2893,14 +2893,15 @@ pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
 
 pgtable_t pte_alloc_one(struct mm_struct *mm)
 {
-	struct page *page = alloc_page(GFP_KERNEL | __GFP_ZERO);
-	if (!page)
+	struct ptdesc *ptdesc = ptdesc_alloc(GFP_KERNEL | __GFP_ZERO, 0);
+
+	if (!ptdesc)
 		return NULL;
-	if (!pgtable_pte_page_ctor(page)) {
-		__free_page(page);
+	if (!ptdesc_pte_ctor(ptdesc)) {
+		ptdesc_free(ptdesc);
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
+	ptdesc_pte_dtor(ptdesc);
+	ptdesc_free(ptdesc);
 }
 
 void pte_free(struct mm_struct *mm, pgtable_t pte)
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
