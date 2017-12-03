Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] [RFC] um: Convert ubd driver to blk-mq
References: <20171126131053.32300-1-richard@nod.at>
 <20171129214651.GA5846@lst.de> <2026565.M1KEqJdkSY@blindfold>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <e4283e17-3feb-25bb-e132-6460730c8e0e@cambridgegreys.com>
Date: Sun, 3 Dec 2017 22:23:25 +0000
MIME-Version: 1.0
In-Reply-To: <2026565.M1KEqJdkSY@blindfold>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>, Christoph Hellwig <hch@lst.de>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, axboe@fb.com, linux-block@vger.kernel.org, david@sigma-star.at
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 03/12/17 21:54, Richard Weinberger wrote:
> Christoph,
>
> Am Mittwoch, 29. November 2017, 22:46:51 CET schrieb Christoph Hellwig:
>> On Sun, Nov 26, 2017 at 02:10:53PM +0100, Richard Weinberger wrote:
>>> MAX_SG is 64, used for blk_queue_max_segments(). This comes from
>>> a0044bdf60c2 ("uml: batch I/O requests"). Is this still a good/sane
>>> value for blk-mq?
>> blk-mq itself doesn't change the tradeoff.
>>
>>> The driver does IO batching, for each request it issues many UML struct
>>> io_thread_req request to the IO thread on the host side.
>>> One io_thread_req per SG page.
>>> Before the conversion the driver used blk_end_request() to indicate that
>>> a part of the request is done.
>>> blk_mq_end_request() does not take a length parameter, therefore we can
>>> only mark the whole request as done. See the new is_last property on the
>>> driver.
>>> Maybe there is a way to partially end requests too in blk-mq?
>> You can, take a look at scsi_end_request which handles this for blk-mq
>> and the legacy layer.  That being said I wonder if batching really
>> makes that much sene if you execute each segment separately?
> Anton did a lot of performance improvements in this area.
> He has all the details.
> AFAIK batching brings us more throughput because in UML all IO is done by
> a different thread and the IPC has a certain overhead. 

The current UML disk IO is executed in a different thread using a pipe
as an IPC.

What batching helps with is the number of context switches and numbers
of syscalls per IO operation.

The non-batching code used 6 syscalls per disk io operation: UML write
to IPC, disk thread read from IPC, actual disk IO, disk thread write to
IPC, (e)poll in UML IRQ controller emulation, UML read from IPC.

With batching this is reduced to 5 calls per batch + number of IO ops
batched. Under load the batches grow to usually 10-30 in size which
yields a syscall reduction of 3-5 times. My code sets the batch size
limit to 64 and you can hit that on some synthetic benchmarks like
dd-ing raw disks.

There is further gains from latency reduction. The "round-trip" over the
IPC to tell the disk io thread to perform an IO operation and to confirm
the results is also reduced if you manage to pass multiple events in one go.

All in all, the difference between batched and non-batched for heavy IO
load is several times for the old blk code in UML. I need to do some
reading to get a better understanding of the new code and if needs
batching and how to match it to the actual blk-mq semantics.

A.

>
>>> Another obstacle with IO batching is that UML IO thread requests can
>>> fail. Not only due to OOM, also because the pipe between the UML kernel
>>> process and the host IO thread can return EAGAIN.
>>> In this case the driver puts the request into a list and retried later
>>> again when the pipe turns writable.
>>> I’m not sure whether this restart logic makes sense with blk-mq, maybe
>>> there is a way in blk-mq to put back a (partial) request?
>> blk_mq_requeue_request requeues requests that have been partially
>> exectuted (or not at all for that matter).
> Thanks this is what I needed.
> BTW: How can I know which blk functions are not usable in blk-mq?
> I didn't realize that I can use blk_update_request().
>
> Thanks,
> //richard
>
>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661


