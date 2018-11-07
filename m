Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-it1-x133.google.com ([2607:f8b0:4864:20::133])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gKVBi-0000uP-5u
 for linux-um@lists.infradead.org; Wed, 07 Nov 2018 21:16:35 +0000
Received: by mail-it1-x133.google.com with SMTP id r12-v6so22268913ita.3
 for <linux-um@lists.infradead.org>; Wed, 07 Nov 2018 13:16:23 -0800 (PST)
Subject: Re: Summary so far - ubd breakage in 4.20-rc1
References: <94397e9b-36a6-92b0-b074-ce3640cee00e@kot-begemot.co.uk>
 <1553895.q7DRUMsJH8@blindfold>
 <90605158-e1c8-f414-1635-72e185ca861e@kernel.dk>
 <2067083.opUWeOxqyK@blindfold>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <fe020526-ac24-0279-ca27-7ccabba7a6cc@kernel.dk>
Date: Wed, 7 Nov 2018 14:16:20 -0700
MIME-Version: 1.0
In-Reply-To: <2067083.opUWeOxqyK@blindfold>
Content-Language: en-US
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
Cc: linux-um@lists.infradead.org, Anton Ivanov <anton.ivanov@kot-begemot.co.uk>, hch@lst.de

On 11/7/18 2:15 PM, Richard Weinberger wrote:
> Jens,
> 
> Am Mittwoch, 7. November 2018, 20:19:42 CET schrieb Jens Axboe:
>> My guess would be that the issue of requests is no longer blocking
>> interrupts, that looks like an oversight. So you could have your
>> IRQ handler race with writing new requests, which would be a problem...
> 
> sounds reasonable.
> 
>> Does the below help things?
>>
> 
> It does!
> Anton, please give it also a try.

OK good, it's definitely a bug, and given the symptoms, sounds like
THE bug in this case.

>> diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
>> index 74c002ddc0ce..019bc4828e30 100644
>> --- a/arch/um/drivers/ubd_kern.c
>> +++ b/arch/um/drivers/ubd_kern.c
>> @@ -1341,11 +1341,14 @@ static int ubd_queue_one_vec(struct blk_mq_hw_ctx *hctx, struct request *req,
>>  static blk_status_t ubd_queue_rq(struct blk_mq_hw_ctx *hctx,
>>  				 const struct blk_mq_queue_data *bd)
>>  {
>> +	struct ubd *ubd_dev = hctx->queue->queuedata;
>>  	struct request *req = bd->rq;
>>  	int ret = 0;
>>  
>>  	blk_mq_start_request(req);
>>  
>> +	spin_lock_irq(&ubd_dev->lock);
>> +
> 
> BTW: Why not irq_save/restore?

You only need the save/restore versions if you're called with
interrupts already disabled (or may be), that's not the case
here. Hence we can use the faster versions.

-- 
Jens Axboe


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

