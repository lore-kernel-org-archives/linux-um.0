Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF0A0CF2567
	for <linux-um@archiver.kernel.org>; Wed, 19 Nov 2025 07:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x1iNplE99sGAypoCEEPI8YVyyZSSPtGtkqVo740CsVs=; b=MdFswPa4pu3SqiISaUdrqQZpBh
	ZaLkUOYYFhF3uoPqqT0PDmwpwqrCuFZ+eSS7w8cGf/wjDjKgPExKOzvgu8Zvo4ZqXGdQDWFaJR0K+
	EagqL5Bq9LisjhmtlEkgosUbnzTEgJ5csRHVb/Fh005pVipaiUFmxTvoonFGjo6cg00lsPVjtuss5
	I9Wh2XSZEZtbipgSvEkHq2cuUWOqKcLHif3lbdo/wJ0/QhwIBLrZByO5P6gBTzZSNvdCvQHt/Gbtj
	0mPly2xLMVOwMQancWxT7rsnw7AoDT27gznAENSokFFaKmIlxVAzvkYNzf4KZowztV/zXVtnwiDiI
	YlP2Sp9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLcgH-00000002iE7-2xOR;
	Wed, 19 Nov 2025 07:32:45 +0000
Received: from out-171.mta0.migadu.com ([2001:41d0:1004:224b::ab])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLcgF-00000002iCj-13XH
	for linux-um@lists.infradead.org;
	Wed, 19 Nov 2025 07:32:44 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763537560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x1iNplE99sGAypoCEEPI8YVyyZSSPtGtkqVo740CsVs=;
	b=vbucHj67nP76kiXE1QyY8BDwAzCLOGQUCC0PuxiMX09JuvuPEDA7TD6Faql30bLUhiVf76
	IOCfwQsCxOzvk1jJIx6cB/4wVYkH1Ymgi7/nv/RuHvh3YJEurHzaNl8B/s41J5hlfHjpnD
	Wr8XalvYuqFraXJCvIIVSZfyHo2LYco=
From: Qi Zheng <qi.zheng@linux.dev>
To: will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	peterz@infradead.org,
	dev.jain@arm.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ioworker0@gmail.com,
	linmag7@gmail.com
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-alpha@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-um@lists.infradead.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 1/7] mm: change mm/pt_reclaim.c to use asm/tlb.h instead of asm-generic/tlb.h
Date: Wed, 19 Nov 2025 15:31:18 +0800
Message-ID: <e9d510106b5bf72a9b577b8c5ad161fd3c29c2b6.1763537007.git.zhengqi.arch@bytedance.com>
In-Reply-To: <cover.1763537007.git.zhengqi.arch@bytedance.com>
References: <cover.1763537007.git.zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251118_233243_432452_3014E929 
X-CRM114-Status: UNSURE (   9.80  )
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

From: Qi Zheng <zhengqi.arch@bytedance.com>

Generally, the asm/tlb.h will include asm-generic/tlb.h, so change
mm/pt_reclaim.c to use asm/tlb.h instead of asm-generic/tlb.h. This can
also fix compilation errors on some architecture when CONFIG_PT_RECLAIM
is enabled (such as alpha).

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/pt_reclaim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/pt_reclaim.c b/mm/pt_reclaim.c
index 0d9cfbf4fe5d8..46771cfff8239 100644
--- a/mm/pt_reclaim.c
+++ b/mm/pt_reclaim.c
@@ -2,7 +2,7 @@
 #include <linux/hugetlb.h>
 #include <linux/pgalloc.h>
 
-#include <asm-generic/tlb.h>
+#include <asm/tlb.h>
 
 #include "internal.h"
 
-- 
2.20.1


