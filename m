Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7510D65526
	for <linux-um@archiver.kernel.org>; Wed, 17 Dec 2025 09:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bw+1Lau4jkXgNGH1w/oSy1pnIcM7wv7myPLVDHR+sFs=; b=SbdzkfXJQSXmB1BxlQKL6zkbUJ
	p/3HbcjVSp51MWohtodvE41vLQUjtKLR34tplcPvL6+rIQPwukwG0/Ds1THyVr93rxVOEq+7KfrKc
	AIbwjAyEn/nI67FyAAZvAbRn4lRHJq0YCMy60UDHEc+FxniP9PtdrfWzGCA8rFTp70XgxdfqRi6Jp
	kzaUFHWfD/zUTogUxQMgVDRc1YX+1lWttLerZsl56WNZnoVrCv15yPSvu6nwQZqKYneiBORbl0fJf
	gkYdE9J4oog5bXaZEwKHp/hwlkzx7DDkhArrAKPvVOHIba09pulfsa0vsXqBtQ1p4+CgUUVasnl6o
	g9CrZl7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVo7c-00000006Snw-2ijT;
	Wed, 17 Dec 2025 09:47:04 +0000
Received: from out-176.mta1.migadu.com ([2001:41d0:203:375::b0])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVo7Z-00000006SnX-2OzA
	for linux-um@lists.infradead.org;
	Wed, 17 Dec 2025 09:47:03 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765964817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bw+1Lau4jkXgNGH1w/oSy1pnIcM7wv7myPLVDHR+sFs=;
	b=ly15AwCgeTCvVgfKEAGM4N6+Qr/3bm4QCI+29u9WGu6pcYXwgBs1OKy52f7HilHkjkHMPR
	sHiouE4YFfRjE5AAkAK/J8ELyx11QzPsbKV6xCapoiF96UFCkEGY/h6yJrWtaXJGp1y3sT
	pxSpzXa0XWo0t7W7DaurMYa8P4nGSAc=
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
Subject: [PATCH v3 1/7] mm: change mm/pt_reclaim.c to use asm/tlb.h instead of asm-generic/tlb.h
Date: Wed, 17 Dec 2025 17:45:42 +0800
Message-ID: <67a0725081c82cdc2debce6cbdb9273412039553.1765963770.git.zhengqi.arch@bytedance.com>
In-Reply-To: <cover.1765963770.git.zhengqi.arch@bytedance.com>
References: <cover.1765963770.git.zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251217_014701_825132_328A9F6D 
X-CRM114-Status: UNSURE (   7.89  )
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
mm/pt_reclaim.c to use asm/tlb.h instead of asm-generic/tlb.h. This is a
preparation for enabling CONFIG_PT_RECLAIM on other architectures, such as
alpha.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>
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


