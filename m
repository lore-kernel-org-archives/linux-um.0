Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1khd7s-0001OF-Q7
 for linux-um@lists.infradead.org; Tue, 24 Nov 2020 18:33:17 +0000
Message-ID: <76d96967160a7c1d3ea328df7236f290aa84aae2.camel@sipsolutions.net>
Subject: Re: [PATCH 0/7 um: IRQ handling cleanups
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 24 Nov 2020 19:32:56 +0100
In-Reply-To: <b7a40102-fbc3-308a-fc55-332e6696b1b3@kot-begemot.co.uk>
References: <20201123195621.275470-1-johannes@sipsolutions.net>
 <3812c8af-edc1-a2ff-96e5-0ad96e85411b@kot-begemot.co.uk>
 <d7b1ec1bbb6995e801c3e7c54c7bb88dcffc54db.camel@sipsolutions.net>
 <293beb66b8293056a1a34ca1bc3b78900bb4d638.camel@sipsolutions.net>
 <cdf91602-b6d8-3347-4d02-747b87fac4b3@kot-begemot.co.uk>
 <61a9da79-da79-d779-78be-af30f88b6f05@kot-begemot.co.uk>
 <425d0c637bff893c89ee9374e6f741bbace89f27.camel@sipsolutions.net>
 <9f8f7c56-5c63-8281-4766-3821cbe6f6a7@kot-begemot.co.uk>
 <ebcb1d02478af06d0bb368a338b63752fe6c1d68.camel@sipsolutions.net>
 <b7a40102-fbc3-308a-fc55-332e6696b1b3@kot-begemot.co.uk>
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

On Tue, 2020-11-24 at 17:07 +0000, Anton Ivanov wrote:
> 
> Looks like chan_kern.c handles it now. It schedules delayed work
> itself instead of trying to kill the IRQ out of IRQ context.
> 
> So the ->purge in irq.c and everything dealing with it should not be
> necessary any more.

Aha, ok, great :)

Looking at the commit, I don't think I even had to care about ->purge
because it's basically just there to avoid possible use-after-free? And
then even if you did remove it from IRQ context, we'd not be freeing the
data anyway, we'd only be setting some data?

And actually, wouldn't it have been broken before, because
garbage_collect_entries() was still called in free_irq_by_irq_and_dev()?
So it's not like it wouldn't have been freed in the interrupt handler if
you were going to call that from within the interrupt handler? Or did I
misunderstand?

I guess what I'm trying to say is that since I removed the dynamic
allocation of what was previously "struct irq_fd", and
garbage_collect_entries() was called in the relevant places and would
free it, I didn't really see how that was any different?
do_free_by_irq_and_dev() previously marked as purge,
but garbage_collect_irq_entries() was immediately called ...

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

