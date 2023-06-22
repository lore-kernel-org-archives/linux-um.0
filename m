Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D89C04A6A
	for <linux-um@archiver.kernel.org>; Thu, 22 Jun 2023 21:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=o7CStUpLFB7D9jmiRxAOsU9qI9YOzRKCTqHrJk7whg8=; b=D8z847hi9+DEbp
	lmsIb54XUdvvpYZln58HvLAo5nuAZEZqftkRKnR3kcrEfna+gj8bNMVj/rELAIaK1rHWe+Gxar2JG
	SWbza/zSWhgQhsOtC3DGldlB68LSPtczLiZWWaID/q3i5ZsC3gF4MkXuV87qe+sYt45xG/bCKOUpj
	3Chga3SgWdrlE3kB3gQU9AK24pRvN5UHZW0yYIq176mYadM7vo7XCRGY/5iP/1e0x8ms3WNR2nyVM
	H8QwktmX1vuZy7sMkMxJdRJQ+NX7aMVkD8SYkj2q7/k4254hw107oQuLgYSwjBgI/J9H3WHWOdLbH
	RdVWtsHPiJDcTal5/ViQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qCRRt-001lus-0L;
	Thu, 22 Jun 2023 21:02:37 +0000
Received: from mail-qk1-x732.google.com ([2607:f8b0:4864:20::732])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qCROL-001iRy-30;
	Thu, 22 Jun 2023 20:58:59 +0000
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-763dc87aac4so187168285a.2;
        Thu, 22 Jun 2023 13:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687467536; x=1690059536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NG13BwzmmAIpXpcduEwvRHFbS3iQhU18W2JpKLteVDY=;
        b=bI7F5jd8U0pmZoDCjrDdgbVISfzJlV2CUqYAibSVdHZ1OfrWu+Og6tKjTlcLZOSWFx
         f+VE9wjvDVgQCRSbWCOuVgmL30v4mkM+TeOOIsHTqjG+MpjulK0jZg8Kight1gJqL3EJ
         uelPGFi4K83pZcziIo91nBQ/Xb1a7VXoH5rDwteSo81u0B0E0AB9v0ZYlD/3EFJOnXaR
         LHJhz4j3eKvixa2uY3tcUc56YA7rm/NnSwLp194pufjXDiSsyScPz/VvaVef5k0S3cDu
         KA06LddfVd5MnGrcrI8kMVYj85Gsgf9HVHh6xfDQTCqtTE6ZYhHSEi5n5/a6D65T/xzp
         1jRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687467536; x=1690059536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NG13BwzmmAIpXpcduEwvRHFbS3iQhU18W2JpKLteVDY=;
        b=asLfemUoYH36MhK4DCjhwogzATTL43Ij8pvBNOqt4oPXBV7FiPXWLleIyuusbollHT
         EqXlJ6h1s0ruFfNR4/ITvRMtkMZyVUkIMvNCM/Z/89WwLtMnUIMt0vR+CzmbAYlTCaJs
         Zw/KDyfOi1BNC3ozXjh+IVbEufjGTDf3+LaIUpNHLAmsmcpxRy+61z9YvldxGpGywmMp
         DgfY6UG75nJPCAFIB6oWBiL7Y7iSqgcpurP7a6BvYRX+P6yQfczTKw5opFBA8oXLgAt4
         99B/2mw59ob6otVDkytl3gPTVAELz8O0FQH+mvtdj5PZd+EUqe3VgBebkepFFK/KZs4H
         6ztw==
X-Gm-Message-State: AC+VfDxlgLgtO3pS0T7lkRvJqDs7v5VndFpl+pxHT0oyny6+8IoOj7/6
	XJ4Vcaqsi6fVng1JPdDLu9c=
X-Google-Smtp-Source: ACHHUZ6PptFNgBqCV4/Z0wvxz/N4kUJPrg8w5rC/9pu7Gesur9H1ncl000IRfhTCjlej4fSGBBngjg==
X-Received: by 2002:a05:620a:c55:b0:75e:d11d:51ab with SMTP id u21-20020a05620a0c5500b0075ed11d51abmr23662404qki.9.1687467536577;
        Thu, 22 Jun 2023 13:58:56 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::36])
        by smtp.googlemail.com with ESMTPSA id d18-20020a5b0c52000000b00bc501a1b062sm1684937ybr.42.2023.06.22.13.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 13:58:56 -0700 (PDT)
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
Subject: [PATCH v5 29/33] sh: Convert pte_free_tlb() to use ptdescs
Date: Thu, 22 Jun 2023 13:57:41 -0700
Message-Id: <20230622205745.79707-30-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622205745.79707-1-vishal.moola@gmail.com>
References: <20230622205745.79707-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230622_135857_987717_77669FC4 
X-CRM114-Status: GOOD (  10.15  )
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
