Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C3A4C77B7F
	for <linux-um@archiver.kernel.org>; Mon, 17 Apr 2023 21:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=H3qkp0VM0Cr2owV2poIaLB8uKoItwTa5XfU7u62EaCc=; b=IqORU++oiMtFhs
	uc+Ki1/5ff2rE6WcK5C6jmdsmJOBg/boD6+xX/cEyZUlBC/99mxqEFwNT05itzeJZuv2ameTFm6Tj
	7C5fGVrW9bKogrGJ3YiPshDbjtdx7jhNfOnXuqESgSALkmmECDdfHDpah+ljQjpllEFeWUGLJV9pg
	oOWaz6dTpVyHyMm5Gn8zG11YIbRPOBFXcJfAGjOOFZera3clfE0xx9RDxsLiQEF0g72y1slUpsvnb
	Dy7QKaSjSLp3t7hQpUmKX70B8WyvvMuDUQm7j49zQ31sacVv5WX+tb3wWdW+IC2qHz1eM79a0IskN
	L8hcDBluD6CvIihEVrNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poWnw-000A0v-2z;
	Mon, 17 Apr 2023 21:54:32 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poWnt-0009yD-0Y;
	Mon, 17 Apr 2023 21:54:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=BPCTGsUKFtNZ0E2E3gxAeEJL+3qovRd//xVc9xUETqc=; b=Db0FEx3nQ6JkN7KXnCGRFVI8hl
	vDkH//XAy5gHGlNhnw8UHHPzQDPMji+ymR2n9aR8WCH8VFw6cKNbiJpBFtjq4X/dXg/ssG2Gfh/SZ
	sIzeyQZkuEwQ2QZhpLmpFHNyFiYLs07/io9LQhTfO/KdDJRcOfOIwhEzjbMD3i5L/jMfJ4ga5rXAp
	Iq0gkN1hQQ9fpBqHfcrjtOpdpx54/1TauXq8xNGGgsJZWZmFeiO3gRzuRWjWtoPLqsP+fJb31snHj
	J2FLKF0cudcD+5MmTstViFpeN0wxDfTFEcQ5EFSCiAJwF/qXTX/xAKRMDO/ReWcPFCnhb/WkO+UOO
	9QT3P/Cw==;
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poVqL-00HS3p-0M;
	Mon, 17 Apr 2023 20:53:05 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d15so10118309pll.12;
        Mon, 17 Apr 2023 13:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681764772; x=1684356772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BPCTGsUKFtNZ0E2E3gxAeEJL+3qovRd//xVc9xUETqc=;
        b=IRDdSAScs3TBGztRzu6QZgH4fMR7/UKueaVS3DDhFsZMLZlJQUDaWkKiPXvov39z8Z
         bssT73UYUy1LP7uOeEalBEo3irDXhaxWlDKHCjJjWa82XbzBt1YrruOwks0GGaa/KE2/
         kcH9ajFlIINgfw2e+eWdEuaQpWFwhb8tF79JjCU2EAC5A/73X/TUfQV/8mop72+F/v41
         nZHSSM2ss9/OewEDYIYb1Iz4F1hF7m8KXVNPHD0iWKxsJnaQ4CmjrVdNW0xNgbwEICJR
         VACO7VFEKZxOIvTtIDcu6wtwdqmMEpSRB4owcroJF6TbGx9VSAN4uiN81drhHklILqhb
         p9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681764772; x=1684356772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BPCTGsUKFtNZ0E2E3gxAeEJL+3qovRd//xVc9xUETqc=;
        b=eJH26ZP0Hoz11HTWfP3T8HvGPSOrjMj/HFpcgClBdQ4dEagozcDAw0BEGyDDsJqzlO
         ODrt1cIhvkdiCMq04N38rj9nfSXZzhdPAgWizjRwLCAjOmyoMl1ZRI5MjAeS3F+DIuz6
         9gJB/AJCn3m2lyZDc0+uZAvIxl2prY/wbO0uOCJVnn6AfkX8BQc5DnBuFTZDr3f2vV6B
         eVmLXuGWGWzVGmC+Gj/AeikifKePpokIKjIr73QlRNxFWoO6vQFT7FDYQW+tWl+4d7od
         KGJ8DANePkpnEO7+4ltfiDeTtfbGDSxHLOsz3TFLTeZ0sdtt+S3BpydeCxmSabkcfj0d
         EOGw==
X-Gm-Message-State: AAQBX9cemxyw9sy1t9vgwULtyLcR7j0UjQ75VMUIVITPwh1RYiT1mR/n
	IQvyzJQPDXdImcYWZzk36AQ=
X-Google-Smtp-Source: AKy350bms9aSjWgOwaAnzsnpGuFvcEqsOo1myEWAVSaCBXxzFAqV0lCr0DmPVe9wT5EHiIOY8l5jIQ==
X-Received: by 2002:a17:90b:f84:b0:246:fc58:d77b with SMTP id ft4-20020a17090b0f8400b00246fc58d77bmr15834371pjb.44.1681764772342;
        Mon, 17 Apr 2023 13:52:52 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::c139])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm7609707pjt.22.2023.04.17.13.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:52:51 -0700 (PDT)
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
Subject: [PATCH 05/33] mm: Convert pmd_pgtable_page() to pmd_ptdesc()
Date: Mon, 17 Apr 2023 13:50:20 -0700
Message-Id: <20230417205048.15870-6-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417205048.15870-1-vishal.moola@gmail.com>
References: <20230417205048.15870-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_215259_451131_DAF99151 
X-CRM114-Status: UNSURE (   8.90  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Converts pmd_pgtable_page() to pmd_ptdesc() and all its callers. This
removes some direct accesses to struct page, working towards splitting
out struct ptdesc from struct page.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/mm.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ec3cbe2fa665..069187e84e35 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2892,15 +2892,15 @@ static inline void pgtable_pte_page_dtor(struct page *page)
 
 #if USE_SPLIT_PMD_PTLOCKS
 
-static inline struct page *pmd_pgtable_page(pmd_t *pmd)
+static inline struct ptdesc *pmd_ptdesc(pmd_t *pmd)
 {
 	unsigned long mask = ~(PTRS_PER_PMD * sizeof(pmd_t) - 1);
-	return virt_to_page((void *)((unsigned long) pmd & mask));
+	return virt_to_ptdesc((void *)((unsigned long) pmd & mask));
 }
 
 static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
 {
-	return ptlock_ptr(pmd_pgtable_page(pmd));
+	return ptlock_ptr(ptdesc_page(pmd_ptdesc(pmd)));
 }
 
 static inline bool pmd_ptlock_init(struct page *page)
@@ -2919,7 +2919,7 @@ static inline void pmd_ptlock_free(struct page *page)
 	ptlock_free(page);
 }
 
-#define pmd_huge_pte(mm, pmd) (pmd_pgtable_page(pmd)->pmd_huge_pte)
+#define pmd_huge_pte(mm, pmd) (pmd_ptdesc(pmd)->pmd_huge_pte)
 
 #else
 
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
