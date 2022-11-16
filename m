Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81AEBC433FE
	for <linux-um@archiver.kernel.org>; Wed, 16 Nov 2022 10:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=99HxU6Au/EmMWVPGg5AQBc0RYaGbggAUt5akypLrbiI=; b=QvCt7gg6K4b3tv
	O7s+xFvYYb+4sWCgZx7Xatuc166oDv6hJI5mJRXnuG3Nn3YnFqE9kNHmBkSrsh5Oq/q+nm+PteFx7
	QBs7xiPvpJykuSMgqdkrcpXRCE4hIyonQvK5Oe34oWpcIoD7tH+l9yXFVKAoVKxvuPEt03TUoK3fd
	QPEjO8Hg5upSjAAkW4R5Cfx3WXXUshZv3WVthVomPavmjl1Orzy2lED3y/0iYaEiaQH2u+FzHC6lz
	DqAosAUBr6/Ral9StC8kIrPnCI0CtQfOvPk7tlxGdVoMfSAyLlAjpM1WYPzVLCEhBhYU13V6ljngq
	YzSf3N5DIICw0ygTNuyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovFla-002HFV-Vt; Wed, 16 Nov 2022 10:35:39 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovFfK-002DLA-98
	for linux-um@lists.infradead.org; Wed, 16 Nov 2022 10:29:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1668594549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PtZFIm00BoukAq0r3vxYea1/oUxWby/yeQnBgXcmZG8=;
	b=hr1vtWj7hSzN/U8/+SOSHRcATuJ36HbEUAvStWcViiqkwKmdcn4tKY8i/Ex6sKYidjE8NW
	VYhLKt5bMGEzKTpCEyjFYcymoS5Y29s+T2FkjullqOkN5yx5mjGZklHUhGSSbUOTl9QG2h
	foWk8N3D4JgNB0zO77I1/HFftwrsAsY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-uLqpp3ByOjmb0y4uEYa0gA-1; Wed, 16 Nov 2022 05:29:02 -0500
X-MC-Unique: uLqpp3ByOjmb0y4uEYa0gA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 95160811E7A;
	Wed, 16 Nov 2022 10:29:00 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.193.216])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4EDB82028E8F;
	Wed, 16 Nov 2022 10:28:53 +0000 (UTC)
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
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH mm-unstable v1 13/20] media: videobuf-dma-sg: remove FOLL_FORCE usage
Date: Wed, 16 Nov 2022 11:26:52 +0100
Message-Id: <20221116102659.70287-14-david@redhat.com>
In-Reply-To: <20221116102659.70287-1-david@redhat.com>
References: <20221116102659.70287-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221116_022910_432633_4EB1B6EC 
X-CRM114-Status: GOOD (  15.85  )
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

Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/media/v4l2-core/videobuf-dma-sg.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/media/v4l2-core/videobuf-dma-sg.c b/drivers/media/v4l2-core/videobuf-dma-sg.c
index f75e5eedeee0..234e9f647c96 100644
--- a/drivers/media/v4l2-core/videobuf-dma-sg.c
+++ b/drivers/media/v4l2-core/videobuf-dma-sg.c
@@ -151,17 +151,16 @@ static void videobuf_dma_init(struct videobuf_dmabuf *dma)
 static int videobuf_dma_init_user_locked(struct videobuf_dmabuf *dma,
 			int direction, unsigned long data, unsigned long size)
 {
+	unsigned int gup_flags = FOLL_LONGTERM;
 	unsigned long first, last;
-	int err, rw = 0;
-	unsigned int flags = FOLL_FORCE;
+	int err;
 
 	dma->direction = direction;
 	switch (dma->direction) {
 	case DMA_FROM_DEVICE:
-		rw = READ;
+		gup_flags |= FOLL_WRITE;
 		break;
 	case DMA_TO_DEVICE:
-		rw = WRITE;
 		break;
 	default:
 		BUG();
@@ -177,14 +176,11 @@ static int videobuf_dma_init_user_locked(struct videobuf_dmabuf *dma,
 	if (NULL == dma->pages)
 		return -ENOMEM;
 
-	if (rw == READ)
-		flags |= FOLL_WRITE;
-
 	dprintk(1, "init user [0x%lx+0x%lx => %lu pages]\n",
 		data, size, dma->nr_pages);
 
-	err = pin_user_pages(data & PAGE_MASK, dma->nr_pages,
-			     flags | FOLL_LONGTERM, dma->pages, NULL);
+	err = pin_user_pages(data & PAGE_MASK, dma->nr_pages, gup_flags,
+			     dma->pages, NULL);
 
 	if (err != dma->nr_pages) {
 		dma->nr_pages = (err >= 0) ? err : 0;
-- 
2.38.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
