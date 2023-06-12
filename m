Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51FAAC88CB5
	for <linux-um@archiver.kernel.org>; Mon, 12 Jun 2023 21:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CQT0YaULRUK8NH+IlfmogmD4hsURVpomACW57JsUFq8=; b=FNxB0PrDRwnubm
	vxR6kWPs6YiWNpSiMuUxY0mIQW3iPgZBFNZF8e+YnhjYDbZS8TwXffWx2Zh+h5tifBTj4tzuBQowT
	NG2wBlRQmpM9oNkliHxgUoB4I8pU3pIVhwfTchmNrDB/HGRJlALUWoB+hLOrlVZzxgAP/e/GL1nGt
	tZZLHwBE3Z8NzIujD8+pnO9VSOMk4Tx8tTX8Gj5dklAtuxC3FLbaCS3pxYV4+rBqVSAbWDeS3xLsk
	65/t6JBi+u/fQF7dZFhefvpeKHH60JwknAOwqAcRqjUEV9/aTIUn2HlyRI8IeNapadtYiTzNB3IrK
	sNMC+W7ZmSI9K0AiwHiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8oix-005NIf-2Q;
	Mon, 12 Jun 2023 21:05:15 +0000
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8oih-005N0F-0L;
	Mon, 12 Jun 2023 21:05:00 +0000
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-56ce96063bcso37489297b3.1;
        Mon, 12 Jun 2023 14:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686603898; x=1689195898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yIxlKckYoNWIlWWgwnqqyBbBSaaTtt3uqS2t74G/Cdc=;
        b=dEzJOtzxLU2ZgnRZWUoqUgX1LkEqjEDlA4j+okrU2e6EDfoTOSvMm21aq2NnoI678R
         /LX1XChQ5Sb6AvjVNxtMPEQadtzbeWOF+8rQnJrR7+vmusoCvLySLO14WPjcNIRUT0dF
         2rQMLU3uAHVNRz0iVUR14QRbNE3w1MtZleas6+gopDWiSHJ7z9AcD/gIo2kO1Qn8dYbq
         016n5ev0Z4+orrxhRkS9jR7LRRnc2lkVCuuqKiR89ABW/c7EVFAaF7NtNMlO51k6MesR
         a4Umst3ZsGaDroxenZAsFOjCXCF1Egq8LClHBVmEapvlxmVVyTvGXFdEnpS3DAZrTLmY
         PBbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686603898; x=1689195898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yIxlKckYoNWIlWWgwnqqyBbBSaaTtt3uqS2t74G/Cdc=;
        b=MxWhr7pVlXNeV8x04Kb3xUxfE+DfRA7ObbggpRibQQ9LxEIJGBzKdzsPt5w7t9sKgn
         u19NHUoLXoe3//MEh3TWfLGWdVcWgIAQw7sNyQunuBuJf/Zcjl89AEIh0hiUEQac2C/8
         oMNB3jHn31UUSE/LpRcM+4soC/PYa25dq9U2EqZJxFuCgQ5l8mpy2yOkqXK8H19VyFCH
         URRJeJ9XCZe7aE31e1RlNEFhhVPo51rTP+WLy59l5qvR2hlbZ+kH38HM/KpHqr1sUDYP
         WUy3MSVg/mBSfxF9dbCo/Non2XCvV3BGXDgBmzhon3wMInIv0xi6Z0b6lMR1WAniDbp7
         xA/g==
X-Gm-Message-State: AC+VfDzJbVF2cV8LAEpnqJluq19CHd7Qvh4LNRLXXPuf/k2gFcu107sF
	iRKVkZQhgIb6OtLRr7VsTzE=
X-Google-Smtp-Source: ACHHUZ6/Iw+ntCpwv4qU9urdFcPsYepvqoySZLtVMefOmpx6b7rcyARehfEWJ2myv62OL0MPJVk5RA==
X-Received: by 2002:a81:7287:0:b0:561:b246:77df with SMTP id n129-20020a817287000000b00561b24677dfmr12849071ywc.16.1686603898264;
        Mon, 12 Jun 2023 14:04:58 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s125-20020a817783000000b00569eb609458sm2757115ywc.81.2023.06.12.14.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 14:04:58 -0700 (PDT)
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
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v4 06/34] mm: Convert pmd_pgtable_page() to pmd_ptdesc()
Date: Mon, 12 Jun 2023 14:03:55 -0700
Message-Id: <20230612210423.18611-7-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230612210423.18611-1-vishal.moola@gmail.com>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230612_140459_184697_763D2D1E 
X-CRM114-Status: UNSURE (   9.27  )
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
index f184f1eba85d..088b7664f897 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2931,15 +2931,15 @@ static inline void pgtable_pte_page_dtor(struct page *page)
 
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
@@ -2958,7 +2958,7 @@ static inline void pmd_ptlock_free(struct page *page)
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
