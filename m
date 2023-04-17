Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B29C77B72
	for <linux-um@archiver.kernel.org>; Mon, 17 Apr 2023 21:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wgIRyDc7C1HD/0a3cvgQ+JAsWu+yrOvGtDnYdiMATpo=; b=X5IRzR8OkHXwcD
	UoCdXrOpRRa3sgsuahBrTSNQlyH/XmXv7PtQC5ZRNsilQT0uy5frGwpSMJzIti53Mdn+t/tH+qCLP
	742G7ecEmrD61psb8wkRcucrz/NaTpBwF7rAZr6H8H2e7VsiJMiXTbGr45fozBMhII2r5TowotOlC
	zofRzcGWmrW+02Kl8D1Zlw3uw6pEA0VflhrdR0KG5TJJosygP/yXCIMZKgLgC7nwHd69HvIIocYJq
	6cn6yNByAWMypH0EtlDYoLXHCAg76iFmeqkfRqHgHgVVoQXWxKZ53NKywqVbBBtbFUdJTsaNhOk1c
	gH3TnI4dMfVFzoWic8Dg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poWqd-000B0P-1I;
	Mon, 17 Apr 2023 21:57:19 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poWqY-000AyF-32;
	Mon, 17 Apr 2023 21:57:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=gfpIRfFq9zSU9T7uNfhlcYr/W6dIxhZkZgP28wF3SDA=; b=Yj3Gb4DAIGCG1yt/vXgNFsnU1e
	GTScgeBrKIlrrHRkqrIgUhvh/VlN0NK9XvQR7suBdBp5gGUfb4LejmGT6AVLDRNFabN4xZ2BG4hIf
	UtFkzaMxS8MF0qpvNnAji+XWwbgX3NkIeMHQybXpf8efh1aLPlZ4/ILxddq5SuYLKpkmse/AyBPtH
	JupkS4a1pdU3hXiHbWUpFZGr1tcv2mUEBbevn8AjX3TQ7cNWWgypA+wPN8iAJXq7hTOn+JiC/QbPT
	NakRVaroa0H9I7iNekVrrEwkmZwrJ0/EgdiAT7wKFbskU4WLJn3QauY/iSH9Eb/3qzgyKp/t1s1aQ
	QZmZDYFg==;
Received: from mail-io1-xd33.google.com ([2607:f8b0:4864:20::d33])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poVw7-00HSNK-1C;
	Mon, 17 Apr 2023 20:59:01 +0000
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-760ec550833so80603339f.3;
        Mon, 17 Apr 2023 13:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681765130; x=1684357130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfpIRfFq9zSU9T7uNfhlcYr/W6dIxhZkZgP28wF3SDA=;
        b=NIveQzYztGIGwGyitzMCgcJMjXdY5ZrU7saL/Ta4v7d7BZ1+nv6G/uPyvftzUDoFiK
         Jd1PPS07iFVG8OxdE8PSSa6Xlk18ZTTsPxHcE4Um7SJbHL/vjtoNmEXzRTcA5qhLy8IF
         bYjgk8UF6o3tm7r/xGBfJ5RQgNTpuO5C0FvVtODCAaXl9stDeJEpEPZYIvpFASCmKrgu
         DMUY+NMR/ZgZ1G+STC+L5r9IUW5LBKo8t7TE2baIguIDmf0f2Vfg0wZZKygqLy63fIX1
         NDjlvLp1PVfkqeWGSOqIfFjaU3ZsKYF+tDBArqA/OlvuhO219bGpx5Yu1RXvhcIctTwm
         ReOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681765130; x=1684357130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gfpIRfFq9zSU9T7uNfhlcYr/W6dIxhZkZgP28wF3SDA=;
        b=LUVkke5i7J04CIscFPYiZIUW+KbYL/find3P1GXtSrZMJ17rS0ubONSzqsESKfq9k3
         yhZpjyIrJWtzUhbhmU+7sNYxgRwhatwzroNdR7mCWUIDVPTw32MyMc+PF1UV1F/Y9ryD
         uCH/yAr3VGGiR30OwfVVMPQY9LtMa+22TcnnawhmbJisEshhaZQHKZHWSZfuHouAZr9k
         r0qTv1Se6pAQKF05eH3a6UVvFaBoCviHKyV3EbbEZ6uWPvNowvkDjuiITgxKQo9QWWWP
         YkdyLqagS7EyrSz5VeCYe/XCAlInmJ7TtRrtAR+5a2xoW1H56GEp8jI+b5kStRe583qM
         awPg==
X-Gm-Message-State: AAQBX9dLWK2y0I9eNQUyI3hHsiY4p9ixOcT3tzPwh2jzKiABKif3kQzn
	EuIK3HXGL2Og0lX1euc3P9jztjuAWknbzw==
X-Google-Smtp-Source: AKy350bvWV8yzhiozqrrwWcRpctJK00ZbC2YeKZYOK2IgaSQcSotd8fWuCQxrW1E1m+ogfO6p1yZ/Q==
X-Received: by 2002:a17:902:b789:b0:1a6:8024:321e with SMTP id e9-20020a170902b78900b001a68024321emr189655pls.34.1681764791672;
        Mon, 17 Apr 2023 13:53:11 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::c139])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm7609707pjt.22.2023.04.17.13.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:53:11 -0700 (PDT)
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
Subject: [PATCH 19/33] arm: Convert various functions to use ptdescs
Date: Mon, 17 Apr 2023 13:50:34 -0700
Message-Id: <20230417205048.15870-20-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417205048.15870-1-vishal.moola@gmail.com>
References: <20230417205048.15870-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_215857_075183_86E14042 
X-CRM114-Status: GOOD (  12.21  )
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

late_alloc() also uses the __get_free_pages() helper function. Convert
this to use ptdesc_alloc() and ptdesc_address() instead to help
standardize page tables further.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/arm/include/asm/tlb.h | 12 +++++++-----
 arch/arm/mm/mmu.c          |  6 +++---
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
index b8cbe03ad260..9ab8a6929d35 100644
--- a/arch/arm/include/asm/tlb.h
+++ b/arch/arm/include/asm/tlb.h
@@ -39,7 +39,9 @@ static inline void __tlb_remove_table(void *_table)
 static inline void
 __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte, unsigned long addr)
 {
-	pgtable_pte_page_dtor(pte);
+	struct ptdesc *ptdesc = page_ptdesc(pte);
+
+	ptdesc_pte_dtor(ptdesc);
 
 #ifndef CONFIG_ARM_LPAE
 	/*
@@ -50,17 +52,17 @@ __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte, unsigned long addr)
 	__tlb_adjust_range(tlb, addr - PAGE_SIZE, 2 * PAGE_SIZE);
 #endif
 
-	tlb_remove_table(tlb, pte);
+	tlb_remove_ptdesc(tlb, ptdesc);
 }
 
 static inline void
 __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp, unsigned long addr)
 {
 #ifdef CONFIG_ARM_LPAE
-	struct page *page = virt_to_page(pmdp);
+	struct ptdesc *ptdesc = virt_to_ptdesc(pmdp);
 
-	pgtable_pmd_page_dtor(page);
-	tlb_remove_table(tlb, page);
+	ptdesc_pmd_dtor(ptdesc);
+	tlb_remove_ptdesc(tlb, ptdesc);
 #endif
 }
 
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 463fc2a8448f..7add505bd797 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -737,11 +737,11 @@ static void __init *early_alloc(unsigned long sz)
 
 static void *__init late_alloc(unsigned long sz)
 {
-	void *ptr = (void *)__get_free_pages(GFP_PGTABLE_KERNEL, get_order(sz));
+	void *ptdesc = ptdesc_alloc(GFP_PGTABLE_KERNEL, get_order(sz));
 
-	if (!ptr || !pgtable_pte_page_ctor(virt_to_page(ptr)))
+	if (!ptdesc || !ptdesc_pte_ctor(ptdesc))
 		BUG();
-	return ptr;
+	return ptdesc;
 }
 
 static pte_t * __init arm_pte_alloc(pmd_t *pmd, unsigned long addr,
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
