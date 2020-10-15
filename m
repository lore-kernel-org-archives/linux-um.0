Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Thu, 15 Oct 2020 20:03:12 +0100
From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 16/16] iomap: Make readpage synchronous
Message-ID: <20201015190312.GB20115@casper.infradead.org>
References: <20201009143104.22673-1-willy@infradead.org>
 <20201009143104.22673-17-willy@infradead.org>
 <20201015094203.GA21420@infradead.org>
 <20201015164333.GA20115@casper.infradead.org>
 <20201015175848.GA4145@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201015175848.GA4145@infradead.org>
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

On Thu, Oct 15, 2020 at 06:58:48PM +0100, Christoph Hellwig wrote:
> On Thu, Oct 15, 2020 at 05:43:33PM +0100, Matthew Wilcox wrote:
> > I prefer assigning ctx conditionally to propagating the knowledge
> > that !rac means synchronous.  I've gone with this:
> 
> And I really hate these kinds of conditional assignments.  If the
> ->rac check is too raw please just add an explicit
> 
> 	bool synchronous : 1;
> 
> flag.

I honestly don't see the problem.  We have to assign the status
conditionally anyway so we don't overwrite an error with a subsequent
success.

> True.  I'd still prefer the AOP_UPDATED_PAGE as the fallthrough case
> and an explicit goto out_unlock, though.

So this?

        if (ctx.bio) {
                submit_bio(ctx.bio);
                wait_for_completion(&ctx.done);
                if (ret < 0)
                        goto err;
                ret = blk_status_to_errno(ctx.status);
        }

        if (ret < 0)
                goto err;
        return AOP_UPDATED_PAGE;
err:
        unlock_page(page);
        return ret;


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

