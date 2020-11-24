Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1khUA5-0008Sv-U3
 for linux-um@lists.infradead.org; Tue, 24 Nov 2020 08:58:58 +0000
Message-ID: <293beb66b8293056a1a34ca1bc3b78900bb4d638.camel@sipsolutions.net>
Subject: Re: [PATCH 0/7 um: IRQ handling cleanups
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 24 Nov 2020 09:58:55 +0100
In-Reply-To: <d7b1ec1bbb6995e801c3e7c54c7bb88dcffc54db.camel@sipsolutions.net>
References: <20201123195621.275470-1-johannes@sipsolutions.net>
 <3812c8af-edc1-a2ff-96e5-0ad96e85411b@kot-begemot.co.uk>
 <d7b1ec1bbb6995e801c3e7c54c7bb88dcffc54db.camel@sipsolutions.net>
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

On Tue, 2020-11-24 at 09:55 +0100, Johannes Berg wrote:
> 
> > I have tried some of what you did when working on timers/epoll -
> > namely turning off the HZ-like nanosleep in time.c. I could not get it
> > to work at the time. So I dropped it from the final version of the
> > patches.
> 
> That one's just weird ... and unnecessary. I can't see why it could
> possibly matter.

Or actually ... wait? I thought you were referring to "um: simplify
os_idle_sleep() and sleep longer" but that's not in this set now...

Anyway, if you were indeed referring to that patch, it's not strictly
needed - removing it would just mean I couldn't call os_idle_sleep() for
suspend but would have to add os_suspend() or something. OTOH, it didn't
break anything for me (neither time-travel nor normal mode), and I can't
see how it was necessary since if clock_nanosleep() (or now select())
was interrupted by a signal and returned, the signal handler ran too...

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

