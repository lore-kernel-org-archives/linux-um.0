Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 255AFC7EE21
	for <linux-um@archiver.kernel.org>; Mon,  1 May 2023 19:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LTyFPXZoOp9sk9pWO6JMYM6c4cOrghK01Y411qmcez4=; b=eIiu5s2UfZfvTA
	t6wpdlGUeslyNBnPJlLOp7RDDUgAv+PqaEaBfhOstgg5dpJjSidl+I9ZVQAMKgoprs795GBWjWZkE
	EQwMBSm41v5mnpq5M5V1uqokCsRexdSviTs5x/1VOA+NqzVXld2KRMkj8K6Y3Gr5Yo07ZXpSwkF/N
	9ygz5sLG1H3Uz4fSFXRsu5/3Aly+St+2zwPqkxVQ+5xp4wpjIRHIH2z/4t/mcsLU0t7dq/CbvwhAk
	xcFdeazYJe42F9FvAZsGWkvg993f8DxeXcnE7LRtiv2FWSqKzzoFMs7acr9YFwQrNn0CMrCPUucyq
	YRSs5gc8IF0WO7SueUPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptZUi-00GlKU-29;
	Mon, 01 May 2023 19:47:32 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptZUa-00GlDP-35;
	Mon, 01 May 2023 19:47:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=uIsUNYOwSPNxjYFxvF4LgB4Ah8JH2T7Nmtlw8Cz+gsw=; b=LSD1QKOJmNkMUM0jCuZHMjLXNT
	+jFSSYl2W8CxUAIU5c6fV9D6Sm5/YKH6Peb+Ir4Zvdn5wwLA2mnm1chzb6lnRCue2s/bPvz/ZKbou
	HpFwr2DuHwNE7qy4diJLD6OdZ0srI2d7siQgI3hrpn0jPlToLw3wHsmctY4lBugbbz1mFu6yR9zU6
	pzJ74bngP2XTpUkC2hiE20hsnsBS/yernmLd3Z4T82NUmQs24dlpJXuhtAFR2c8f9P9kSKo51hMrj
	u1whOg0gviom8fEEICjD66DP3kq94uv54xPVd73WCEW5oAyMAcEq/b4b+LqY2wxu/8ntvumH6dViD
	z2szOZ+A==;
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by casper.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ptZD6-007ctF-6V; Mon, 01 May 2023 19:29:22 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1aaea3909d1so17755815ad.2;
        Mon, 01 May 2023 12:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682969359; x=1685561359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uIsUNYOwSPNxjYFxvF4LgB4Ah8JH2T7Nmtlw8Cz+gsw=;
        b=JvPLlmC/XzUWqdECLyDwvfeLFLPFT450E92A3QXyvZyOZFiHjs0SqrfxeBMPzeb8LI
         K2VYtEv3r+e+UcHKuqN8TTRgEDMk5QiHg2w8LWe4aiFQNNV8Hh6df9gt7z6D8qxOouWJ
         wLPmS/k/ifaj+fNqHq4KBrLkalomexLgsPcDr4xMzpwyPwPn0hyVLwNcBBGjvlXZkwRl
         lPtqWGJrBs3wn3DJU9zWYI2bb/1KFvoVhNYahmv1oY0+idoipKM5ABGGY8tIdglpIS4E
         WqBtNig6OCJrivJLAJr7mSv5nUheWG1j4pFaa5KN6zFjtfYkKhLunWXNp9G65rPn/E55
         zhpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682969359; x=1685561359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uIsUNYOwSPNxjYFxvF4LgB4Ah8JH2T7Nmtlw8Cz+gsw=;
        b=C0ft6Nhl68UcrG5IQ3MTPWGjkRU2lvtjycX3hrQO+2vLFJoKAjHa/ab7C+DkepppBK
         1QhaIap3CQb6ZrMIZe1sO9Q9qiuNkDYVbJ04vYmg3jCvQVxcmpnqiESeJnl4XGK/I3D7
         KJZ7h/G9Re2RP3Wr9fmE4sTH9aPHVfSpRahzbp2TvqUaopaI57eIdnPjjc9pEVdzy4rv
         6troIFQqRZdHbbSjGnBVIm09XkG16ZMcGHYXeHVgm6beiVt9ZI2+CBuiO8LVvk/r1wsk
         /wThMVc3yUUzAtmn0xbvgcvIKqfgaV/Pel3mKw0NSUKKjnf5ixHPm1hrgjXZM9IDqlNB
         Ux8Q==
X-Gm-Message-State: AC+VfDxTefLn58rY9GBG6fEDg8oNJiIlX6Rrk9Rgkx1vx6zxdRXCN/qp
	yUWwJW5iDQMF4Ta4Nq7204s=
X-Google-Smtp-Source: ACHHUZ4XGLMgkIB9Q6wCsJwFAYUMJfuCSptJDhnDjc9kz87hQFDk4CAG77uXolw+VTSUtUndXFrgrA==
X-Received: by 2002:a17:903:120c:b0:1aa:f53a:5e45 with SMTP id l12-20020a170903120c00b001aaf53a5e45mr5020547plh.39.1682969359666;
        Mon, 01 May 2023 12:29:19 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::9a2c])
        by smtp.googlemail.com with ESMTPSA id u8-20020a170902bf4800b0019c13d032d8sm18175622pls.253.2023.05.01.12.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:29:19 -0700 (PDT)
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
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH v2 31/34] sparc64: Convert various functions to use ptdescs
Date: Mon,  1 May 2023 12:28:26 -0700
Message-Id: <20230501192829.17086-32-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501192829.17086-1-vishal.moola@gmail.com>
References: <20230501192829.17086-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_202920_292979_CBF38E9A 
X-CRM114-Status: GOOD (  11.63  )
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

As part of the conversions to replace pgtable constructor/destructors with
ptdesc equivalents, convert various page table functions to use ptdescs.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/sparc/mm/init_64.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 04f9db0c3111..eedb3e03b1fe 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2893,14 +2893,15 @@ pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
 
 pgtable_t pte_alloc_one(struct mm_struct *mm)
 {
-	struct page *page = alloc_page(GFP_KERNEL | __GFP_ZERO);
-	if (!page)
+	struct ptdesc *ptdesc = ptdesc_alloc(GFP_KERNEL | __GFP_ZERO, 0);
+
+	if (!ptdesc)
 		return NULL;
-	if (!pgtable_pte_page_ctor(page)) {
-		__free_page(page);
+	if (!ptdesc_pte_ctor(ptdesc)) {
+		ptdesc_free(ptdesc);
 		return NULL;
 	}
-	return (pte_t *) page_address(page);
+	return (pte_t *) ptdesc_address(ptdesc);
 }
 
 void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
@@ -2910,10 +2911,10 @@ void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 
 static void __pte_free(pgtable_t pte)
 {
-	struct page *page = virt_to_page(pte);
+	struct ptdesc *ptdesc = virt_to_ptdesc(pte);
 
-	pgtable_pte_page_dtor(page);
-	__free_page(page);
+	ptdesc_pte_dtor(ptdesc);
+	ptdesc_free(ptdesc);
 }
 
 void pte_free(struct mm_struct *mm, pgtable_t pte)
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
