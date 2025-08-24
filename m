Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B6BCA0EEB
	for <linux-um@archiver.kernel.org>; Sun, 24 Aug 2025 15:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/5Rya+Gi6QjQkA4vrw0G7aYifLN/Ov6WOyx29bWPJI8=; b=rB0NxswNGH+pcaXjV8Q3oS/6Og
	uUl7DiZWUEEEx71L3fYqtVKq53NTzUgHYJVMtnrVZAktymA7c+kaOpfe3KRmENm4sJluQgKymmgbM
	dfMvYyRAnGM/AGQi77aE31gheCVlVAxCOcjj6eulD4BwH5x3Z5+IlKkrUVAcgLl40LVtTE+jIVO4b
	4pPzGhERmhFPSV3lpXAXDOpAh6gzFUj3y1pFAuJuNjQ+/gfz2Q4OxCPrykiB9Tr5+Gb9iOxV7rNKg
	cqARuKqEPIu/8voYh10l5x0cZY1mtUJ6fRcK/1D1jbHU/sPRJG2m+lssrJNlFen3XjsY1SEGiF9LA
	x1izYBjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqCuG-00000006JHe-0RfK;
	Sun, 24 Aug 2025 15:45:20 +0000
Received: from out-188.mta1.migadu.com ([95.215.58.188])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqCuD-00000006JFL-2mZ0
	for linux-um@lists.infradead.org;
	Sun, 24 Aug 2025 15:45:18 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756050315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/5Rya+Gi6QjQkA4vrw0G7aYifLN/Ov6WOyx29bWPJI8=;
	b=ZYKBd+7OxtjOxjgVN8W2LqEhC8xL6i30L22Fp4PIT68BGU7KpndqNNAWQo8EGsurmPNNr5
	kkpNLIuMeakCIArHbdhC2IebxIzQoK4ptlxdwbB6J6bec9UdFpEVy1xgl8F9udxoW2a1pG
	gUjydEhl1m8J+5E1HkAjRFGnLwfN4bM=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: [PATCH 6/7] um: Remove outdated comment about STUB_DATA_PAGES
Date: Sun, 24 Aug 2025 23:44:24 +0800
Message-Id: <20250824154425.2243375-7-tiwei.bie@linux.dev>
In-Reply-To: <20250824154425.2243375-1-tiwei.bie@linux.dev>
References: <20250824154425.2243375-1-tiwei.bie@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250824_084517_851465_254EFEB2 
X-CRM114-Status: UNSURE (   8.39  )
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

From: Tiwei Bie <tiwei.btw@antgroup.com>

STUB_DATA_PAGES is no longer required to be a power of two since
commit 91f0a0c5cc5b ("um: Calculate stub data address relative to
stub code"). Remove the outdated comment.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/shared/as-layout.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/include/shared/as-layout.h b/arch/um/include/shared/as-layout.h
index 2f9bfd99460a..eacf18ec9d0c 100644
--- a/arch/um/include/shared/as-layout.h
+++ b/arch/um/include/shared/as-layout.h
@@ -23,7 +23,7 @@
 #define STUB_START stub_start
 #define STUB_CODE STUB_START
 #define STUB_DATA (STUB_CODE + UM_KERN_PAGE_SIZE)
-#define STUB_DATA_PAGES 2 /* must be a power of two */
+#define STUB_DATA_PAGES 2
 #define STUB_END (STUB_DATA + STUB_DATA_PAGES * UM_KERN_PAGE_SIZE)
 
 #ifndef __ASSEMBLER__
-- 
2.34.1


