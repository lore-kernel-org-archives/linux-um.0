Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Thu, 15 Oct 2020 17:43:33 +0100
From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 16/16] iomap: Make readpage synchronous
Message-ID: <20201015164333.GA20115@casper.infradead.org>
References: <20201009143104.22673-1-willy@infradead.org>
 <20201009143104.22673-17-willy@infradead.org>
 <20201015094203.GA21420@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201015094203.GA21420@infradead.org>
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
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-cifs@vger.kernel.org, Richard Weinberger <richard@nod.at>, ecryptfs@vger.kernel.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-mm@kvack.org, linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, ceph-devel@vger.kernel.org, linux-afs@lists.infradead.org

On Thu, Oct 15, 2020 at 10:42:03AM +0100, Christoph Hellwig wrote:
> > +static void iomap_read_page_end_io(struct bio_vec *bvec,
> > +		struct completion *done, bool error)
> 
> I really don't like the parameters here.  Part of the problem is
> that ctx is only assigned to bi_private conditionally, which can
> easily be fixed.  The other part is the strange bool error when
> we can just pass on bi_stats.  See the patch at the end of what
> I'd do intead.

I prefer assigning ctx conditionally to propagating the knowledge
that !rac means synchronous.  I've gone with this:

 static void iomap_read_page_end_io(struct bio_vec *bvec,
-               struct completion *done, bool error)
+               struct iomap_readpage_ctx *ctx, blk_status_t status)
 {
        struct page *page = bvec->bv_page;
        struct iomap_page *iop = to_iomap_page(page);
 
-       if (!error)
+       if (status == BLK_STS_OK) {
                iomap_set_range_uptodate(page, bvec->bv_offset, bvec->bv_len);
+       } else if (ctx && ctx->status == BLK_STS_OK) {
+               ctx->status = status;
+       }
 
        if (!iop ||
            atomic_sub_and_test(bvec->bv_len, &iop->read_bytes_pending)) {
-               if (done)
-                       complete(done);
+               if (ctx)
+                       complete(&ctx->done);
                else
                        unlock_page(page);
        }

> >  	} else {
> >  		WARN_ON_ONCE(ctx.cur_page_in_bio);
> > -		unlock_page(page);
> > +		complete(&ctx.done);
> >  	}
> >  
> > +	wait_for_completion(&ctx.done);
> 
> I don't think we need the complete / wait_for_completion dance in
> this case.
> 
> > +	if (ret >= 0)
> > +		ret = blk_status_to_errno(ctx.status);
> > +	if (ret == 0)
> > +		return AOP_UPDATED_PAGE;
> > +	unlock_page(page);
> > +	return ret;
> 
> Nipick, but I'd rather have a goto out_unlock for both error case
> and have the AOP_UPDATED_PAGE for the normal path straight in line.
> 
> Here is an untested patch with my suggestions:

I think we can go a little further here:

@@ -340,16 +335,12 @@ iomap_readpage(struct page *page, const struct iomap_ops *
ops)
 
        if (ctx.bio) {
                submit_bio(ctx.bio);
-               WARN_ON_ONCE(!ctx.cur_page_in_bio);
-       } else {
-               WARN_ON_ONCE(ctx.cur_page_in_bio);
-               complete(&ctx.done);
+               wait_for_completion(&ctx.done);
+               if (ret > 0)
+                       ret = blk_status_to_errno(ctx.status);
        }
 
-       wait_for_completion(&ctx.done);
        if (ret >= 0)
-               ret = blk_status_to_errno(ctx.status);
-       if (ret == 0)
                return AOP_UPDATED_PAGE;
        unlock_page(page);
        return ret;


... there's no need to call blk_status_to_errno if we never submitted a bio.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

