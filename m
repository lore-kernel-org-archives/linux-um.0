Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EFF2C41513
	for <linux-um@archiver.kernel.org>; Mon, 31 Jul 2023 17:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7iH1ng0NHTYmYaPMglgNZpV/ZIkk8TarLBJGL9DDqVU=; b=nXjuqnKc6ra7a5
	YVxxX6IiXUUgotoJktdI/rI+hDQga0rhMOR3SgWaXFty7/HlvfAr0O/rUOo7XCeKcQVyHGIBVMT+H
	yDnLb5xus74yS+5zBQoWF00rvYtyBQ0KaiT+N0v7QgmvaQ8tw+ETEZpvQ3ZrIYCIpcelIQS3Nd4u3
	EqD9u94pSjE32eOLQR40gfDGi42GXaoU8fsaEEMN0e7qYmwH+tnXXmlABoQ4UpGsNyc/QWxTj7Mp3
	wioTucKsQEpBEuhywj65sRGSPTVQ+qpfsUq+H/M7PEu1A2jjpTkG+d2iXsFOSz/mk83V9voHN/aWa
	AYcTvKXiCw1Hm/T/qYvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQWNw-00GnnM-2u;
	Mon, 31 Jul 2023 17:08:44 +0000
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQWJn-00Gkc1-1l;
	Mon, 31 Jul 2023 17:04:29 +0000
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d3522283441so604675276.0;
        Mon, 31 Jul 2023 10:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690823066; x=1691427866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOzSOLTncjJXn0AvJQqE6PD7zrtBe8MIuyz5zw7TzDY=;
        b=f6adceAKsPvui0l7VSUiRnWj+VnC8V29gRyKPW/KXba4L11duKnXDkkl9h+DOUEe82
         /+uFEmkPUA7pfwVfanOSjRVPX3wfPLVY3FZPvGi3VyyqlsToEnHzzIylic2yHwlsDcH3
         W3JP9R5mJExPbkEH69AGyH0gizw4AowCqMoujs5LGqqMzZnJK/dPFOzk0elvmdxwimx1
         zHO/RBskNqXdsMC9zN3IXGN1/Qatnc3KRzwrgmn/b1CAPxkc6smcQgcPCS+F4TUkpdDt
         7sG/wG+FEbTCZLXxJ46EURhFx988hfZQfl6N1HhCumdsXb4Bqj21mhmFktRwf8yfQcyF
         sVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690823066; x=1691427866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DOzSOLTncjJXn0AvJQqE6PD7zrtBe8MIuyz5zw7TzDY=;
        b=hCM2OGgJY+uWhAb1hAmyit21bfNTF/0s4lsI2xTnLW5MW5Vs3a7uMGEnnPlpMHIM6k
         El93Pt9ZOwUbIskcnIZpsBawUN8iDbnQ2uQvxFSgw1J14vaY2B91X5uZTON11+mhMI+I
         WQsFRbl9xNd42bAcMmEN+ABUJBkL1GD/tRnINjKShcCH7FPD4wzyG/pTBP2j9yZowuwa
         21aMQVPfy56DDzYOvHoUizJQC+Z1LV0DwnXg27dAVeBLE/4CN3PPiDSIxReKjw6Sw4FA
         +6ugrZz85pOoNcPJFJ907bLRwqeriufPxO8QStCQXaVgiCxKceM8GwR/Zwrl8FQ36kY4
         IUfw==
X-Gm-Message-State: ABy/qLbx7emqK9LgL4fLV6gO76dm6T21xxdw6Qt6c9hVs64WWPvNibhG
	AP+SX35eKwCwC/ylIRDftuY=
X-Google-Smtp-Source: APBJJlE4T05ogdyrjIbBXTs0RpkDVTPnYG3Ig2UA6lH+KuSSQ9n98n0kBdmmWfFoFgc9s9NgVox+UA==
X-Received: by 2002:a25:ada4:0:b0:d0a:8973:b1c with SMTP id z36-20020a25ada4000000b00d0a89730b1cmr247583ybi.12.1690823066447;
        Mon, 31 Jul 2023 10:04:26 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id x31-20020a25ac9f000000b00c832ad2e2eesm2511833ybi.60.2023.07.31.10.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 10:04:26 -0700 (PDT)
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
	Mike Rapoport <rppt@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH mm-unstable v8 24/31] nios2: Convert __pte_free_tlb() to use ptdescs
Date: Mon, 31 Jul 2023 10:03:25 -0700
Message-Id: <20230731170332.69404-25-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230731170332.69404-1-vishal.moola@gmail.com>
References: <20230731170332.69404-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230731_100427_622924_7620248C 
X-CRM114-Status: GOOD (  11.12  )
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
ptdesc equivalents.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Acked-by: Dinh Nguyen <dinguyen@kernel.org>
---
 arch/nios2/include/asm/pgalloc.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/nios2/include/asm/pgalloc.h b/arch/nios2/include/asm/pgalloc.h
index ecd1657bb2ce..ce6bb8e74271 100644
--- a/arch/nios2/include/asm/pgalloc.h
+++ b/arch/nios2/include/asm/pgalloc.h
@@ -28,10 +28,10 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 
 extern pgd_t *pgd_alloc(struct mm_struct *mm);
 
-#define __pte_free_tlb(tlb, pte, addr)				\
-	do {							\
-		pgtable_pte_page_dtor(pte);			\
-		tlb_remove_page((tlb), (pte));			\
+#define __pte_free_tlb(tlb, pte, addr)					\
+	do {								\
+		pagetable_pte_dtor(page_ptdesc(pte));			\
+		tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
 	} while (0)
 
 #endif /* _ASM_NIOS2_PGALLOC_H */
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
