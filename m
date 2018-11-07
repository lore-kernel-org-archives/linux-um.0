Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gKLLw-0004P0-Ly
 for linux-um@lists.infradead.org; Wed, 07 Nov 2018 10:46:29 +0000
Subject: Re: 4.20-rc1 looks broken for UML
References: <4a096c4f-6552-dbcb-676b-a87306dde07a@kot-begemot.co.uk>
 <e5c51b9c-97d5-ae12-b06f-303f0469d46b@kot-begemot.co.uk>
 <6298063.A9SzxUBULK@blindfold> <2177266.HJA9EnQ7lp@blindfold>
 <20181107075318.GA24381@lst.de>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <31d79c23-0fa0-956e-5477-0c326416fc45@kot-begemot.co.uk>
Date: Wed, 7 Nov 2018 10:46:05 +0000
MIME-Version: 1.0
In-Reply-To: <20181107075318.GA24381@lst.de>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Christoph Hellwig <hch@lst.de>, Richard Weinberger <richard@nod.at>
Cc: axboe@kernel.dk, linux-um@lists.infradead.org

On 11/7/18 7:53 AM, Christoph Hellwig wrote:

> On Tue, Nov 06, 2018 at 09:49:45PM +0100, Richard Weinberger wrote:
>> Christoph,
>>
>> Anton found a problem in your "ubd: remove use of blk_rq_map_sg" patch.
>> With CONFIG_DEBUG_PAGEALLOC enabled, the ubd driver crashes because it tries
>> to deref address 0x12345678, which is the poison from store_stackinfo().
>>
>> Please see below for more info.
>> Can it be that your change introduced a use-after-free bug in UML's block driver?
> Sounds like it.  But I'll need some more time to debug it.

I had to revert 4e6da0fe8058df9bfa937902fcd9cb2b7b89b2df "um: Convert 
ubd driver to blk-mq" as well to get things back to business as usual.

The block-mq driver works for reading - no issues if everything is ro. 
It also clearly works for writing for some configs in older kernels, 
otherwise it would have been picked up.

Something changed in 4.20-rc1 which made it fail in my config. The 
failure is instantaneous for 4.20-rc1 with only 
ecb0a83e3198f2c1142901687afacbc73602a13b " ubd: remove use of 
blk_rq_map_sg" reverted.

Reverting both and restoring the driver to 4.19 state fixes things.

I am going to give it a go to debug exactly what breaks for writing in 
ecb0a83e3198f2c1142901687afacbc73602a13b " ubd: remove use of 
blk_rq_map_sg".

A.


>
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

