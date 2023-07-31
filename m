Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5E6CC001E0
	for <linux-um@archiver.kernel.org>; Mon, 31 Jul 2023 17:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/HjZSdb4wB3dJhZQQOxeFh1iD2vlYz3MlWwNysi/NfQ=; b=XYZIJHz++3d5iL
	FqAPqnmUEuJNbIAnIJqWygoveCyurmIey1YN3H286rtMRrgE9al9r7oRanu0RRdXuWakcCJek1Ep9
	liKMCj2u063R50aoeMqXXRcqS8C8JsWRxAC/WdgsSIoHR3HMKbCefvR3Z4ly8Yy9UgBs8+/VJPKIx
	GnOCLO22Fys7/N0v7EhWs9kO8v+ZyF6P0gPtKdQ9fTdNOQnYcrbakirilGFuqoAH4YFfGUMZkYLo/
	jqqrU+LuwXdM1hYcK/28rpEKN3xSIBRMBsC+uexaYDtphOZijKas5uasluMpCQG5bJ7YDjF3UntYB
	de+HEKpgJM8hFIw1alkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQWO9-00GnxV-1I;
	Mon, 31 Jul 2023 17:08:57 +0000
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQWJp-00Gkf5-1K;
	Mon, 31 Jul 2023 17:04:30 +0000
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-bff89873d34so3787539276.2;
        Mon, 31 Jul 2023 10:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690823068; x=1691427868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0AnRv7d38hHUVaoAGins0CaWMMRgzo0GwUb20Y9YoSw=;
        b=NCurFfzESiDx9LJv2ZuGZQRVSVONypfRSwp3UCPEimaJ0icLYx3MO5YhqaCkZBIR4Z
         l/oM16YnfTb6kc+h35gY+zFIGDLtxKkoqGrDMVFkoTTTXsh+xxxFI4aLUNlB4KO70CwF
         WRXyA1UJf7HH1gQrjYriX6iIExSZBg+JSpTH9iwwtWaRApzq4XeZb8/+i18fB7X+SbC5
         QNboB3mts09Ey/BGMzFFSqcMjH751GJumhdsMsGsSdMw+HfAwMqxwq/99BYNjLDy4Uwv
         T3I5GqlbCblT84V09f9Mmwx3a1PPDI4Kl+kA59SDykK80t9C+rJKaVJTL/sIPY4ok+Qa
         Stkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690823068; x=1691427868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0AnRv7d38hHUVaoAGins0CaWMMRgzo0GwUb20Y9YoSw=;
        b=DOODZDjOEIM+6HqFhMj1A/MnulvcB17ttMKwjVHD0dJhhMMPpEbX+HcIV1Xgb9UQVQ
         G7w4Ng4Tvsq0FE2aCtQI/In8bZG9fQZ7x9zNN7G8cCTsZuVumJEr1UFimf+ZO+n2lBt4
         WUMcbbHJB4xhJa6gvz1KTPxj6596QD2mVxjqhb/35QIH+u8yn2DYEcwhCjFzoaGim83i
         NyS2pXKWoiC7vW8giYP7fxIx+Ht7gddDkM3MJ7PY9A7hvTVDZ7zMjxETRmVwtO0thZAJ
         bLiyZ7YiRDdu6d/7mLf9jXMObXdGu03GwA/slzH8hH61KlcbkGTbwGYYdKan/FraxIMI
         rpDQ==
X-Gm-Message-State: ABy/qLb5MCOyuzjy9Ld3tO7lcBOg2XaWlzbe5Ju2FauFSnvZKNCGhmVX
	fsBAnGe294JrJo8z5LfPE08=
X-Google-Smtp-Source: APBJJlH2OMZz7Ho/ZKKTbee+QNJ7Mj2bTW6BCb3XUatLH/MvStrEwd2dCkY4APrPVNcSGvWAfXuhUw==
X-Received: by 2002:a25:acd2:0:b0:c6d:f875:520e with SMTP id x18-20020a25acd2000000b00c6df875520emr7715849ybd.49.1690823068568;
        Mon, 31 Jul 2023 10:04:28 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id x31-20020a25ac9f000000b00c832ad2e2eesm2511833ybi.60.2023.07.31.10.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 10:04:28 -0700 (PDT)
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
Subject: [PATCH mm-unstable v8 25/31] openrisc: Convert __pte_free_tlb() to use ptdescs
Date: Mon, 31 Jul 2023 10:03:26 -0700
Message-Id: <20230731170332.69404-26-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230731170332.69404-1-vishal.moola@gmail.com>
References: <20230731170332.69404-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230731_100429_452438_256011E9 
X-CRM114-Status: GOOD (  10.09  )
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
