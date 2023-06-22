Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2FA5C001DD
	for <linux-um@archiver.kernel.org>; Thu, 22 Jun 2023 20:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ePb183KWqkNHxMLSgLOTayo+iRBAtiPPBWxZTjeAVcI=; b=xO0hxErCe52Wc5
	l2SZpqlMWLLs4HUq2KFeZeWG1izGyeS4LL+L5NXXUBJt3gDdKdRUAGbHoz8574BjNEGtdlx8wwIVb
	FuTpN8drUjgUgxQtnL7bRiBbzFD5yjwS/ElHaz939twtTqJ0OZLMoYNzNaSwvxffZn0LBx33j4z1u
	PUr04QNZO6iK9jeZR8yA1ZBUPQ69gTUPeE2fyZaNeliTwdwnRMqfT9t125PSH37aAdaWZi4PuTuoy
	Eje+gHrypmuWqe6MvvdPwA4tnS3l5gtm85Tabpjv9GCBr6sKByvpEyHNo1wMjSyhl+v1M9xFlnZah
	glsgWz/0EmGsxRQ0YpPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qCROG-001iMx-2G;
	Thu, 22 Jun 2023 20:58:52 +0000
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qCRNY-001hbe-02;
	Thu, 22 Jun 2023 20:58:09 +0000
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6b13e2af122so5866855a34.2;
        Thu, 22 Jun 2023 13:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687467487; x=1690059487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5MMx6i8bJUxARp5QNqsq1CJUY3hOxlwkAEMcUNtK7dI=;
        b=UdIEW49a6VlVFdeDO40XUMIhkzu0TZbzMPBM/WacFFYU0Mf2IMmAOz+NL1cV98Ton4
         4zQ7N3mgDzFH/zAeyyuA7dsXAtz6L9a3ryBLZR0keuhq84g9s5CyaVK84D28lhUtpY1k
         n1Pbrc0aBtOd2I2lssPU62Gn+t4FuAK2YSMld5ItzYd2Gb7upO15jx4dCKR0ZoMoveD4
         fYCQ1IFYfK8OlRQ+gZ/yAiK4LxmWYPlg8lrZ4XnMaYZEtLSmgFLWfXItXcddGU79r9OH
         9d/82j8McTJZKyaaoZkqZMldnjmKIChpQ0nH7tpNr90msjJzxK9KTHEvxYDWGujERLdc
         e96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687467487; x=1690059487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5MMx6i8bJUxARp5QNqsq1CJUY3hOxlwkAEMcUNtK7dI=;
        b=Id539B7hrxfjPY2K5B6PeHcPwAbDvqgrkSPFIsJiDKd4SKSKQwTmQWT1LQjiG30sJO
         JeckbOy5bRoJiYEDovk8aCCeQmz1Iv5XfkM9p6G5k08XqNB/JOj97el6qsH5a1etTcCm
         y4HcXB5kshnltWQDkAgstEdndDPX0uaWwJeFQ+i3MQv2nYlLi229Iw51vctymh7Zf3+h
         90XZyZx+1y9FcTmJjpIXCimAZ9bAnUmR9CsSYCU/B/H4xV+aCxh6eayMN73BW5XCJ2iA
         prxOmDvUaYkIVjKn0Rl7aZIPIDySlEs3MYWnEO+Zbt2VEsxcTAaNNvV6wbPWcmI0tGJw
         GDwA==
X-Gm-Message-State: AC+VfDzVBzR8jy/E4ZHFEqcxDxSzj8NzeRanaykeV4frUbFykhIE9VTg
	Si2fpgEYs84tkJwIvYNUvpE=
X-Google-Smtp-Source: ACHHUZ5msoxCs4WtHFESbyMK1EuaDf4wukFNhVJUOVId63qr2aSW3HXx+zFK0CBZB4PkAluxQSVOjw==
X-Received: by 2002:a05:6359:2ea4:b0:12b:e5b1:1c9c with SMTP id rp36-20020a0563592ea400b0012be5b11c9cmr10630381rwb.14.1687467486510;
        Thu, 22 Jun 2023 13:58:06 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::36])
        by smtp.googlemail.com with ESMTPSA id d18-20020a5b0c52000000b00bc501a1b062sm1684937ybr.42.2023.06.22.13.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 13:58:06 -0700 (PDT)
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
Subject: [PATCH v5 05/33] mm: Convert pmd_pgtable_page() to pmd_ptdesc()
Date: Thu, 22 Jun 2023 13:57:17 -0700
Message-Id: <20230622205745.79707-6-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622205745.79707-1-vishal.moola@gmail.com>
References: <20230622205745.79707-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230622_135808_074283_C3BE439F 
X-CRM114-Status: UNSURE (   9.28  )
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
