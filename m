Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gMyai-0002Fm-58
 for linux-um@lists.infradead.org; Wed, 14 Nov 2018 17:04:38 +0000
Subject: Re: [PATCH 1/4] um: Switch to block-mq constants in the UML UBD driver
References: <20181113115947.19290-1-anton.ivanov@cambridgegreys.com>
 <20181113115947.19290-2-anton.ivanov@cambridgegreys.com>
 <20181114153237.GA28669@lst.de>
 <13420f0a-c4f7-d332-dc8d-fc498e737508@kernel.dk>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <23ff1534-9d7d-80dd-0c85-430d7a4df10c@cambridgegreys.com>
Date: Wed, 14 Nov 2018 17:04:20 +0000
MIME-Version: 1.0
In-Reply-To: <13420f0a-c4f7-d332-dc8d-fc498e737508@kernel.dk>
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
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc: richard@nod.at, linux-um@lists.infradead.org


On 11/14/18 5:00 PM, Jens Axboe wrote:
> On 11/14/18 8:32 AM, Christoph Hellwig wrote:
>>> +#define UBD_SECTOR_SIZE (1 << 9)
>> This can just use SECTOR_SIZE I guess.
>>
>>> +			if (!blk_update_request(io_req->req, io_req->error, io_req->length))
>>> +				__blk_mq_end_request(io_req->req, io_req->error);
>> The driver reall should be using blk_mq_end_request instead of playing
>> games with blk_update_request and __blk_mq_end_request.
> It's doing partial completions though, so it can't use blk_mq_end_request()
> directly. I guess it could sum it up and skip it in the loop, but honestly
> I think this is cleaner then.
Concur. I had a look at the other end/complete functions while chasing 
the root cause of the spurious hangs/aborts and I did not see anything 
else I can use. I may have missed something of course.
>
-- 
Anton R. Ivanov

Cambridge Greys Limited, England and Wales company No 10273661
http://www.cambridgegreys.com/


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

