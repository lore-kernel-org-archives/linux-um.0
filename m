Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1khU6e-0007pt-9f
 for linux-um@lists.infradead.org; Tue, 24 Nov 2020 08:55:25 +0000
Message-ID: <d7b1ec1bbb6995e801c3e7c54c7bb88dcffc54db.camel@sipsolutions.net>
Subject: Re: [PATCH 0/7 um: IRQ handling cleanups
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 24 Nov 2020 09:55:21 +0100
In-Reply-To: <3812c8af-edc1-a2ff-96e5-0ad96e85411b@kot-begemot.co.uk>
References: <20201123195621.275470-1-johannes@sipsolutions.net>
 <3812c8af-edc1-a2ff-96e5-0ad96e85411b@kot-begemot.co.uk>
MIME-Version: 1.0
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
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>, linux-um@lists.infradead.org

On Tue, 2020-11-24 at 08:14 +0000, Anton Ivanov wrote:
> 
> On 23/11/2020 19:56, Johannes Berg wrote:
> > The IRQ code seems very confusing, 
> 
> Tell me about it :)

:)

> > but now that I've had to dig
> > through it, I've come up with a number of cleanups. Really what
> > I wanted was suspend/resume support (next series), but this is
> > all necessary for that, in particular for virtio resume support
> > (still WIP).
> 
> Excellent. I will try to find some time to review it before the end of the day.

Oh, nice, thanks :)

> I have tried some of what you did when working on timers/epoll -
> namely turning off the HZ-like nanosleep in time.c. I could not get it
> to work at the time. So I dropped it from the final version of the
> patches.

That one's just weird ... and unnecessary. I can't see why it could
possibly matter.

Now, I'm not entirely sure that select(0, NULL, NULL, NULL, NULL) really
is the best thing to do.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

