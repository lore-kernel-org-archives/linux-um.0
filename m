Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i9qdp-0000cz-7J
 for linux-um@lists.infradead.org; Mon, 16 Sep 2019 13:02:06 +0000
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <johannes@sipsolutions.net>) id 1i9qdk-0002kE-Ta
 for linux-um@lists.infradead.org; Mon, 16 Sep 2019 15:02:01 +0200
Message-ID: <b183e530c14aa709dd7a67fe0681bfb50d0cb5f4.camel@sipsolutions.net>
Subject: Re: [RFC] synchronised multi-machine time-travel APIs
From: Johannes Berg <johannes@sipsolutions.net>
Date: Mon, 16 Sep 2019 15:01:59 +0200
In-Reply-To: <a216fef2119146de27168d0cf91ffa2f2b970e77.camel@sipsolutions.net>
References: <a216fef2119146de27168d0cf91ffa2f2b970e77.camel@sipsolutions.net>
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
To: linux-um@lists.infradead.org

On Mon, 2019-09-16 at 11:27 +0200, Johannes Berg wrote:
> 
> 3) There are some virtio hooks for general devices like virtio_net to
>    make the simulation work (e.g. IRQs need to be deferred to the
>    simulation time, not be done when signalled), and we want to use
>    poll() instead of SIGIO in this case etc. This is all necessary,
>    *however*, the "simtime" device that is responsible for the time
>    synchronization needs to be *exempted* from all this handling, which
>    again makes the code more complex than needed.

Thinking about this some more ...

We currently can handle only one IRQ at a time, of course, but e.g. with
simulated network we basically end up doing

virtio_net RX interrupt
-> request runtime for IRQ handling via simtime device

However, to request runtime we send a message out on the simtime device,
but then we have to also handle incoming messages while we wait for a
response to this, since the request might change things around ... all
while in interrupt context, so the normal message handling doesn't work.

This required adding a whole new poll() abstraction to UML, which I
never really liked.

I'll try this a bit, but it seems if we make this all go back down to
the existing epoll abstraction, we just have to tag the "time" irq/fd as
having special treatment, not everything else.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

