Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GAPIn-0006rO-L1 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Aug 2006 03:59:13 -0700
Received: from web25224.mail.ukl.yahoo.com ([217.146.176.210])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GAPIl-0003fG-RD
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Aug 2006 03:59:13 -0700
Message-ID: <20060808105905.10762.qmail@web25224.mail.ukl.yahoo.com>
Date: Tue, 8 Aug 2006 12:59:05 +0200 (CEST)
From: Paolo Giarrusso <blaisorblade@yahoo.it>
In-Reply-To: <20060807221400.GC5890@ccure.user-mode-linux.org>
MIME-Version: 1.0
Subject: Re: [uml-devel] [PATCH 2/3] uml: fix proc-vs-interrupt context
	spinlock deadlock
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Jeff Dike <jdike@addtoit.com> ha scritto: 

> On Sun, Aug 06, 2006 at 05:47:03PM +0200, Paolo 'Blaisorblade'
> Giarrusso wrote:
> > From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> > 
> > This spinlock can be taken on interrupt too, so
> spin_lock_irq[save] must be used.
> > 
> > However, Documentation/networking/netdevices.txt explains we are
> called with
> > rtnl_lock() held - so we don't need to care about other
> concurrent opens.
> > Verified also in LDD3 and by direct checking. Also verified that
> the network
> > layer (through a state machine) guarantees us that nobody will
> close the
> > interface while it's being used. Please correct me if I'm wrong.
> > 
> > Also, we must check we don't sleep with irqs disabled!!! But
> anyway, this is not
> > news - we already can't sleep while holding a spinlock. Who says
> this is
> > guaranted really by the present code?

> This patch looks fairly scary.

Right, not to merge in "bugfixes only" time.

> It's protecting the device private
> data, you're removing the locking from some accesses and leaving it
> (albeit with irqs off now) on others.  It seems to me that can't be
> right.  It's either always there, or always not.

I disagree strongly but I needed time to reach this deep
understanding. LDD tells you what to do but skips this question; when
you want to convert code like ours to code like LDD's (i.e. what I
did in this patch) you need to deeply study the source and change
point of view (I recognize I'm a bit too messianic in this mail, but
I like these ideas).

The "state machine" thinking is a very deep one. Whoever said that
mutual exclusion (no two threads must act on a single object at the
same moment) means using locks (one thread waits the other finishes
its work)?

You can also return immediately instead of waiting the other thread
to finish. This solves various problems like "I need a spinlock for
exclusion vs. interrupts but also a mutex because I can sleep". I was
so astonished I want to write something on this (possibly a book or
my thesis, or both), and to apply this to the tty locking (when I'll
have time).

I could be wrong, but I trust that thanks to deep and good work by
who designed locking in the network layer, this patch is correct. And
indeed I addressed your issues below.

> You observe that open and close are protected by rtnl_lock.  I
> observe
> that uml_net_change_mtu and uml_net_set_mac are as well, in
> dev_ioctl.

Fine...

> The spinlock protecting this has to be _irqsave because the
> interrupt
> routine takes it, to protect against receiving packets on an
> interface
> that's being closed.

Yep, I must admit I don't remember verifying this one.

But it is solved; the interrupt routine has:

        if(!netif_running(dev)) // this tests __LINK_STATE_START
                return(IRQ_NONE);
_before_ anything else.

and dev_close has:
        clear_bit(__LINK_STATE_START, &dev->state);

> If that's impossible, we should prove that,
> and remove the locking from uml_net_interrupt.

That locking is there for other reasons I think: probably for
multiple irqs/tx vs rx. However there is also dev->xmit_lock (and you
can disable xmit_lock to use your own locking).

In all conflicts I could find the network layer makes sure you don't
need to lock process vs interrupt context (better, you don't have to
lock lifecycle progress against normal operations).

This is also true of char/block devices (you don't need to lock
against write/read in open/close; UBD doesn't know that but I have
unfinished patches for it), but there it's simpler: if userspace you
call close while a read is executing, thanks to refcounting (sys_read
does fget) the ->close (or ->release) is only called after the end of
->read.

On the other hand, the tty/console locking IMHO is problematic
because (to my knowledge) it does not satisfy this property (and
because you have to mix tty and console locking, and it is not easy
to design a clean solution to this).

> I can't decide about uml_net_start_xmit - there's some RCU stuff
> around one call that leads to it, but I don't see any sign of
> rtnl_lock.

It shouldn't use it - that lock is only for lifecycle.
See Documentation/networking/netdevices.txt (there is also a LWN
article on disabling xmit_lock to use custom locking).

http://lwn.net/Articles/101215/
http://lwn.net/Articles/121566/

> So, I'd say there are some changes needed here, but they're not
> entirely the ones in this patch.

Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
