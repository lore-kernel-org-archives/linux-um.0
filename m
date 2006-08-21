Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GFIpF-0004ls-NS for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 21 Aug 2006 16:04:57 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GFIpE-00071J-SO
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 21 Aug 2006 16:04:57 -0700
Date: Mon, 21 Aug 2006 19:04:20 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060821230420.GA6114@ccure.user-mode-linux.org>
References: <20060806154431.32159.74360.stgit@memento.home.lan>
	<20060807211352.GA5890@ccure.user-mode-linux.org>
	<200608191752.37939.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200608191752.37939.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH] [RFC] uml: make activate_fd atomic
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
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sat, Aug 19, 2006 at 05:52:37PM +0200, Blaisorblade wrote:
> Have you found a tool for this or just done by hand? (I've seen Understanding
> the Linux VMM talking about tools for call graphs).

I spent an afternoon doing it by hand.

> After the networking locking patch, I'll recheck, but uml_net_open should now
> be covered by a simple mutex so there's no problem.
> I also think that most of them should become mutexes or disappear.
> 
> > Every procedure can call activate_fd under a spinlock is so marked.
> 
> > activate_fd
> >     um_request_irq
> >         line_setup_irq
> > 	    enable_chan
> > 		line_open - SPINLOCK
> 
> This should be a mutex, but it's not very simple to do this since the tty 
> layer is not so nice as char/block/network layer, to my current knowledge.
> 
> So, the other road is that you simply reduce spinlock holding time, or that 
> you merge this patch when I resend (I've done some changes). Everything 
> however applies to SMP only, luckily, for now; IRQ disabling can cause 
> hangs/races on UP kernels.
> 
> And, sadly, sigio_lock must become a irq disabling spinlock; so once, at boot 
> time, we'll have a call to sleeping kmalloc with disabled irqs, if you don't 
> merge this, and this call can crash.
> 
> > 	uml_net_open - struct net_device.open, SPINLOCK
> 
> Same stuff, converted in my patch about network (which I'll resend).
> 
> > 	write_sigio_irq
> > 	    write_sigio_workaround - SPINLOCK
> > 		maybe_sigio_broken
> > 		    activate_fd
> 
> You deleted (in [PATCH 1/4] UML - SIGIO cleanups) a comment about turning 
> that spinlock into a semaphore - the comment talked about reactivate_fd, 
> however it is still a fact that maybe_sigio_broken() should be an initcall.

For reference, here is that comment.

-       /* Critical section - locked by a spinlock because this stuff can
-        * be changed from interrupt handlers.  The stuff above is done
-        * outside the lock because it allocates memory.
-        */
-
-       /* Actually, it only looks like it can be called from interrupt
-        * context.  The culprit is reactivate_fd, which calls
-        * maybe_sigio_broken, which calls write_sigio_workaround,
-        * which calls activate_fd.  However, write_sigio_workaround should
-        * only be called once, at boot time.  That would make it clear that
-        * this is called only from process context, and can be locked with
-        * a semaphore.
-        */

Perhaps I was overzealous about removing that last sentence, but the rest
of it deserves to go.

I would just as soon leave maybe_sigio_broken as-is.  It starts a new
thread, which is kind of expensive if it's never going to be used.

On the other hand, maybe the code will be noticably cleaner (i.e. no
spinlock protecting the have-I-been-called flag).

> It should not - when the variable is first set in an initcall, you can simply
> add a memory barrier to ensure visibility; maybe you do not even need the 
> barrier.

There's no need for a memory barrier in that case - initcalls are
single-threaded.

> I hope many of the following notes are wrong and that you can document it and
> that I can understand my errors. However I cannot ignore my feelings about 
> code & data structures, which are truely redundant.
> 
> current_poll is maybe distinct since all SIGIO handling also
> triggers a single IRQ (requested by write_sigio_irq), but that IRQ
> simply consumes the wakeup from the fd and reactivates itself, so:
> 
> * I don't see its purpose: statistics? Triggering IRQs processing?

Triggering IRQ processing - when one interrupt comes in, poll is used
to check all active interrupt sources, so this suffices to handle
whatever happened on any descriptor.

> * This is somehow strange - and leads to the above recursion.

Which recursion?  The activate_fd -> activate-fd recursion?  That's
caused by the on-demand activation of the sigio thread, and would be
eliminated by your proposal to make it an initcall.  However, this
doesn't have anything to do with the property that simply receiving
this IRQ causes all pending I/O to be handled.

> * I'd like you to write up _why_ you _actively_ build a model where 
> write_sigio_thread(), after there is activity on a single fd,
> removes it from current_poll, while the irq handler almost always
> calls reactivate_fd() to undo this; most drivers do it for each IRQ,
> except for TELNETD_IRQ and XTERM_IRQ, which must be one-shot; but
> they call free_irq, so this is not very useful for them, and anyway
> they should request this behaviour with a flag if they need it (or
> they can ignore subsequent irqs until irq freeing by setting their
> own flags).

The idea is to avoid subsequent IRQs on the same descriptor while
input is being handled.  The drivers will drain pending input anyway,
so continuing to receive interrupts is just a waste of time.  It might
be a useful cleanup to move the reactivation out of the drivers to a
common place.

> In particular (and a comment patch is preferred to a mail) why 
> arch/um/os-Linux/sigio.c has a list of fds to poll, i.e. current_poll, and 
> arch/um/os-Linux/irq.c has another one, i.e. pollfds, and there is finally 
> active_fds used for irq too; also if current_poll excludes just the "SIGIO 
> write" irq it is also redundant.

I'll send mail anyway, and work up a patch later :-)

current_poll is used by the sigio thread, and is the set of
descriptors for which SIGIO doesn't work.  It's a subset of
pollfds.

pollfds is forced on us by the host kernel, but there is not enough
information in it, i.e. no dev_id that can be passed to the IRQ
system.

So, active_fds is the full set of interrupt source information, from
which pollfds is calculated.

> arch/um/os-Linux/irq.c:os_free_irq_by_cb, line 94 reads as:
> 
> printk("os_free_irq_by_cb - mismatch between "
> "active_fds and pollfds, fd %d vs %d\n",
> 
> which can be probably considered as a sign of non-normalization (in DB 
> parlance) of data structure.

Normalization means something different to me - when there are
multiple representation of something (like 1/2, 2/4, etc), you pick
one, and that's the normalized representation.  I don't if there's an
official term for what the printk is talking about - I would say
they're out of sync, or inconsistent, or incoherent.

In any case, that's why there is a complaint if is a mismatch between
them.

> active_fds could probably be a set of pointers to pollfds array -
> there should theoretically be a single array holding everything and
> active_fds pointing to it.

Well, you could do that.  There's a choice between
	two separate arrays holding different sets of information
about the descriptors - the pollfds holding most of it, and something
else holding the dev_ids
	a unified structure from which the pollfds are constructed -
and thus the pollfds are redundant.

I don't see a strong reason to prefer one over the other.  What we have
now seems a bit cleaner to me.

> Failing that (since the pollfds array must be such to be used by poll), I do 
> not see why active_fds must contain fds instead of relying on ones in 
> pollfds.

I think this is a personal preference - I like a unified
representation where I can find everything I want, at the expense of
some memory.  There's no reason it can't be done the way you say - I
just find it a bit clumsier.

				Jeff

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
