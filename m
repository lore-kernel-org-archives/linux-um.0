Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D9pfZ-0008N1-Uk for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Mar 2005 11:19:33 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1D9pfW-0004Hr-7P for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Mar 2005 11:19:33 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: [patch 1/1] unified spinlock initialization
	arch/um/drivers/port_kern.c
References: <20050309094234.8FC0C6477@zion>
	<200503092052.24803.blaisorblade@yahoo.it>
	<1110442320.29330.196.camel@tglx.tec.linutronix.de>
In-Reply-To: <1110442320.29330.196.camel@tglx.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503112018.42662.blaisorblade@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 11 Mar 2005 20:18:42 +0100
To: user-mode-linux-devel@lists.sourceforge.net, tglx@linutronix.de
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, domen@coderock.org, amitg@calsoftinc.com, gud@eth.net

On Thursday 10 March 2005 09:12, Thomas Gleixner wrote:
> On Wed, 2005-03-09 at 20:52 +0100, Blaisorblade wrote:
> > > Are you sure this is really the best option in this instance?
> > > Sometimes, static data initialisation is more efficient than
> > > code-based manual initialisation, especially when the memory
> > > is written to anyway.
> >
> > Agreed, theoretically, but this was done for multiple reasons globally,
> > for instance as a preparation to Ingo Molnar's preemption patches. There
> > was mention of this on lwn.net about this:
> >
> > http://lwn.net/Articles/108719/
>
> Those patches did only the conversion of
>
> static spinlock_t lock = SPIN_LOCK_UNLOCKED;
>        lock = SPIN_LOCK_UNLOCKED;
> to
> static DEFINE_SPINLOCK(lock);
>        spin_lock_init(lock);
First: I didn't write the patch, only forwarded it, so I just guessed why it 
was done.

The latter is spin_lock_init(&lock); (since someone got confused about this).

However, this is a .lock = SPIN_LOCK_UNLOCKED  -> 
spin_lock_init(&struct.lock),

so I don't understand what changes... the structure is initialized inside a 
function, so there's no change.

> If you want to do static initialization inside of structures, then you
> have to define a seperate MACRO similar to the static initialization of
> list_head's inside of structures:

> static struct sysfs_dirent sysfs_root = {
>         .s_sibling      = LIST_HEAD_INIT(sysfs_root.s_sibling),

I don't see the need here... and the initialization is not in static code; it 
changes this code snippet:

void *port_data(int port_num)
{
//...
        *port = ((struct port_list)
                { .list                 = LIST_HEAD_INIT(port->list),
                  .has_connection       = 0,
                  .sem                  = __SEMAPHORE_INITIALIZER(port->sem,
                                                                  0),
                  .lock                 = SPIN_LOCK_UNLOCKED,
                  .port                 = port_num,
                  .fd                   = fd,
                  .pending              = LIST_HEAD_INIT(port->pending),
                  .connections          = 
LIST_HEAD_INIT(port->connections) });

So you are all doing some confusion (in fact I guess Andrew realized this when 
he merged this anyway).

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
