Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6897C001DF
	for <linux-um@archiver.kernel.org>; Tue, 27 Jun 2023 03:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=o7CStUpLFB7D9jmiRxAOsU9qI9YOzRKCTqHrJk7whg8=; b=ejv52ADZBliI+D
	Q9LhJIOCe+yoPp9YO1YqwUYdAMnTgEqSoIPq5kjg7zgcRS0MKBGsFSYnB2DIitGKn9qiMp2bi5yqN
	2GXD77AgDNEIgStqISvBcCEcn4egkAhi32/1zHDBu7LZvkvFjnaoBdXI65cbJdlahz0O6eWupXJer
	KvFgKZBSDXNvK6mM+4rGa/R/OFT2e++7qaL0yKvYQzASJTMXU8aC6Bw3QmB0GPCRcM+/UzwQfa8tA
	GyN6aY0y2ENrYdkm3w5jOKjnME3VlCt7KEeb7R9jJrIdpH7Ujr/KYT0+COS2S/BSAvI6rxkoRsV8M
	ls8Lys8cwEyLcV7V2b5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qDzEb-00BZ5d-1A;
	Tue, 27 Jun 2023 03:19:17 +0000
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qDzBa-00BWIx-1L;
	Tue, 27 Jun 2023 03:16:13 +0000
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-57023c9be80so39991527b3.3;
        Mon, 26 Jun 2023 20:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687835769; x=1690427769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NG13BwzmmAIpXpcduEwvRHFbS3iQhU18W2JpKLteVDY=;
        b=eyYuDUlXPMdgLVymoCPm6l0B5AkMkP0MJVgww2Dc7/3sqQmnGU1ku6H9CU98Kx8HDx
         01E8lwPN+qvwNuBvO2TKM7cIgKQ3CJY1x5BttlhhMCAu/eXz9REbxcYgAP/6CQkWy6Cf
         lQ90mc5ZocMFbyDKOmgQ6JtaRafPtmT5vpmCcu1CHVchruI6mMlKmB0nAjhundO2FScF
         dwi9LCyq+7qGXz1usN+jVcsXjJuTQQ04p4sKanEFFQJoYolDJUzZRawaXCZwSYL33znl
         4r4UGf7Bdp39+qapNSstfbw+OcAirA3yy9mzGZ+ruj3Aqj6H943hd4iO/NnOtCq31XtZ
         136A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687835769; x=1690427769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NG13BwzmmAIpXpcduEwvRHFbS3iQhU18W2JpKLteVDY=;
        b=cTcun2qyn1iOpH0gIyaQyndBuOYCBXtsVyEvfgK1ax7gaeOI1AaFGJlL+H3vsThC3m
         tKJ23UuD6ov9NgDePatBFY2/XZ7wsWISzligQHfvNzYM7ocrYCN4DWEOGJY1HbTTY5Jv
         OPqwW///gGpV10B4TAPoHVNdfJ+yD9zw/FUaocwCrfBLEx0bUcz1Mm/aQ3YwY86sfVx3
         6NskFURPwIJoSNS6C95l5cb0tDqR8Kd9zMLgMp34QO5Xo5ZbwG5KD4HFjw5N2LWKV2yw
         eYXwwDiI/aRYrTYs6CSbcsX8tt3ZSJ69cTsmB4hOqEA8wFQJlO/n1E7dUg92rGerEG6r
         Ce3g==
X-Gm-Message-State: AC+VfDxzxzUzBKUN5qoPDsAT9nF3oJlVvHP0WuSt9Y/ljYsv4yTinLha
	pDLwgnSdUAgJtOHt19S/YhA=
X-Google-Smtp-Source: ACHHUZ5BRaD177tE1K+/zidTaxecch2WxFQR5MI/tG/yJGMKk055pAnLHtqYXsbXJZWlLLkzghbGoA==
X-Received: by 2002:a81:8684:0:b0:576:e4b6:9272 with SMTP id w126-20020a818684000000b00576e4b69272mr1982237ywf.30.1687835769172;
        Mon, 26 Jun 2023 20:16:09 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s4-20020a0dd004000000b0057399b3bd26sm1614798ywd.33.2023.06.26.20.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 20:16:08 -0700 (PDT)
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
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v6 29/33] sh: Convert pte_free_tlb() to use ptdescs
Date: Mon, 26 Jun 2023 20:14:27 -0700
Message-Id: <20230627031431.29653-30-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230627031431.29653-1-vishal.moola@gmail.com>
References: <20230627031431.29653-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230626_201610_499318_B35F5889 
X-CRM114-Status: GOOD (  10.53  )
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

Part of the conversions to replace pgtable constructor/destructors with
ptdesc equivalents. Also cleans up some spacing issues.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/sh/include/asm/pgalloc.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/sh/include/asm/pgalloc.h b/arch/sh/include/asm/pgalloc.h
index a9e98233c4d4..5d8577ab1591 100644
--- a/arch/sh/include/asm/pgalloc.h
+++ b/arch/sh/include/asm/pgalloc.h
@@ -2,6 +2,7 @@
 #ifndef __ASM_SH_PGALLOC_H
 #define __ASM_SH_PGALLOC_H
 
+#include <linux/mm.h>
 #include <asm/page.h>
 
 #define __HAVE_ARCH_PMD_ALLOC_ONE
@@ -31,10 +32,10 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 	set_pmd(pmd, __pmd((unsigned long)page_address(pte)));
 }
 
-#define __pte_free_tlb(tlb,pte,addr)			\
-do {							\
-	pgtable_pte_page_dtor(pte);			\
-	tlb_remove_page((tlb), (pte));			\
+#define __pte_free_tlb(tlb, pte, addr)				\
+do {								\
+	pagetable_pte_dtor(page_ptdesc(pte));			\
+	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
 } while (0)
 
 #endif /* __ASM_SH_PGALLOC_H */
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
