Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 954A3C4167B
	for <linux-um@archiver.kernel.org>; Wed, 16 Nov 2022 10:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=z0IxQKTR30iA3+Evq6O440Uy4KbgALxiaMETu9e4MNo=; b=jH8dR2/2RMk+dV
	wUFj8J5vfyNHfWJhQW6PjqRQb9BeWF8SEf/cygHU7Pyiqr1rTeQET/Ywz/xLjT4vb9+a9SLAob34T
	1PCSaKzYUfOVT9l3DGAS0Rfedo/fG/PGqwxkAG3nYugV/1yDZ4o7dmyokBBOarkS7KAeqjZoS+0LH
	1rxACfogYIIckhB8kSEBnaRZVTgbwZzyjOjRrkWwbYEBMsllKKvK8vXiYrpZpn+Z3OSYFEVamj1X7
	nWiGXQEhnxf8Dv+C/+3A4TOxK0Q1Aex5TheHYbOX/iR+g/Giqf0MEYG81Z9YM8LD5Q8xSSpUHPBwH
	c4r4SOeRIryG+7p5xj+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovFiz-002FQM-MV; Wed, 16 Nov 2022 10:32:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovFev-002D4Y-BU
	for linux-um@lists.infradead.org; Wed, 16 Nov 2022 10:28:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1668594524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xyj8jS+C9wqOk3KceDQTo75wMiWZgljnGSBlM8HQloY=;
	b=HyVSO6OqC/gyAIUuVMXoeM1X2q2HGXEdNdaxMdk2Vy95oyYuYPYs+2QP7j1mdL7FrioHdX
	TbTBqLLcuZ5eaT45BNKl7jbv+D65zT6ecgXqA8ct3duF5iZHVlUxfGqv+aN60svjE9SLxy
	2lfc7aOUpVzBnsMZbN7Cm+/iLDmyMoE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-156-1i0B0n5wO9KbojDzH-noSA-1; Wed, 16 Nov 2022 05:28:39 -0500
X-MC-Unique: 1i0B0n5wO9KbojDzH-noSA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6CE1B86F132;
	Wed, 16 Nov 2022 10:28:37 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.193.216])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D7D7C2028E8F;
	Wed, 16 Nov 2022 10:28:29 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	linux-alpha@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-ia64@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-samsung-soc@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Nadav Amit <namit@vmware.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <songmuchun@bytedance.com>,
	Shuah Khan <shuah@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	David Airlie <airlied@gmail.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christoph Hellwig <hch@infradead.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>
Subject: [PATCH mm-unstable v1 10/20] RDMA/umem: remove FOLL_FORCE usage
Date: Wed, 16 Nov 2022 11:26:49 +0100
Message-Id: <20221116102659.70287-11-david@redhat.com>
In-Reply-To: <20221116102659.70287-1-david@redhat.com>
References: <20221116102659.70287-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221116_022845_494849_E86C955B 
X-CRM114-Status: GOOD (  14.95  )
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

GUP now supports reliable R/O long-term pinning in COW mappings, such
that we break COW early. MAP_SHARED VMAs only use the shared zeropage so
far in one corner case (DAXFS file with holes), which can be ignored
because GUP does not support long-term pinning in fsdax (see
check_vma_flags()).

Consequently, FOLL_FORCE | FOLL_WRITE | FOLL_LONGTERM is no longer required
for reliable R/O long-term pinning: FOLL_LONGTERM is sufficient. So stop
using FOLL_FORCE, which is really only for ptrace access.

Tested-by: Leon Romanovsky <leonro@nvidia.com> # Over mlx4 and mlx5.
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/infiniband/core/umem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 86d479772fbc..755a9c57db6f 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -156,7 +156,7 @@ struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long addr,
 	struct mm_struct *mm;
 	unsigned long npages;
 	int pinned, ret;
-	unsigned int gup_flags = FOLL_WRITE;
+	unsigned int gup_flags = FOLL_LONGTERM;
 
 	/*
 	 * If the combination of the addr and size requested for this memory
@@ -210,8 +210,8 @@ struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long addr,
 
 	cur_base = addr & PAGE_MASK;
 
-	if (!umem->writable)
-		gup_flags |= FOLL_FORCE;
+	if (umem->writable)
+		gup_flags |= FOLL_WRITE;
 
 	while (npages) {
 		cond_resched();
@@ -219,7 +219,7 @@ struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long addr,
 					  min_t(unsigned long, npages,
 						PAGE_SIZE /
 						sizeof(struct page *)),
-					  gup_flags | FOLL_LONGTERM, page_list);
+					  gup_flags, page_list);
 		if (pinned < 0) {
 			ret = pinned;
 			goto umem_release;
-- 
2.38.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
