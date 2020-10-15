Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Thu, 15 Oct 2020 18:58:48 +0100
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 16/16] iomap: Make readpage synchronous
Message-ID: <20201015175848.GA4145@infradead.org>
References: <20201009143104.22673-1-willy@infradead.org>
 <20201009143104.22673-17-willy@infradead.org>
 <20201015094203.GA21420@infradead.org>
 <20201015164333.GA20115@casper.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201015164333.GA20115@casper.infradead.org>
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
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-cifs@vger.kernel.org, Richard Weinberger <richard@nod.at>, ecryptfs@vger.kernel.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org, linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, ceph-devel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-afs@lists.infradead.org

On Thu, Oct 15, 2020 at 05:43:33PM +0100, Matthew Wilcox wrote:
> On Thu, Oct 15, 2020 at 10:42:03AM +0100, Christoph Hellwig wrote:
> > > +static void iomap_read_page_end_io(struct bio_vec *bvec,
> > > +		struct completion *done, bool error)
> > 
> > I really don't like the parameters here.  Part of the problem is
> > that ctx is only assigned to bi_private conditionally, which can
> > easily be fixed.  The other part is the strange bool error when
> > we can just pass on bi_stats.  See the patch at the end of what
> > I'd do intead.
> 
> I prefer assigning ctx conditionally to propagating the knowledge
> that !rac means synchronous.  I've gone with this:

And I really hate these kinds of conditional assignments.  If the
->rac check is too raw please just add an explicit

	bool synchronous : 1;

flag.

> @@ -340,16 +335,12 @@ iomap_readpage(struct page *page, const struct iomap_ops *
> ops)
>  
>         if (ctx.bio) {
>                 submit_bio(ctx.bio);
> +               if (ret > 0)
> +                       ret = blk_status_to_errno(ctx.status);
>         }
>  
> -       wait_for_completion(&ctx.done);
>         if (ret >= 0)
> -               ret = blk_status_to_errno(ctx.status);
> -       if (ret == 0)
>                 return AOP_UPDATED_PAGE;
>         unlock_page(page);
>         return ret;
> 
> 
> ... there's no need to call blk_status_to_errno if we never submitted a bio.

True.  I'd still prefer the AOP_UPDATED_PAGE as the fallthrough case
and an explicit goto out_unlock, though.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

