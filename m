Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iN8QP-0001u6-75
 for linux-um@lists.infradead.org; Wed, 23 Oct 2019 04:39:17 +0000
Received: by mail-pf1-x443.google.com with SMTP id c13so877847pfp.5
 for <linux-um@lists.infradead.org>; Tue, 22 Oct 2019 21:39:08 -0700 (PDT)
From: Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC PATCH 35/47] xfs: support for non-mmu architectures
Date: Wed, 23 Oct 2019 13:38:09 +0900
Message-Id: <e52ac5600f91082a2b3e1acc263280e1b7379bed.1571798507.git.thehajime@gmail.com>
In-Reply-To: <cover.1571798507.git.thehajime@gmail.com>
References: <cover.1571798507.git.thehajime@gmail.com>
MIME-Version: 1.0
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
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org
Cc: Octavian Purdila <tavi.purdila@gmail.com>, Akira Moroo <retrage01@gmail.com>

From: Octavian Purdila <tavi.purdila@gmail.com>

Naive implementation for non-mmu architectures: allocate physically
contiguous xfs buffers with alloc_pages. Terribly inefficient with
memory and fragmentation on high I/O loads but it may be good enough
for basic usage (which most non-mmu architectures will need).

Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
---
 fs/xfs/xfs_buf.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index ca0849043f54..c4bb390cc9b0 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -313,6 +313,7 @@ xfs_buf_free(
 	ASSERT(list_empty(&bp->b_lru));
 
 	if (bp->b_flags & _XBF_PAGES) {
+#ifdef CONFIG_MMU
 		uint		i;
 
 		if (xfs_buf_is_vmapped(bp))
@@ -324,6 +325,10 @@ xfs_buf_free(
 
 			__free_page(page);
 		}
+#else
+		free_pages((unsigned long)page_to_virt(bp->b_pages[0]),
+			   order_base_2(bp->b_page_count));
+#endif
 	} else if (bp->b_flags & _XBF_KMEM)
 		kmem_free(bp->b_addr);
 	_xfs_buf_free_pages(bp);
@@ -390,7 +395,14 @@ xfs_buf_allocate_memory(
 		struct page	*page;
 		uint		retries = 0;
 retry:
+#ifdef CONFIG_MMU
 		page = alloc_page(gfp_mask);
+#else
+		if (i == 0)
+			page = alloc_pages(gfp_mask, order_base_2(page_count));
+		else
+			page = bp->b_pages[0] + i;
+#endif
 		if (unlikely(page == NULL)) {
 			if (flags & XBF_READ_AHEAD) {
 				bp->b_page_count = i;
@@ -425,8 +437,10 @@ xfs_buf_allocate_memory(
 	return 0;
 
 out_free_pages:
+#ifdef CONFIG_MMU
 	for (i = 0; i < bp->b_page_count; i++)
 		__free_page(bp->b_pages[i]);
+#endif
 	bp->b_flags &= ~_XBF_PAGES;
 	return error;
 }
@@ -446,6 +460,7 @@ _xfs_buf_map_pages(
 	} else if (flags & XBF_UNMAPPED) {
 		bp->b_addr = NULL;
 	} else {
+#ifdef CONFIG_MMU
 		int retried = 0;
 		unsigned nofs_flag;
 
@@ -466,6 +481,9 @@ _xfs_buf_map_pages(
 			vm_unmap_aliases();
 		} while (retried++ <= 1);
 		memalloc_nofs_restore(nofs_flag);
+#else
+		bp->b_addr = page_to_virt(bp->b_pages[0]);
+#endif
 
 		if (!bp->b_addr)
 			return -ENOMEM;
@@ -915,11 +933,19 @@ xfs_buf_get_uncached(
 	if (error)
 		goto fail_free_buf;
 
+#ifdef CONFIG_MMU
 	for (i = 0; i < page_count; i++) {
 		bp->b_pages[i] = alloc_page(xb_to_gfp(flags));
 		if (!bp->b_pages[i])
 			goto fail_free_mem;
 	}
+#else
+	bp->b_pages[0] = alloc_pages(flags, order_base_2(page_count));
+	if (!bp->b_pages[0])
+		goto fail_free_buf;
+	for (i = 1; i < page_count; i++)
+		bp->b_pages[i] = bp->b_pages[i-1] + 1;
+#endif
 	bp->b_flags |= _XBF_PAGES;
 
 	error = _xfs_buf_map_pages(bp, 0);
-- 
2.20.1 (Apple Git-117)


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

