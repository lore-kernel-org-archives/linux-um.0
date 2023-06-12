Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F20C7EE43
	for <linux-um@archiver.kernel.org>; Mon, 12 Jun 2023 21:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wmZx5lkZgWG9LYOkMKxjydwD4uNitHcOHc3oJmIC/4w=; b=Mzlfn1odpddkX7
	bxHzyGHI3THXgw4lKWcNb5/jGR6+o34fBOplkRJi6V3nIKmgGRyl6rvPplAdl+RBrG5jhmNmH19TM
	ESOBSAh1AdUjXFJ7McgqQ95zTKZou67eNOMTYD3tbgNvQS80sVN2o9jmU5HVqiCugyI2wXajL0rKp
	/onZVjkYB7g0dvf4bwtv7qyQQReW3IHfrGaeNOd9SkSoN3riIydz4ZjXSjR5VdpGfv+NDAXw8Brma
	tO2QP7jImDgbE60IEG4X+HvcLhS0GYJ0Oftfl8ydCia9lXjf7yKcrgtrUBrjBfQI8qtaZO9CGr4Na
	sB3Fko4jipMR0Nf3v6Jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8okr-005PQv-2g;
	Mon, 12 Jun 2023 21:07:13 +0000
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8ojQ-005Noo-04;
	Mon, 12 Jun 2023 21:05:45 +0000
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-56d2b7a9465so15634837b3.3;
        Mon, 12 Jun 2023 14:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686603943; x=1689195943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1x1J4vur13K6ienQiLVxExje9aLbKUsjVFvIhcqO10=;
        b=iC1t7ghfm9ecJs1x+mmEzeWS2SIjJKEgK7bxy4oucR/f+MfVZU1qsYKmxWlYK3St5v
         mfNdwnEbyVpOCAZkZBQocohQ9uTAKfouC9/50tiV+ofF8yr/r0xQFvh1fNWAqMX4eSyF
         ymqrJp033zjJJcGcMzZXmmZ/yN236luhBhvJ80nOlgUY6UjLfyMIfHGDH4uYCDgG1Yuw
         Qj+o3ciesPmzibkl2iqbskrx7aUBCJV6cn/sc9mp4OIhLm5DRTHYxNGTzKEY2jXsQ3j0
         sN44pjWt5AeKRt8Gf4eHzyt1HMP4kxf4IL2Kuq0LJJYg24qsvy+zvN4scp5/4UYjNDhu
         bvPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686603943; x=1689195943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K1x1J4vur13K6ienQiLVxExje9aLbKUsjVFvIhcqO10=;
        b=PuwoFiVpY0XzML0zUWuwfpF0nfEKzxfinPbXx1nOiu6CJrFr7aaZrlrCD9c/Z+IHTv
         7LdoXFQ1ze9lFY2obb4DddGwWwaSN8q65oKnFNc2Sn2zJODASsW5tdQ/lU3H/dNfSZFT
         6snGsTYLHeoTWp9abQvgHqJqUkfTwokB+UPXU/u7U+JUF4hLPmReTerQ0T28AIUM/NYL
         pQC6XvSw8HkpndHgqiX1jq72n80JXi1BzJ7hBRLTRPht/SfiRfnUuYRg8G9OMXwHkyl1
         bqHPMwP1SrmECgPPaWEFRMigQY2OXKp7AcTPZz3nae63sP3P0IsUpCqMSrR1KTBv79Vj
         8j6A==
X-Gm-Message-State: AC+VfDxlfQX1rotK/AMUHERkNvlfIUnZL8pV33cZvjMdbItJJernSS9R
	NItBwSI2SRt8YyYTQ0bORow=
X-Google-Smtp-Source: ACHHUZ6tVrzAvnvTdjXheXo4jZ8pT12rQpXHIkWfs+xqz819sAsyiOSj5h9nxDMqGOKxFovlbUa4wg==
X-Received: by 2002:a81:7542:0:b0:56c:e706:2e04 with SMTP id q63-20020a817542000000b0056ce7062e04mr7796917ywc.0.1686603942966;
        Mon, 12 Jun 2023 14:05:42 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s125-20020a817783000000b00569eb609458sm2757115ywc.81.2023.06.12.14.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 14:05:42 -0700 (PDT)
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
	Jonas Bonn <jonas@southpole.se>
Subject: [PATCH v4 28/34] openrisc: Convert __pte_free_tlb() to use ptdescs
Date: Mon, 12 Jun 2023 14:04:17 -0700
Message-Id: <20230612210423.18611-29-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230612210423.18611-1-vishal.moola@gmail.com>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230612_140544_141826_F0BA1F03 
X-CRM114-Status: UNSURE (   9.54  )
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

Part of the conversions to replace pgtable constructor/destructors with
ptdesc equivalents.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/openrisc/include/asm/pgalloc.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/openrisc/include/asm/pgalloc.h b/arch/openrisc/include/asm/pgalloc.h
index b7b2b8d16fad..c6a73772a546 100644
--- a/arch/openrisc/include/asm/pgalloc.h
+++ b/arch/openrisc/include/asm/pgalloc.h
@@ -66,10 +66,10 @@ extern inline pgd_t *pgd_alloc(struct mm_struct *mm)
 
 extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm);
 
-#define __pte_free_tlb(tlb, pte, addr)	\
-do {					\
-	pgtable_pte_page_dtor(pte);	\
-	tlb_remove_page((tlb), (pte));	\
+#define __pte_free_tlb(tlb, pte, addr)				\
+do {								\
+	pagetable_pte_dtor(page_ptdesc(pte));			\
+	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
 } while (0)
 
 #endif
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
