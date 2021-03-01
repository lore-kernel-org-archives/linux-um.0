Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lGlr9-0004sR-KY
 for linux-um@lists.infradead.org; Mon, 01 Mar 2021 16:57:17 +0000
Date: Mon, 1 Mar 2021 17:57:10 +0100
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH next v3 01/15] um: synchronize kmsg_dumper
Message-ID: <YD0c5jMDTTKVrU8X@alley>
References: <20210225202438.28985-1-john.ogness@linutronix.de>
 <20210225202438.28985-2-john.ogness@linutronix.de>
 <YD0TYkWZqcS/VO8Z@alley>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YD0TYkWZqcS/VO8Z@alley>
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
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thomas Meyer <thomas@m3y3r.de>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Mon 2021-03-01 17:16:35, Petr Mladek wrote:
> On Thu 2021-02-25 21:24:24, John Ogness wrote:
> > The kmsg_dumper can be called from any context and CPU, possibly
> > from multiple CPUs simultaneously. Since a static buffer is used
> > to retrieve the kernel logs, this buffer must be protected against
> > simultaneous dumping. Skip dumping if another context is already
> > dumping.
> > 
> > Signed-off-by: John Ogness <john.ogness@linutronix.de>
> > Reviewed-by: Petr Mladek <pmladek@suse.com>
> > ---
> >  arch/um/kernel/kmsg_dump.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/arch/um/kernel/kmsg_dump.c b/arch/um/kernel/kmsg_dump.c
> > index 6516ef1f8274..4869e2cc787c 100644
> > --- a/arch/um/kernel/kmsg_dump.c
> > +++ b/arch/um/kernel/kmsg_dump.c
> > @@ -1,5 +1,6 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  #include <linux/kmsg_dump.h>
> > +#include <linux/spinlock.h>
> >  #include <linux/console.h>
> >  #include <linux/string.h>
> >  #include <shared/init.h>
> > @@ -9,6 +10,7 @@
> >  static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
> >  				enum kmsg_dump_reason reason)
> >  {
> > +	static DEFINE_SPINLOCK(lock);
> >  	static char line[1024];
> >  	struct console *con;
> >  	size_t len = 0;
> > @@ -29,11 +31,16 @@ static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
> >  	if (con)
> >  		return;
> >  
> > +	if (!spin_trylock(&lock))
> 
> I have almost missed this. It is wrong. The last version correctly
> used
> 
> 	if (!spin_trylock_irqsave(&lock, flags))
> 
> kmsg_dump(KMSG_DUMP_PANIC) is called in panic() with interrupts
> disabled. We have to store the flags here.

Ah, I get always confused with these things. spin_trylock() can
actually get called in a context with IRQ disabled. So it is not
as wrong as I thought.

But still. panic() and kmsg_dump() can be called in IRQ context.
So, this function might be called in IRQ context. So, it feels
more correct to use the _irqsafe variant here.

I know that there is the trylock so it probably does not matter much.
Well, the disabled irq might help to serialize the two calls when
one is in normal context and the other would happen in IRQ one.

As I said, using _irqsafe variant looks better to me.

What do you think, please?

Best Regards,
Petr

PS: Heh, IMHO, I do not use an authoritative style too often. But my
feeling is that every time I use it then I am proven to be wrong.
And it has happened again.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

