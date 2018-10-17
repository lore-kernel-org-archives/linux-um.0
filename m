Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gCfEc-0006uH-Pm
 for linux-um@lists.infradead.org; Wed, 17 Oct 2018 06:23:11 +0000
Date: Wed, 17 Oct 2018 08:21:51 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH, RFC] ubd: remove use of blk_rq_map_sg
Message-ID: <20181017062150.GA22028@lst.de>
References: <20181015065637.1860-1-hch@lst.de> <2132215.oDDApMmxLa@blindfold>
 <4bd66e34-acc5-053f-888e-d4e58c3cf440@kernel.dk>
 <5155064.LnyfiXsD0j@blindfold>
 <da877cdc-7873-30fd-fa33-72cd48419d46@kernel.dk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <da877cdc-7873-30fd-fa33-72cd48419d46@kernel.dk>
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
To: Jens Axboe <axboe@kernel.dk>
Cc: Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org, linux-block@vger.kernel.org, dwalter@google.com, Christoph Hellwig <hch@lst.de>, anton.ivanov@cambridgegreys.com

On Tue, Oct 16, 2018 at 08:26:31AM -0600, Jens Axboe wrote:
> > Yes. Shall I send a patch with your suggestion or will you?
> 
> Christoph should just fold it in, the bug only exists after his
> change to it.

Sorry, I missed what suggestion we had.  Is that the patch form Jens
earlier?

> 
> > I have one more question, in your first conversion you set queue_depth to 2.
> > How does one know this value?
> > My conversion has 64, which is more or less an educated guess... ;)
> 
> 64 is most likely just fine. Some drivers rely on having 1 in flight and
> it's easier to manage to just let blk-mq take care of that. Outside of that,
> there aren't any magic values. We should probably just use BLKDEV_MAX_RQ
> for ones that don't have a specific hw limit or need.

Is a queue depth > 1 actually safe for ubd?  There are some odd global
variables tracking struct io_thread_req.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

