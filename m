Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20DC5C05052
	for <linux-um@archiver.kernel.org>; Tue, 27 Jun 2023 03:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ePb183KWqkNHxMLSgLOTayo+iRBAtiPPBWxZTjeAVcI=; b=KuV09jBuucc75+
	Mqsq/74+AxbhsrtCXd2pe5bvjTIxPWT+S7Jn6gZc0Jx4buAMby2GOS0BsO25IKUxsEcOpVwIzVauZ
	2SvFYJUx/nG7+Q/e2mKC9JQn9DkTbMMmFZbytW1A7VOxIYhhEC4AuToSf/o+JCCfz4oo3077FfeCy
	qw6vKP3wl6o62o2VMl9zpcl1xaIBo2QXRkCB5dd55ldOKlgon/xnkLKh6Jbnne7GxJcb3b6UjQ9TD
	La9dYYkRXE0R92MmOamptJGOcGV6Y4Ej33mBv9nGPVvBpJEI1OlbhC/FGe6AkrB83VqN1GyIpTWfR
	6papvBP7P1Y9SrdT/tHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qDzBM-00BW4d-2r;
	Tue, 27 Jun 2023 03:15:56 +0000
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qDzAl-00BVQD-19;
	Tue, 27 Jun 2023 03:15:22 +0000
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5700b15c12fso42622357b3.1;
        Mon, 26 Jun 2023 20:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687835718; x=1690427718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5MMx6i8bJUxARp5QNqsq1CJUY3hOxlwkAEMcUNtK7dI=;
        b=MeM3v1KjtFoJ68g67QFEF1NyVxMiMYgvdlNUvONCKTcddCTBLfXbCvjdDQ2rkMkntp
         NglXMwE26fCvz5F9nMSZMUxoetH1ZAcsVpi0efOXfEwN4DA6ftYlLFo1JApHI/tubC37
         33sHqn+NMB2tr9HBuBdSW/hwIa8uL6U/SOUDWuLzyTAiHAPzWUOM8CjVLD+EbbHd/5kR
         FnMJGohaY21AmJl4Lrba1v1FCtiqCThvY8//FgKgMI5nMolrkjqa5ElszWe7So6X4/NA
         29o+uMEWd5I0Ihfj0/TIUUwfyyspThDiVrfoH9mpbEwmREVQeVNhmFuIVnTUiZMir9ah
         1F3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687835718; x=1690427718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5MMx6i8bJUxARp5QNqsq1CJUY3hOxlwkAEMcUNtK7dI=;
        b=d6490sQlY9y77tN1P6tq7pc6T30ZFCfxjDVOo5ceTsWL5oQkEQS6vQF5u4WQx6Dc5b
         vUbe4R/HAcafIUybX/wgH5aavUZZRnTDk6J53rbgCFMRIYYdz4zvLYFuQ//XG7tPeowe
         hZx2LNe9qKYqgrUtcN04v88Kxi0ULePX3TAIAuOBgT0AzNPuTPO57YQ21gHNZCJchdy4
         DAadheoeBIH2lbfvHLrNClyc2PrGKHtQVzJqJezyQiRyBZ6IuCzd8+DvOZKmNn6u/alB
         d2FbOJ7H+Cd492EuXpI7O4Ti2WU9QU2Z3g2mSkBXtCF0ruu80M83Phl/kApxduV0VtBw
         nxxA==
X-Gm-Message-State: AC+VfDw4oqMa5pCo1eS+U2YINGCVuMSeTJctR14N/DzRL0AOtpIq/Trd
	/bWR1PO1rDKJsKKB7Q0x6lM=
X-Google-Smtp-Source: ACHHUZ7jG3JdEOLXHoTlHZs7iMneXhbSi5TTL08hXZ/YgCW6ZXi6BK/DGPcEgnHcQP1gwkgg+JH2AQ==
X-Received: by 2002:a0d:c506:0:b0:56f:e627:8545 with SMTP id h6-20020a0dc506000000b0056fe6278545mr30778532ywd.39.1687835718493;
        Mon, 26 Jun 2023 20:15:18 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s4-20020a0dd004000000b0057399b3bd26sm1614798ywd.33.2023.06.26.20.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 20:15:17 -0700 (PDT)
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
	Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v6 05/33] mm: Convert pmd_pgtable_page() to pmd_ptdesc()
Date: Mon, 26 Jun 2023 20:14:03 -0700
Message-Id: <20230627031431.29653-6-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230627031431.29653-1-vishal.moola@gmail.com>
References: <20230627031431.29653-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230626_201519_437529_E694ED9A 
X-CRM114-Status: UNSURE (   9.55  )
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
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 include/linux/mm.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 14d95d494958..1511faf0263c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2915,15 +2915,15 @@ pte_t *pte_offset_map_nolock(struct mm_struct *mm, pmd_t *pmd,
 
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
@@ -2942,7 +2942,7 @@ static inline void pmd_ptlock_free(struct page *page)
 	ptlock_free(page);
 }
 
-#define pmd_huge_pte(mm, pmd) (pmd_pgtable_page(pmd)->pmd_huge_pte)
+#define pmd_huge_pte(mm, pmd) (pmd_ptdesc(pmd)->pmd_huge_pte)
 
 #else
 
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
