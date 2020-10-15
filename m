Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Thu, 15 Oct 2020 12:49:49 +0100
From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 00/16] Allow readpage to return a locked page
Message-ID: <20201015114949.GY20115@casper.infradead.org>
References: <20201009143104.22673-1-willy@infradead.org>
 <20201015090242.GA12879@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201015090242.GA12879@infradead.org>
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

On Thu, Oct 15, 2020 at 10:02:42AM +0100, Christoph Hellwig wrote:
> On Fri, Oct 09, 2020 at 03:30:48PM +0100, Matthew Wilcox (Oracle) wrote:
> > Ideally all filesystems would return from ->readpage with the page
> > Uptodate and Locked, but it's a bit painful to convert all the
> > asynchronous readpage implementations to synchronous.  The first 14
> > filesystems converted are already synchronous.  The last two patches
> > convert iomap to synchronous readpage.
> 
> Is it really that bad?  It seems like a lot of the remainig file systems
> use the generic mpage/buffer/nobh helpers.
> 
> But I guess this series is a good first step.

I'm just testing a patch to mpage_readpage():

+++ b/fs/mpage.c
@@ -406,11 +406,17 @@ int mpage_readpage(struct page *page, get_block_t get_block)
                .nr_pages = 1,
                .get_block = get_block,
        };
+       int err;
 
        args.bio = do_mpage_readpage(&args);
-       if (args.bio)
-               mpage_bio_submit(REQ_OP_READ, 0, args.bio);
-       return 0;
+       if (!args.bio)
+               return 0;
+       bio_set_op_attrs(args.bio, REQ_OP_READ, 0);
+       guard_bio_eod(args.bio);
+       err = submit_bio_wait(args.bio);
+       if (!err)
+               err = AOP_UPDATED_PAGE;
+       return err;
 }
 EXPORT_SYMBOL(mpage_readpage);
 

but I'm not looking forward to block_read_full_page().

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

