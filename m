Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gKkRO-0001ZC-9z
 for linux-um@lists.infradead.org; Thu, 08 Nov 2018 13:33:47 +0000
Subject: Re: [PATCH] Fix breakage from switching to MQ BLK framework
References: <20181108130723.12101-1-anton.ivanov@cambridgegreys.com>
 <60f9ff8e-d8e1-a0e6-5974-c2c4c49e27dc@kernel.dk>
 <e416f068-9cf5-3e42-560f-873515092c02@cambridgegreys.com>
 <5eec2bc9-083f-8b1b-2dd9-9ab7ea87c85b@kernel.dk>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <5e309551-5fa7-7baf-baaf-f6d991b77ce3@cambridgegreys.com>
Date: Thu, 8 Nov 2018 13:33:32 +0000
MIME-Version: 1.0
In-Reply-To: <5eec2bc9-083f-8b1b-2dd9-9ab7ea87c85b@kernel.dk>
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
To: Jens Axboe <axboe@kernel.dk>, linux-um@lists.infradead.org
Cc: richard@nod.at, hch@lst.de


On 11/8/18 1:24 PM, Jens Axboe wrote:
> On 11/8/18 6:22 AM, Anton Ivanov wrote:
>> On 11/8/18 1:10 PM, Jens Axboe wrote:
>>> On 11/8/18 6:07 AM, anton.ivanov@cambridgegreys.com wrote:
>>>> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>>>>
>>>> Initial version by Jens Axboe <axboe@kernel.dk>
>>>>
>>>> 1. Fix use of use unititalized req->error for SYNC commands
>>>> 2. Guard the request submission by a spinlock
>>>>
>>>> Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>>>> ---
>>>>    arch/um/drivers/ubd_kern.c | 9 +++++++--
>>>>    1 file changed, 7 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
>>>> index 74c002ddc0ce..e3d587d9eff6 100644
>>>> --- a/arch/um/drivers/ubd_kern.c
>>>> +++ b/arch/um/drivers/ubd_kern.c
>>>> @@ -1305,6 +1305,7 @@ static int ubd_queue_one_vec(struct blk_mq_hw_ctx *hctx, struct request *req,
>>>>    		io_req->fds[0] = dev->cow.fd;
>>>>    	else
>>>>    		io_req->fds[0] = dev->fd;
>>>> +	io_req->error = 0;
>>>>    
>>>>    	if (req_op(req) == REQ_OP_FLUSH) {
>>>>    		io_req->op = UBD_FLUSH;
>>>> @@ -1313,9 +1314,7 @@ static int ubd_queue_one_vec(struct blk_mq_hw_ctx *hctx, struct request *req,
>>>>    		io_req->cow_offset = -1;
>>>>    		io_req->offset = off;
>>>>    		io_req->length = bvec->bv_len;
>>>> -		io_req->error = 0;
>>>>    		io_req->sector_mask = 0;
>>>> -
>>>>    		io_req->op = rq_data_dir(req) == READ ? UBD_READ : UBD_WRITE;
>>>>    		io_req->offsets[0] = 0;
>>>>    		io_req->offsets[1] = dev->cow.data_offset;
>>> These two hunks look fine.
>>>
>>>> @@ -1341,11 +1340,15 @@ static int ubd_queue_one_vec(struct blk_mq_hw_ctx *hctx, struct request *req,
>>>>    static blk_status_t ubd_queue_rq(struct blk_mq_hw_ctx *hctx,
>>>>    				 const struct blk_mq_queue_data *bd)
>>>>    {
>>>> +	struct ubd *ubd_dev = hctx->queue->queuedata;
>>>>    	struct request *req = bd->rq;
>>>> +	unsigned long flags;
>>>>    	int ret = 0;
>>>>    
>>>>    	blk_mq_start_request(req);
>>>>    
>>>> +	spin_lock_irqsave(&ubd_dev->lock, flags);
>>>> +
>>>>    	if (req_op(req) == REQ_OP_FLUSH) {
>>>>    		ret = ubd_queue_one_vec(hctx, req, 0, NULL);
>>>>    	} else {
>>>> @@ -1361,6 +1364,8 @@ static blk_status_t ubd_queue_rq(struct blk_mq_hw_ctx *hctx,
>>>>    		}
>>>>    	}
>>>>    out:
>>>> +	spin_unlock_irqrestore(&ubd_dev->lock, flags);
>>>> +
>>>>    	if (ret < 0) {
>>>>    		blk_mq_requeue_request(req, true);
>>>>    	}
>>> This one doesn't need to be save/restore. I've already queued up
>>> the locking fix yesterday, I'll add your initialization fix.
>> Apologies, I got a hang when testing it with just _irq, but I did not
>> rerun the test. I suspect it was on something completely unrelated as I
>> cannot reproduce it any more.
>>
>> That is why I switched it to irqsave, which as you explained is
>> unnecessary.
> No problem, I committed a cut down version and fixed up your
> commit message as well:
>
> http://git.kernel.dk/cgit/linux-block/commit/?h=for-linus&id=0033dfd92a5646a78025e86f8df4d5b18181ba2c
>

Thanks,

The speed difference between irq and irqsave is quite substantial - I 
get 255MB/s vs 312MB/s on dd-ing a 16G image to /dev/null

I should probably look around the rest of UML as it uses _irqsave nearly 
everywhere and some of those may be converted to _irq.

-- 
Anton R. Ivanov

Cambridge Greys Limited, England and Wales company No 10273661
http://www.cambridgegreys.com/


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

