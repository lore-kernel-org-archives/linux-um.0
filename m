Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF2BFC07E8C
	for <linux-um@archiver.kernel.org>; Tue, 25 Jul 2023 04:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=o7CStUpLFB7D9jmiRxAOsU9qI9YOzRKCTqHrJk7whg8=; b=Je9M2FYmCILvY5
	E/Z+95Sp28uvBQa/GYt1VcZFlegWRx8KYWGF1wZJGE5mmj95sw31PU3Tq/xSdTUbpKpTIkW4HHuJm
	uAJ+M+/5UQI8kbYWUoc70wNYomi+SVc30cVZmHkVG+z5EiPPLzpuKUyvBzXfdKeINhu4Twv86tIm8
	h4mn5qsQtvIKVX/xaBoNp+/fLTKpqP78awFFe0bEkFLgui0srPPBOvfas9c/bkCYg7qksW7ZE+J2W
	mtL2GdODlHWE56e5aaNcIeiiD8+4pU+jkyU+Wvf6y4uaph2n7rcTztHUf01wCkW6yUVT0Qll116Vb
	WJUAXCc9LwGO/Doyb/NQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qO9bu-006Adw-0Z;
	Tue, 25 Jul 2023 04:25:22 +0000
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qO9Yj-0067qF-0W;
	Tue, 25 Jul 2023 04:22:06 +0000
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-c4cb4919bb9so5540836276.3;
        Mon, 24 Jul 2023 21:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690258924; x=1690863724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NG13BwzmmAIpXpcduEwvRHFbS3iQhU18W2JpKLteVDY=;
        b=GBQqKOXR4MY0Ps6Ytzn9QjLc5kcnNARqYVMOSqCl4nxxP5zueTINjr7iMbjZhk8uU1
         uF+ZNdDLWemlb8QXVTn60jLorPF4KaxuajyPq7XQ8ZCUpgrsfyxcNU4aZsjJHBdfgv4V
         f3SehFOrdMCWYaV3GNfOxXZlwwtfQps2pLwSnw0r1MZbny4VXC0cZl+5ECg/uwswSkJJ
         2spe5/EA1yI0VqTuQ1Drr9GEQcMwkhM/FKbElCEbuZdJkSdi81Zbahgosic5IMYJMWsY
         zz7YF2FVGFBOrfl6ZnWHbV39qhmx668oKEAvnRRKMjMLLqABK50UfsT2Oc13y2cvxYxd
         xuhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690258924; x=1690863724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NG13BwzmmAIpXpcduEwvRHFbS3iQhU18W2JpKLteVDY=;
        b=cGP2hmbDt7UqVCPJCqefjxoNx5aA/3i11j3JYA7Aur0F9VuzSOqpDDGgprlubUNE62
         wHoo7yNp055I1tiZdvsvw2OKkUx7IXNs66tEmAzTRBRKKumMflASVxeYHwEQPtlPxQjG
         weBdqve1lWSDGwxx8CpOLqF4AqdsD8KZ+aeKIEKXpR1iRMj0Rnoockwd1U6J6i6EYveQ
         bx7Jmpnug5PBAdbGBfWMgtvTH1Hk7jOG7fshWWicCDgfiaRZQl5Rm9d1qr7CFkZXcSFQ
         EJslsU15yvnVx5Df6KH5DEP5Ma1+PvZ6sN/3Ps6D8PlFPXWKRP5/l56EXGX9y6WKsfn+
         Ke7w==
X-Gm-Message-State: ABy/qLa/g29soOr7LK127H8jUFwsiakG3pVOgUV65Jss956G34dKKdtt
	3IvhN3MEEN/LI8z8waAZBHarNd98ZqTvLw==
X-Google-Smtp-Source: APBJJlFIEKBO4FnrV/9ajkbTKUo/vEdRCYW7kk6X3z3g19puIv3mx6us1kMtRHRFLnY2I/2ODsKhEw==
X-Received: by 2002:a25:2309:0:b0:d0d:2d82:7a27 with SMTP id j9-20020a252309000000b00d0d2d827a27mr4389099ybj.13.1690258924402;
        Mon, 24 Jul 2023 21:22:04 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id h9-20020a25b189000000b00d0db687ef48sm1175540ybj.61.2023.07.24.21.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 21:22:04 -0700 (PDT)
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
	Geert Uytterhoeven <geert+renesas@glider.be>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Mike Rapoport <rppt@kernel.org>
Subject: [PATCH mm-unstable v7 27/31] sh: Convert pte_free_tlb() to use ptdescs
Date: Mon, 24 Jul 2023 21:20:47 -0700
Message-Id: <20230725042051.36691-28-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230725042051.36691-1-vishal.moola@gmail.com>
References: <20230725042051.36691-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230724_212205_207534_D48ACC87 
X-CRM114-Status: GOOD (  10.45  )
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
