Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gKTMr-0000s4-67
 for linux-um@lists.infradead.org; Wed, 07 Nov 2018 19:19:58 +0000
Received: by mail-it1-x143.google.com with SMTP id v11so18268422itj.0
 for <linux-um@lists.infradead.org>; Wed, 07 Nov 2018 11:19:45 -0800 (PST)
Subject: Re: Summary so far - ubd breakage in 4.20-rc1
References: <94397e9b-36a6-92b0-b074-ce3640cee00e@kot-begemot.co.uk>
 <1553895.q7DRUMsJH8@blindfold>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <90605158-e1c8-f414-1635-72e185ca861e@kernel.dk>
Date: Wed, 7 Nov 2018 12:19:42 -0700
MIME-Version: 1.0
In-Reply-To: <1553895.q7DRUMsJH8@blindfold>
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
To: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Cc: linux-um@lists.infradead.org, hch@lst.de

On 11/7/18 11:53 AM, Richard Weinberger wrote:
> [CC'ing hch and jens again.]
> 
> Am Mittwoch, 7. November 2018, 19:40:13 CET schrieb Anton Ivanov:
>> Hi list, hi Richard.
>>
>> I spent some time digging into the 4.20-rc1 issue today, and unless I am 
>> missing something it looks like UBD breakage and it looks like memory 
>> corruption. I cannot pin down where it is coming from.
>>
>> These are my finding so far:
>>
>> 1. It happens only for write requests - I have not picked up a case 
>> where a read req breaks in any way so far. UML boots fine until it tries 
>> to remount the root fs read only and then fails with an IO error.
>>
>> 2. In my config it looks like it is introduced by the "um: Convert ubd 
>> driver to blk-mq" commit. It appears in 4.19 if I cherry-pick it and 
>> disappears in 4.20-rc1 if I revert it.
>>
>> 3. The write req is correctly passed as far as the actual io handler and 
>> correctly processed by the io thread. Upon finishing the request in the 
>> io thread the value of req->error is 0 and all values look OK.
>>
>> 4. The moment the req is read back by the irq handler req->error is 
>> something which looks like data from elsewhere instead of the request. 
>> F.e error may contain 55AA55AA
>>
>> 5. Other bits of the req are also zapped in a similar manner.
>>
>> 6. The pointer to the req passed along the IPC pipe is correct. If a req 
>> at 00000000deafe300 is given for execution to the IO thread, that is 
>> what is in the io_req variable in the handler. It is just contents of 
>> that req by that time are scrambled.
>>
>> 7.  I see it only for write reqs.
>>
>> I just do not see where it can be zapped. At all. I did a prototype to 
>> add the BLK_STS_AGAIN return code and continue from half-x-mitted req 
>> logic similar to the one in nbd driver. It is not that. There is 
>> something else which causes this and I just do not see it :(

My guess would be that the issue of requests is no longer blocking
interrupts, that looks like an oversight. So you could have your
IRQ handler race with writing new requests, which would be a problem...

Does the below help things?


diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 74c002ddc0ce..019bc4828e30 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -1341,11 +1341,14 @@ static int ubd_queue_one_vec(struct blk_mq_hw_ctx *hctx, struct request *req,
 static blk_status_t ubd_queue_rq(struct blk_mq_hw_ctx *hctx,
 				 const struct blk_mq_queue_data *bd)
 {
+	struct ubd *ubd_dev = hctx->queue->queuedata;
 	struct request *req = bd->rq;
 	int ret = 0;
 
 	blk_mq_start_request(req);
 
+	spin_lock_irq(&ubd_dev->lock);
+
 	if (req_op(req) == REQ_OP_FLUSH) {
 		ret = ubd_queue_one_vec(hctx, req, 0, NULL);
 	} else {
@@ -1361,6 +1364,8 @@ static blk_status_t ubd_queue_rq(struct blk_mq_hw_ctx *hctx,
 		}
 	}
 out:
+	spin_unlock_irq(&ubd_dev->lock);
+
 	if (ret < 0) {
 		blk_mq_requeue_request(req, true);
 	}

-- 
Jens Axboe


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

