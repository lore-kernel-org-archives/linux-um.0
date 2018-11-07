Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gKIea-0006L4-GT
 for linux-um@lists.infradead.org; Wed, 07 Nov 2018 07:53:33 +0000
Date: Wed, 7 Nov 2018 08:53:18 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: 4.20-rc1 looks broken for UML
Message-ID: <20181107075318.GA24381@lst.de>
References: <4a096c4f-6552-dbcb-676b-a87306dde07a@kot-begemot.co.uk>
 <e5c51b9c-97d5-ae12-b06f-303f0469d46b@kot-begemot.co.uk>
 <6298063.A9SzxUBULK@blindfold> <2177266.HJA9EnQ7lp@blindfold>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2177266.HJA9EnQ7lp@blindfold>
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
To: Richard Weinberger <richard@nod.at>
Cc: axboe@kernel.dk, linux-um@lists.infradead.org, hch@lst.de, Anton Ivanov <anton.ivanov@kot-begemot.co.uk>

On Tue, Nov 06, 2018 at 09:49:45PM +0100, Richard Weinberger wrote:
> Christoph,
> 
> Anton found a problem in your "ubd: remove use of blk_rq_map_sg" patch.
> With CONFIG_DEBUG_PAGEALLOC enabled, the ubd driver crashes because it tries
> to deref address 0x12345678, which is the poison from store_stackinfo().
> 
> Please see below for more info.

> Can it be that your change introduced a use-after-free bug in UML's block driver?

Sounds like it.  But I'll need some more time to debug it.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

