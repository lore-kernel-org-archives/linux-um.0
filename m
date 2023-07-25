Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22CA1C00528
	for <linux-um@archiver.kernel.org>; Tue, 25 Jul 2023 04:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pDOvlXoX4dKAjzZz3kguE4iLNhiDzS6Xu4AC3imhvHc=; b=XbSVLMNCff7HAp
	YBUL7hg394x4fiNzki1cObLR+xtzu93ry9czjBU3DP0zwq2RR5oZLyu5OjuYFjtTmZlW5mq+D7RnQ
	LOoVKpnTdqmge3PeF653bs3a4VEtVoxcoQ7NmwZxVJd4NryhCUTvIHHUNYfXAE5r5TM6Ekr4NwT2V
	N613Quynscb1riqqgM0DWxIicw0u8kJMilPROMpA/kK3xsJB0LQ+uCO2cWgQzwTVEIxAGzxuuFcVp
	RskT614e/9A6S2zfzIQQA5bY2RBm8TFoyVt4TowgntmTsEzAaqEHrXxtCPhySKwftFh/WOVJcsDPa
	K0sDR2cVx4QETprerL4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qO9cQ-006B6F-1G;
	Tue, 25 Jul 2023 04:25:54 +0000
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qO9Yp-0067wx-2L;
	Tue, 25 Jul 2023 04:22:13 +0000
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-c5cf26e9669so4297006276.0;
        Mon, 24 Jul 2023 21:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690258931; x=1690863731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRfRtQSkmDpdaHgWU+x8J8rVDSFtmuGYMRjnXDV0vQY=;
        b=dIpSbxhiHoEZRybZXN/MVeO3g9uu5Wr3kckw/68K6KR19uhvm31rhYObpAHJDDboRN
         fN++WCiGx69nFrN6B8d/NLOzRwfLSelYXtCG2axa3nxyX1nLiBBRswcz9UUR+gYqr6j2
         ancXFsSIRjlVC+siGAlQPxsDtqvlS6d02kp43kWDLSl5AqbfL3SxRXE8QCvzAnUbAKUU
         YasskwMDZ8VrwnmHFnrCJmWDVf5znjGB85g4q/nAwV8W9HMi2mBDPg8zNmEW2Wmz/ahG
         Gd3GY4JptXSFLWhWmWPz4PD8TWa0sGWxRtah1a9utFkbDSvAH1sC4A2J8wMHczxZTgoj
         5RbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690258931; x=1690863731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JRfRtQSkmDpdaHgWU+x8J8rVDSFtmuGYMRjnXDV0vQY=;
        b=gmQ6OXQmu2xtGIkQjV2RoHmpBT8WQRulhhmGrD+xETwVbV0TS8bvkkJOMXOpBsVBpb
         rvxaMNZO3+hk5s2UKWQigNhWbylj91d54FMzAtwHqqElgpWExtf8XKN62+D3oUQkw587
         xezzvYc3DP02pwlhmFe7PHaN8CzHWVJYaYNm5OPZoJ+PXwxVIjaPuSxxNCe9dLXHTAJZ
         lMge5yFM58Yx/w0H0GoqMtBvJO9c+hSqC4kU0xtskz8+KGq4HpEtnMRqMw+G1bsFO+0U
         zPLQcXuPXWnAUJciXYXm73EPRroW1G2Be44B6jJAFJK8ZnUft6VNhfzFskV6Lku5i7SC
         ohGg==
X-Gm-Message-State: ABy/qLYd55R0WMX8s3rDMFhrmwx89rDGjlF0wcLQWPuoK6MC8uKlPo2S
	Qw8YBQ1xKIcVHot9feAVkHw=
X-Google-Smtp-Source: APBJJlFFrRXSNeam/kWey2sQFPpJrG6DmS1yW3xEJWnQmkKSGkoB3AAvrxYF3pVhZLtkZcpr8uNrnQ==
X-Received: by 2002:a25:2517:0:b0:d0a:86fc:6110 with SMTP id l23-20020a252517000000b00d0a86fc6110mr5159740ybl.28.1690258930893;
        Mon, 24 Jul 2023 21:22:10 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id h9-20020a25b189000000b00d0db687ef48sm1175540ybj.61.2023.07.24.21.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 21:22:10 -0700 (PDT)
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
	Richard Weinberger <richard@nod.at>,
	Mike Rapoport <rppt@kernel.org>
Subject: [PATCH mm-unstable v7 30/31] um: Convert {pmd, pte}_free_tlb() to use ptdescs
Date: Mon, 24 Jul 2023 21:20:50 -0700
Message-Id: <20230725042051.36691-31-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230725042051.36691-1-vishal.moola@gmail.com>
References: <20230725042051.36691-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230724_212211_823702_3EBDE27C 
X-CRM114-Status: UNSURE (   9.16  )
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
ptdesc equivalents. Also cleans up some spacing issues.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/um/include/asm/pgalloc.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/um/include/asm/pgalloc.h b/arch/um/include/asm/pgalloc.h
index 8ec7cd46dd96..de5e31c64793 100644
--- a/arch/um/include/asm/pgalloc.h
+++ b/arch/um/include/asm/pgalloc.h
@@ -25,19 +25,19 @@
  */
 extern pgd_t *pgd_alloc(struct mm_struct *);
 
-#define __pte_free_tlb(tlb,pte, address)		\
-do {							\
-	pgtable_pte_page_dtor(pte);			\
-	tlb_remove_page((tlb),(pte));			\
+#define __pte_free_tlb(tlb, pte, address)			\
+do {								\
+	pagetable_pte_dtor(page_ptdesc(pte));			\
+	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
 } while (0)
 
 #ifdef CONFIG_3_LEVEL_PGTABLES
 
-#define __pmd_free_tlb(tlb, pmd, address)		\
-do {							\
-	pgtable_pmd_page_dtor(virt_to_page(pmd));	\
-	tlb_remove_page((tlb),virt_to_page(pmd));	\
-} while (0)						\
+#define __pmd_free_tlb(tlb, pmd, address)			\
+do {								\
+	pagetable_pmd_dtor(virt_to_ptdesc(pmd));			\
+	tlb_remove_page_ptdesc((tlb), virt_to_ptdesc(pmd));	\
+} while (0)
 
 #endif
 
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
