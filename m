Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gCAgu-0003Xp-UG
 for linux-um@lists.infradead.org; Mon, 15 Oct 2018 21:46:22 +0000
From: Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH, RFC] ubd: remove use of blk_rq_map_sg
Date: Mon, 15 Oct 2018 23:46:04 +0200
Message-ID: <48119384.A7YGth2QHM@blindfold>
In-Reply-To: <20181015205529.GA11086@lst.de>
References: <20181015065637.1860-1-hch@lst.de> <1771273.Wvapsmo5cm@blindfold>
 <20181015205529.GA11086@lst.de>
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
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-um@lists.infradead.org, dwalter@google.com, anton.ivanov@cambridgegreys.com

Am Montag, 15. Oktober 2018, 22:55:29 CEST schrieb Christoph Hellwig:
> On Mon, Oct 15, 2018 at 10:42:47PM +0200, Richard Weinberger wrote:
> > > Sadly not. I'm checking now what exactly is broken.
> > 
> > I take this back. Christoph's fixup makes reading work.
> > The previous version corrupted my test block device in interesting ways
> > and confused all tests.
> > But the removal of blk_rq_map_sg() still has issues.
> > Now the device blocks endless upon flush.
> 
> I suspect we still need to special case flush.  Updated patch below
> including your other suggestion:

While playing further with the patch I managed to hit
BUG_ON(blk_queued_rq(rq)) in blk_mq_requeue_request().

UML requeues the request in ubd_queue_one_vec() if it was not able
to submit the request to the host io-thread.
The fd can return -EAGAIN, then UML has to try later.

Isn't this allowed in that context?

drivers/block/xen-blkfront.c seem to faced the same problem, since
it does a list_del_init(&req->queuelist) right before calling
blk_mq_requeue_request() o_O.

Thanks,
//richard





_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

