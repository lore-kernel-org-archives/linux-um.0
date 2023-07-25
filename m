Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E8FDC001DF
	for <linux-um@archiver.kernel.org>; Tue, 25 Jul 2023 04:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/HjZSdb4wB3dJhZQQOxeFh1iD2vlYz3MlWwNysi/NfQ=; b=fPb917NP/g3B/B
	A09RLv5aHqJWJsCEPzCcm0MGl1qYCgusHr2a2ndVnSF07h9fL2cDnEznRnfOgi5yWy3AebL4/V6ll
	v9P2sHp3hdxrmpaZEe1+Tvq/yjSJhWCsD0oyuqR0WSYrLgjYuq/lRySAQBa+MfpZL257Rij5CHSe3
	8vY9TB5Zh3x6kAO9HhF8bEYJsqH3KHB7ZaYxcHnggFlLOnoZ1JuIkwpWe6i2lT0fegA1BCliM1RLS
	7rEvt86lSz4dlASYaT+KIforKHMLflxxHBr/g4oAv0YjQupi4BaDHSmiE6TAB8fTeHVIyZM94RpoF
	u7nUaAJs8A7pApmfSTJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qO9bY-006AHH-26;
	Tue, 25 Jul 2023 04:25:00 +0000
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qO9Yf-0067lV-0L;
	Tue, 25 Jul 2023 04:22:02 +0000
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d0e009433c4so2258232276.2;
        Mon, 24 Jul 2023 21:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690258920; x=1690863720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0AnRv7d38hHUVaoAGins0CaWMMRgzo0GwUb20Y9YoSw=;
        b=pF3/aUrb3JX49e0u22fW9ciATl7u+MUedSxMIodJhkvCSur2UbV1ymLo02TZ+J+kPF
         Kx5HeDHnWoCFEiMJQRkEFLmGeKvRgst1SRco5Nf2sutYKL2w+MtMEjm9RYoVaVV/WbaV
         YVQVPd7LOUuBtkmGFl+FmiiuwqN1u54q2lW5pHrezKOb3piONF3+v81Wt/4bQq44saNJ
         XmrP/XQPqOefJAz6PJqT1BLnizFGrc2xSl/LadxebvB7doG0PAx8D01yebNX4JhyxCLk
         tgaBucE6SVITexqLzDjpMrpbMyKpy8WP6lMzfEvzG49OmJW0+1GrWwpk6bQXNmC80wMv
         +HWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690258920; x=1690863720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0AnRv7d38hHUVaoAGins0CaWMMRgzo0GwUb20Y9YoSw=;
        b=hYyq53gIFxt2g31UFkmga+2niG9dVk6fDEytWwcSz+MQhmBjwgG+Sl8IzIw2DAuN1D
         pRc19L97kOSA4lk0yHC0MjoR+WzA+9C0kqgDzr8H50okzKfdlHqEdH+NkBZ8wSK8nkT2
         /Uwq1Bz8811PoP1stmcSrXu0H5rJNp68UPCRUUjt1L9TRwSl190sULPVd61KyrYSesjd
         2wJr0HDnHLnwOM8CxvtYoibFs6wEqJncUSsg+xMDnB8lyh+bdnch9i+Hq3OHKphJBGhJ
         KiZQTix9vGieS57hxNebIb1PaVakDE8dRuAHSCIQJDQauZq4TSm9pLSoiDKwANdS7ILE
         hqog==
X-Gm-Message-State: ABy/qLYh9kflNvHFw6aedpcBa4s75ETzQU5GQiwqhMZJwi3KU54Ik5lH
	UcXxQ4n0yLDQ4uVdFCY2Njo=
X-Google-Smtp-Source: APBJJlEdkcahnNVyEvlWTLDmpaRsWSF5WciOnYxL0p0ce55MSQlJt+bgPnW2jeW0QxRihWyF8hwpDQ==
X-Received: by 2002:a25:ac42:0:b0:d0a:da40:638e with SMTP id r2-20020a25ac42000000b00d0ada40638emr6436068ybd.12.1690258920108;
        Mon, 24 Jul 2023 21:22:00 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id h9-20020a25b189000000b00d0db687ef48sm1175540ybj.61.2023.07.24.21.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 21:21:59 -0700 (PDT)
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
	Jonas Bonn <jonas@southpole.se>,
	Mike Rapoport <rppt@kernel.org>
Subject: [PATCH mm-unstable v7 25/31] openrisc: Convert __pte_free_tlb() to use ptdescs
Date: Mon, 24 Jul 2023 21:20:45 -0700
Message-Id: <20230725042051.36691-26-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230725042051.36691-1-vishal.moola@gmail.com>
References: <20230725042051.36691-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230724_212201_181211_4F2F78EF 
X-CRM114-Status: UNSURE (   9.74  )
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
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
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
