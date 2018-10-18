Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gDFSo-0001hz-QL
 for linux-um@lists.infradead.org; Thu, 18 Oct 2018 21:04:16 +0000
From: Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH, RFC] ubd: remove use of blk_rq_map_sg
Date: Thu, 18 Oct 2018 23:04:01 +0200
Message-ID: <6586390.LjmFSvJ6cr@blindfold>
In-Reply-To: <20181017062150.GA22028@lst.de>
References: <20181015065637.1860-1-hch@lst.de>
 <da877cdc-7873-30fd-fa33-72cd48419d46@kernel.dk>
 <20181017062150.GA22028@lst.de>
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
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, linux-um@lists.infradead.org, dwalter@google.com, anton.ivanov@cambridgegreys.com

Am Mittwoch, 17. Oktober 2018, 08:21:51 CEST schrieb Christoph Hellwig:
> On Tue, Oct 16, 2018 at 08:26:31AM -0600, Jens Axboe wrote:
> > > Yes. Shall I send a patch with your suggestion or will you?
> > 
> > Christoph should just fold it in, the bug only exists after his
> > change to it.
> 
> Sorry, I missed what suggestion we had.  Is that the patch form Jens
> earlier?

Just send a v2 for you with all suggestions folded in. :)

> > 
> > > I have one more question, in your first conversion you set queue_depth to 2.
> > > How does one know this value?
> > > My conversion has 64, which is more or less an educated guess... ;)
> > 
> > 64 is most likely just fine. Some drivers rely on having 1 in flight and
> > it's easier to manage to just let blk-mq take care of that. Outside of that,
> > there aren't any magic values. We should probably just use BLKDEV_MAX_RQ
> > for ones that don't have a specific hw limit or need.
> 
> Is a queue depth > 1 actually safe for ubd?  There are some odd global
> variables tracking struct io_thread_req.

This means we can have up to tag_set.queue_depth concurrent ubd_queue_rq() calls?
The global variables should be safe since we use them only from our IO thread
and UML is UP anyways.

But we should double check, thanks for the hint.
Anton, can you please check?

Thanks,
//richard




_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

