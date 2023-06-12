Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADFE4C88CB5
	for <linux-um@archiver.kernel.org>; Mon, 12 Jun 2023 21:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WMDYwyA1EXNY48G2k3PVGsH7g9Iy/HOH07LgZ0l7UGc=; b=DyWmw0OzDmedKB
	GzpXO2zYzuT4WXD/JNdhUSxJm5TkgcCQwH3TR1k+NbOE1e8qnivpKYVdCGK83MXsArEujAoDDL4Gj
	CiJZF0i9HTWsviWBNPAnQGrvITVtGFT6N0v8+TOGDsNSVThNi6stcCx2m/OBkWWa3KC1NN4RXRylW
	ZpPbjVLaCC6sf/8+5ORe08+v7xU9cwFPFc14vRsqL6GB2Etl+XSe9FMDqCTys1MkjZOC55a2V62eH
	bjQcx6ohHV8QQnOVfDIMXtBokCTnvf3RJ73/Jow9TjISC+hu4Szl8qrHVu+LqJfYZw2oMJ/h8tL3F
	GkblARtB7vbrVRMTgSQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8okC-005OkR-2L;
	Mon, 12 Jun 2023 21:06:32 +0000
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8oj9-005N2P-0e;
	Mon, 12 Jun 2023 21:05:28 +0000
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-56d4f50427cso6514627b3.3;
        Mon, 12 Jun 2023 14:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686603927; x=1689195927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=llblHDjuRzdwObovgJjTe//ioNSPoyRpZegKgEWGdOs=;
        b=YRMhLn8GgjXKF9eS1CkYK8/hVT9gPYz37UeBHSWCXWxsEKTB0xKNbO9xfoQxJLGBci
         pUYRlNAXxGNIort4RFvyqFoVkx12q+4R5GQ2T6iKcv07wKy7zihyGs6NzbSMSMCL6Rs5
         mHPuU0pXtsap85DxLGrKUtMBDvnEahRHLKEvKQOX7bhc/KG8s8E1jIJIjYHBV6Mzo8Tw
         JyoVIgOoI3Qu3/9ICO4yd0mqp02BwnCK/YCnIHcpYzONCtiWYcoEWw9YCE5wOdJRn8uB
         XPcLMuecwthMMTL6YQJ8OIdeoFxd5Ul+5c4RpJemAGRzK0WgBz8keleyqJxUgTeZRruD
         CsNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686603927; x=1689195927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=llblHDjuRzdwObovgJjTe//ioNSPoyRpZegKgEWGdOs=;
        b=V3G86XrLEL4d8xhDNcOE39rzqcvr/h50OP7YR/soU9Zmtj4+oODo7XaBBb3CfX3TQP
         m1ZJ9il3Hm5YYZg2d7Nijb4iJAZ8Av2cJnDENEy0R7iJAPx2fXfcVG6bxaDmq42yN8Zr
         9pXmQ2bfSu7zg3IIawyiL1JqN55AhUEHVGa3AOeBn8q7srtPMpCvXViHfvY3ekntY1KD
         zVT8uMhHkTcaBpaN2Rgk80ao6u4IFAg8zKm+vodawcIhIwHfi3j0Ibn006qjr6LKCGzR
         6am9GJkrCmK/Vmt0IZzpcxtmCUkswwqQ9Jnfvb5co56usdd11++w2ikaV5ZFMpBpWLdf
         vfPw==
X-Gm-Message-State: AC+VfDxcm3nGVFv0m5jXrv3hYYbVmZEC1v4xcGn2qDWieybkB1LzUccw
	5tj1TXbVVo4inruztTdpMRw=
X-Google-Smtp-Source: ACHHUZ4ft3mDxgWWbZVZ6VtJGRUVYiTphgdB2NgQzT9U5dEGnrQumf24dtXrB3QCjAsLfMmACVzxzw==
X-Received: by 2002:a81:6d07:0:b0:56d:29a1:c1c3 with SMTP id i7-20020a816d07000000b0056d29a1c1c3mr3804535ywc.24.1686603926795;
        Mon, 12 Jun 2023 14:05:26 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s125-20020a817783000000b00569eb609458sm2757115ywc.81.2023.06.12.14.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 14:05:26 -0700 (PDT)
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
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v4 20/34] arm: Convert various functions to use ptdescs
Date: Mon, 12 Jun 2023 14:04:09 -0700
Message-Id: <20230612210423.18611-21-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230612210423.18611-1-vishal.moola@gmail.com>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230612_140527_275171_94198225 
X-CRM114-Status: GOOD (  12.37  )
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
this to use pagetable_alloc() and ptdesc_address() instead to help
standardize page tables further.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/arm/include/asm/tlb.h | 12 +++++++-----
 arch/arm/mm/mmu.c          |  6 +++---
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
index b8cbe03ad260..f40d06ad5d2a 100644
--- a/arch/arm/include/asm/tlb.h
+++ b/arch/arm/include/asm/tlb.h
@@ -39,7 +39,9 @@ static inline void __tlb_remove_table(void *_table)
 static inline void
 __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte, unsigned long addr)
 {
-	pgtable_pte_page_dtor(pte);
+	struct ptdesc *ptdesc = page_ptdesc(pte);
+
+	pagetable_pte_dtor(ptdesc);
 
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
+	pagetable_pmd_dtor(ptdesc);
+	tlb_remove_ptdesc(tlb, ptdesc);
 #endif
 }
 
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 22292cf3381c..294518fd0240 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -737,11 +737,11 @@ static void __init *early_alloc(unsigned long sz)
 
 static void *__init late_alloc(unsigned long sz)
 {
-	void *ptr = (void *)__get_free_pages(GFP_PGTABLE_KERNEL, get_order(sz));
+	void *ptdesc = pagetable_alloc(GFP_PGTABLE_KERNEL, get_order(sz));
 
-	if (!ptr || !pgtable_pte_page_ctor(virt_to_page(ptr)))
+	if (!ptdesc || !pagetable_pte_ctor(ptdesc))
 		BUG();
-	return ptr;
+	return ptdesc;
 }
 
 static pte_t * __init arm_pte_alloc(pmd_t *pmd, unsigned long addr,
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
