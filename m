Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Subject: Re: [uml-devel] [PATCH] [RFC] um: Convert ubd driver to blk-mq
Date: Sun, 26 Nov 2017 14:56:06 +0100
Message-ID: <2279424.kI4kpP6Uiy@blindfold>
In-Reply-To: <281c725e-336f-8745-b3c5-0e57421d6335@kot-begemot.co.uk>
References: <20171126131053.32300-1-richard@nod.at> <281c725e-336f-8745-b3c5-0e57421d6335@kot-begemot.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Cc: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org, "hch@lst.de" <hch@lst.de>, Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Anton,

please don't crop the CC list.

Am Sonntag, 26. November 2017, 14:41:12 CET schrieb Anton Ivanov:
> I need to do some reading on this.
> 
> First of all - a stupid question: mq's primary advantage is in
> multi-core systems as it improves io and core utilization. We are still
> single-core in UML and AFAIK this is likely to stay that way, right?

Well, someday blk-mq should completely replace the legacy block interface.
Christoph asked me convert the UML driver.
Also do find corner cases in blk-mq.
 
> On 26/11/17 13:10, Richard Weinberger wrote:
> > This is the first attempt to convert the UserModeLinux block driver
> > (UBD) to blk-mq.
> > While the conversion itself is rather trivial, a few questions
> > popped up in my head. Maybe you can help me with them.
> > 
> > MAX_SG is 64, used for blk_queue_max_segments(). This comes from
> > a0044bdf60c2 ("uml: batch I/O requests"). Is this still a good/sane
> > value for blk-mq?
> > 
> > The driver does IO batching, for each request it issues many UML struct
> > io_thread_req request to the IO thread on the host side.
> > One io_thread_req per SG page.
> > Before the conversion the driver used blk_end_request() to indicate that
> > a part of the request is done.
> > blk_mq_end_request() does not take a length parameter, therefore we can
> > only mark the whole request as done. See the new is_last property on the
> > driver.
> > Maybe there is a way to partially end requests too in blk-mq?
> > 
> > Another obstacle with IO batching is that UML IO thread requests can
> > fail. Not only due to OOM, also because the pipe between the UML kernel
> > process and the host IO thread can return EAGAIN.
> > In this case the driver puts the request into a list and retried later
> > again when the pipe turns writable.
> > I’m not sure whether this restart logic makes sense with blk-mq, maybe
> > there is a way in blk-mq to put back a (partial) request?
> 
> This all sounds to me as blk-mq requests need different inter-thread
> IPC. We presently rely on the fact that each request to the IO thread is
> fixed size and there is no natural request grouping coming from upper
> layers.
> 
> Unless I am missing something, this looks like we are now getting group
> requests, right? We need to send a group at a time which is not
> processed until the whole group has been received in the IO thread. We
> cans still batch groups though, but should not batch individual
> requests, right?

The question is, do we really need batching at all with blk-mq?
Jeff implemented that 10 years ago.

> My first step (before moving to mq) would have been to switch to a unix
> domain socket pair probably using SOCK_SEQPACKET or SOCK_DGRAM. The
> latter for a socket pair will return ENOBUF if you try to push more than
> the receiving side can handle so we should not have IPC message loss.
> This way, we can push request groups naturally instead of relying on a
> "last" flag and keeping track of that for "end of request".

The pipe is currently a socketpair. UML just calls it "pipe". :-(

> It will be easier to roll back the batching before we do that. Feel free
> to roll back that commit.
> 
> Once that is in, the whole batching will need to be redone as it should
> account for variable IPC record size and use sendmmsg/recvmmsg pair -
> same as in the vector IO. I am happy to do the honors on that one :)

Let's see what block guys say.

Thanks,
//richard

