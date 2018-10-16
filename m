Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gCExq-0000vc-0r
 for linux-um@lists.infradead.org; Tue, 16 Oct 2018 02:20:07 +0000
Received: by mail-pl1-x634.google.com with SMTP id v5-v6so10189008plz.13
 for <linux-um@lists.infradead.org>; Mon, 15 Oct 2018 19:19:55 -0700 (PDT)
Subject: Re: [PATCH, RFC] ubd: remove use of blk_rq_map_sg
References: <20181015065637.1860-1-hch@lst.de> <48119384.A7YGth2QHM@blindfold>
 <a33c7dfb-3eb6-3955-0336-257b8fcbfbe7@kernel.dk>
 <2132215.oDDApMmxLa@blindfold>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <4bd66e34-acc5-053f-888e-d4e58c3cf440@kernel.dk>
Date: Mon, 15 Oct 2018 20:19:51 -0600
MIME-Version: 1.0
In-Reply-To: <2132215.oDDApMmxLa@blindfold>
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
Cc: linux-block@vger.kernel.org, dwalter@google.com, linux-um@lists.infradead.org, Christoph Hellwig <hch@lst.de>, anton.ivanov@cambridgegreys.com

On 10/15/18 4:44 PM, Richard Weinberger wrote:
> Am Dienstag, 16. Oktober 2018, 00:04:20 CEST schrieb Jens Axboe:
>> On 10/15/18 3:46 PM, Richard Weinberger wrote:
>>> Am Montag, 15. Oktober 2018, 22:55:29 CEST schrieb Christoph Hellwig:
>>>> On Mon, Oct 15, 2018 at 10:42:47PM +0200, Richard Weinberger wrote:
>>>>>> Sadly not. I'm checking now what exactly is broken.
>>>>>
>>>>> I take this back. Christoph's fixup makes reading work.
>>>>> The previous version corrupted my test block device in interesting ways
>>>>> and confused all tests.
>>>>> But the removal of blk_rq_map_sg() still has issues.
>>>>> Now the device blocks endless upon flush.
>>>>
>>>> I suspect we still need to special case flush.  Updated patch below
>>>> including your other suggestion:
>>>
>>> While playing further with the patch I managed to hit
>>> BUG_ON(blk_queued_rq(rq)) in blk_mq_requeue_request().
>>>
>>> UML requeues the request in ubd_queue_one_vec() if it was not able
>>> to submit the request to the host io-thread.
>>> The fd can return -EAGAIN, then UML has to try later.
>>>
>>> Isn't this allowed in that context?
>>
>> It is, the problem is that queue_one_vec() doesn't always return an
>> error. The caller is doing a loop per bio, so we can encounter an
>> error, requeue, and then the caller will call us again. We're in
>> an illegal state at that point, and the next requeue will make that
>> obvious since it's already pending. Actually, both the caller and
>> ubd_queue_one_vec() also requeue. So it's a bit of a mess, the below
>> might help.
> 
> I agree, the driver *is* a mess.
> Unless someone else volunteers to clean it up, I'll push that task on
> my never ending TODO list.

I doubt you'll have to fight anyone for that task ;-)

> Thanks for your hint with the illegal state.
> Now with correct requeuing the driver seems to work fine!
> Write/Flush support also suffered from that but didn't trigger the BUG_ON()...

OK good, at least we're making progress!

-- 
Jens Axboe


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

