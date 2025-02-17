Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E18CCC021AB
	for <linux-um@archiver.kernel.org>; Mon, 17 Feb 2025 19:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=atMZRm9oTSJ7EdJlQ3h7iJvkLCf12vGPXz2zKSkO6zo=; b=PpHmhgwUtCR8rAUGlKXJmltdwh
	Zrq9wPYJgYA5OxMoEa/dp45340qm1E6BK4t2DoOLnevQWa4KZIVvBCRifPzTtvtr2f93rK1/rX6TD
	KUwalOsLUHi5FTd6gcmeb5Y4B9VZk1Xj/8dJgeoROWA4iORNX3cnkqhvmUPoemXRfinXhnXHY7RE1
	9H/Olj3U2mWqtYxMcSKcrUrzZK3zYnKW24Pxw8Y+Vt79VCZ0frErVRuComoCf1wBqZ0xxxXpPAPV0
	UG6mKVTTefkqREZ5q8OlLUk4Zr7y679FEtRbU7bjREKDWpNge1RUWnOozGJb5D1DJMkdpD+8xtpKK
	bqZAo9VA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tk6W1-00000005iLj-2Dbu;
	Mon, 17 Feb 2025 19:10:49 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tk6Tw-00000005hwQ-1Cwy
	for linux-um@bombadil.infradead.org;
	Mon, 17 Feb 2025 19:08:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=atMZRm9oTSJ7EdJlQ3h7iJvkLCf12vGPXz2zKSkO6zo=; b=thrH97rgQk5cY6SsCjZalRSn93
	HEQL4Fk+SimS8m8tDxDCmy2Unz81Dre8AePAFchB1p5SNzijFyHibJ6leOgVkq7ydpyDSd1Hm5diu
	lFGZZqXQR5j2Tf4MB9wann/BnSax/OOuva/9PjoPPkSnezTUoKZpBEA/tIukuYEAm9AD5qRyIh4lW
	Y1jjuvk2H/pOVPtbROx5QUrqcuMMBMlVw5lALGiInZjC638qVSFtxWjFoKxtL2gYFsWl3fdFPcDEh
	IaffNaod96rCTnh7P8Ih+8Zbq/i1e1Ux3LterFamX4KVy9Th0HjUymOZL87+i9HUhimY9zJy/brrk
	4dPWDbnw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tk6Tv-00000001pBc-0Zy7;
	Mon, 17 Feb 2025 19:08:39 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-arch@vger.kernel.org,
	x86@kernel.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org
Subject: [PATCH 6/7] mm: Make mk_pte() definition unconditional
Date: Mon, 17 Feb 2025 19:08:33 +0000
Message-ID: <20250217190836.435039-7-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217190836.435039-1-willy@infradead.org>
References: <20250217190836.435039-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

All architectures now use the common mk_pte() definition, so we
can remove the condition.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3ef11ff3922f..62dccde9c561 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1916,14 +1916,12 @@ static inline struct folio *pfn_folio(unsigned long pfn)
 	return page_folio(pfn_to_page(pfn));
 }
 
-#ifndef mk_pte
 #ifdef CONFIG_MMU
 static inline pte_t mk_pte(struct page *page, pgprot_t pgprot)
 {
 	return pfn_pte(page_to_pfn(page), pgprot);
 }
 #endif
-#endif
 
 /**
  * folio_maybe_dma_pinned - Report if a folio may be pinned for DMA.
-- 
2.47.2


