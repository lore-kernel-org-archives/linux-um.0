Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH] [RFC] um: Convert ubd driver to blk-mq
Date: Sun, 03 Dec 2017 22:54:43 +0100
Message-ID: <2026565.M1KEqJdkSY@blindfold>
In-Reply-To: <20171129214651.GA5846@lst.de>
References: <20171126131053.32300-1-richard@nod.at> <20171129214651.GA5846@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, axboe@fb.com, anton.ivanov@cambridgegreys.com, linux-block@vger.kernel.org, david@sigma-star.at
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Christoph,

Am Mittwoch, 29. November 2017, 22:46:51 CET schrieb Christoph Hellwig:
> On Sun, Nov 26, 2017 at 02:10:53PM +0100, Richard Weinberger wrote:
> > MAX_SG is 64, used for blk_queue_max_segments(). This comes from
> > a0044bdf60c2 ("uml: batch I/O requests"). Is this still a good/sane
> > value for blk-mq?
> 
> blk-mq itself doesn't change the tradeoff.
> 
> > The driver does IO batching, for each request it issues many UML struct
> > io_thread_req request to the IO thread on the host side.
> > One io_thread_req per SG page.
> > Before the conversion the driver used blk_end_request() to indicate that
> > a part of the request is done.
> > blk_mq_end_request() does not take a length parameter, therefore we can
> > only mark the whole request as done. See the new is_last property on the
> > driver.
> > Maybe there is a way to partially end requests too in blk-mq?
> 
> You can, take a look at scsi_end_request which handles this for blk-mq
> and the legacy layer.  That being said I wonder if batching really
> makes that much sene if you execute each segment separately?

Anton did a lot of performance improvements in this area.
He has all the details.
AFAIK batching brings us more throughput because in UML all IO is done by
a different thread and the IPC has a certain overhead. 

> > Another obstacle with IO batching is that UML IO thread requests can
> > fail. Not only due to OOM, also because the pipe between the UML kernel
> > process and the host IO thread can return EAGAIN.
> > In this case the driver puts the request into a list and retried later
> > again when the pipe turns writable.
> > I’m not sure whether this restart logic makes sense with blk-mq, maybe
> > there is a way in blk-mq to put back a (partial) request?
> 
> blk_mq_requeue_request requeues requests that have been partially
> exectuted (or not at all for that matter).

Thanks this is what I needed.
BTW: How can I know which blk functions are not usable in blk-mq?
I didn't realize that I can use blk_update_request().

Thanks,
//richard


