Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Thu, 15 Oct 2020 10:42:03 +0100
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 16/16] iomap: Make readpage synchronous
Message-ID: <20201015094203.GA21420@infradead.org>
References: <20201009143104.22673-1-willy@infradead.org>
 <20201009143104.22673-17-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201009143104.22673-17-willy@infradead.org>
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
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-cifs@vger.kernel.org, Richard Weinberger <richard@nod.at>, ecryptfs@vger.kernel.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-mm@kvack.org, linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, ceph-devel@vger.kernel.org, linux-afs@lists.infradead.org

> +static void iomap_read_page_end_io(struct bio_vec *bvec,
> +		struct completion *done, bool error)

I really don't like the parameters here.  Part of the problem is
that ctx is only assigned to bi_private conditionally, which can
easily be fixed.  The other part is the strange bool error when
we can just pass on bi_stats.  See the patch at the end of what
I'd do intead.

> @@ -318,15 +325,17 @@ iomap_readpage(struct page *page, const struct iomap_ops *ops)
>  
>  	trace_iomap_readpage(page->mapping->host, 1);
>  
> +	ctx.status = BLK_STS_OK;

This should move into the initializer for ctx.  Or we could just drop
it given that BLK_STS_OK is and must always be 0.

>  	} else {
>  		WARN_ON_ONCE(ctx.cur_page_in_bio);
> -		unlock_page(page);
> +		complete(&ctx.done);
>  	}
>  
> +	wait_for_completion(&ctx.done);

I don't think we need the complete / wait_for_completion dance in
this case.

> +	if (ret >= 0)
> +		ret = blk_status_to_errno(ctx.status);
> +	if (ret == 0)
> +		return AOP_UPDATED_PAGE;
> +	unlock_page(page);
> +	return ret;

Nipick, but I'd rather have a goto out_unlock for both error case
and have the AOP_UPDATED_PAGE for the normal path straight in line.

Here is an untested patch with my suggestions:


diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 887bf871ca9bba..81d34725565d7e 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -162,33 +162,34 @@ static void iomap_set_range_uptodate(struct page *page, unsigned off,
 	spin_unlock_irqrestore(&iop->uptodate_lock, flags);
 }
 
-static void iomap_read_page_end_io(struct bio_vec *bvec,
-		struct completion *done, bool error)
+struct iomap_readpage_ctx {
+	struct page		*cur_page;
+	bool			cur_page_in_bio;
+	blk_status_t		status;
+	struct bio		*bio;
+	struct readahead_control *rac;
+	struct completion	done;
+};
+
+static void
+iomap_read_page_end_io(struct iomap_readpage_ctx *ctx, struct bio_vec *bvec,
+		blk_status_t status)
 {
 	struct page *page = bvec->bv_page;
 	struct iomap_page *iop = to_iomap_page(page);
 
-	if (!error)
+	if (status == BLK_STS_OK)
 		iomap_set_range_uptodate(page, bvec->bv_offset, bvec->bv_len);
 
 	if (!iop ||
 	    atomic_sub_and_test(bvec->bv_len, &iop->read_bytes_pending)) {
-		if (done)
-			complete(done);
-		else
+		if (ctx->rac)
 			unlock_page(page);
+		else
+			complete(&ctx->done);
 	}
 }
 
-struct iomap_readpage_ctx {
-	struct page		*cur_page;
-	bool			cur_page_in_bio;
-	blk_status_t		status;
-	struct bio		*bio;
-	struct readahead_control *rac;
-	struct completion	done;
-};
-
 static void
 iomap_read_end_io(struct bio *bio)
 {
@@ -197,12 +198,11 @@ iomap_read_end_io(struct bio *bio)
 	struct bvec_iter_all iter_all;
 
 	/* Capture the first error */
-	if (ctx && ctx->status == BLK_STS_OK)
+	if (ctx->status == BLK_STS_OK)
 		ctx->status = bio->bi_status;
 
 	bio_for_each_segment_all(bvec, bio, iter_all)
-		iomap_read_page_end_io(bvec, ctx ? &ctx->done : NULL,
-				bio->bi_status != BLK_STS_OK);
+		iomap_read_page_end_io(ctx, bvec, bio->bi_status);
 	bio_put(bio);
 }
 
@@ -297,8 +297,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		ctx->bio->bi_opf = REQ_OP_READ;
 		if (ctx->rac)
 			ctx->bio->bi_opf |= REQ_RAHEAD;
-		else
-			ctx->bio->bi_private = ctx;
+		ctx->bio->bi_private = ctx;
 		ctx->bio->bi_iter.bi_sector = sector;
 		bio_set_dev(ctx->bio, iomap->bdev);
 		ctx->bio->bi_end_io = iomap_read_end_io;
@@ -318,14 +317,16 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 int
 iomap_readpage(struct page *page, const struct iomap_ops *ops)
 {
-	struct iomap_readpage_ctx ctx = { .cur_page = page };
+	struct iomap_readpage_ctx ctx = {
+		.cur_page	= page,
+		.status		= BLK_STS_OK,
+	};
 	struct inode *inode = page->mapping->host;
 	unsigned poff;
 	loff_t ret;
 
 	trace_iomap_readpage(page->mapping->host, 1);
 
-	ctx.status = BLK_STS_OK;
 	init_completion(&ctx.done);
 
 	for (poff = 0; poff < PAGE_SIZE; poff += ret) {
@@ -340,17 +341,16 @@ iomap_readpage(struct page *page, const struct iomap_ops *ops)
 
 	if (ctx.bio) {
 		submit_bio(ctx.bio);
-		WARN_ON_ONCE(!ctx.cur_page_in_bio);
-	} else {
-		WARN_ON_ONCE(ctx.cur_page_in_bio);
-		complete(&ctx.done);
+		wait_for_completion(&ctx.done);
 	}
 
-	wait_for_completion(&ctx.done);
-	if (ret >= 0)
-		ret = blk_status_to_errno(ctx.status);
-	if (ret == 0)
-		return AOP_UPDATED_PAGE;
+	if (ret < 0)
+		goto out_unlock;
+	ret = blk_status_to_errno(ctx.status);
+	if (ret < 0)
+		goto out_unlock;
+	return AOP_UPDATED_PAGE;
+out_unlock:
 	unlock_page(page);
 	return ret;
 }

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

