Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GET89-0003YM-8W for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 19 Aug 2006 08:53:01 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GET86-0006HP-9v
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 19 Aug 2006 08:53:01 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sat, 19 Aug 2006 17:52:37 +0200
References: <20060806154431.32159.74360.stgit@memento.home.lan>
	<20060807211352.GA5890@ccure.user-mode-linux.org>
In-Reply-To: <20060807211352.GA5890@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608191752.37939.blaisorblade@yahoo.it>
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
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

On Monday 07 August 2006 23:13, Jeff Dike wrote:
> On Sun, Aug 06, 2006 at 05:44:31PM +0200, Paolo 'Blaisorblade' Giarrusso 
wrote:
> > I had this patch in my queue since some time, because it fixes some
> > spinlocks vs sleeps issues; please verify whether after your
> > restructuring it is still needed (it applied before this restructuring).
>
> I believe this patch is no longer needed.  It looks like all calls to
> activate_fd are in process context.  However, there are a few places
> where it can be reached inside a spinlock.  These cases look like the
> spinlock is held for too long, and needs to be narrowed.

> Here's my work, if you feel like checking it.

Very interesting, thanks (and sorry for the long delay).

> Increasing indendation 
> is going up the call chain.

Have you found a tool for this or just done by hand? (I've seen Understanding 
the Linux VMM talking about tools for call graphs).

> At the top of each chain, there's a 
> "proc", along with my reason for believing the procedure is only
> called in process context.  When that's not there, it's because that
> call tree had already been covered ealier.

> There's some stuff in the network which I didn't go into because it's
> code I have no clue about.

After the networking locking patch, I'll recheck, but uml_net_open should now 
be covered by a simple mutex so there's no problem.
I also think that most of them should become mutexes or disappear.

> Every procedure can call activate_fd under a spinlock is so marked.

> activate_fd
>     um_request_irq
>         line_setup_irq
> 	    enable_chan
> 		line_open - SPINLOCK

This should be a mutex, but it's not very simple to do this since the tty 
layer is not so nice as char/block/network layer, to my current knowledge.

So, the other road is that you simply reduce spinlock holding time, or that 
you merge this patch when I resend (I've done some changes). Everything 
however applies to SMP only, luckily, for now; IRQ disabling can cause 
hangs/races on UP kernels.

And, sadly, sigio_lock must become a irq disabling spinlock; so once, at boot 
time, we'll have a call to sleeping kmalloc with disabled irqs, if you don't 
merge this, and this call can crash.

> 	uml_net_open - struct net_device.open, SPINLOCK

Same stuff, converted in my patch about network (which I'll resend).

> 	write_sigio_irq
> 	    write_sigio_workaround - SPINLOCK
> 		maybe_sigio_broken
> 		    activate_fd

You deleted (in [PATCH 1/4] UML - SIGIO cleanups) a comment about turning that 
spinlock into a semaphore - the comment talked about reactivate_fd, however 
it is still a fact that maybe_sigio_broken() should be an initcall.

Some empiric debug about _when_ it is called (printk's) would help doing the 
right thing; currently it uses a spinlock to check the flag saying whether it 
has already been called.

It should not - when the variable is first set in an initcall, you can simply 
add a memory barrier to ensure visibility; maybe you do not even need the 
barrier.
I say you don't need from existing practice, it seems, but it seems you need 
because there's no reason to assume otherwise.

I do not want to touch that code since I don't understand it fully right now; 
probably it makes sense, but probably documenting it would help, and it could 
lead to some restructuring. The following considerations are based on the 
little I have seen - I have decided not to study fully the code, I'm looking 
at it but understanding it fully is not easy (btw, I've studied the code 
pre-"SIGIO cleanups" and then looked at the patch).

I hope many of the following notes are wrong and that you can document it and 
that I can understand my errors. However I cannot ignore my feelings about 
code & data structures, which are truely redundant.

current_poll is maybe distinct since all SIGIO handling also triggers a single 
IRQ (requested by write_sigio_irq), but that IRQ simply consumes the wakeup 
from the fd and reactivates itself, so:

* I don't see its purpose: statistics? Triggering IRQs processing?

* This is somehow strange - and leads to the above recursion.

* I'd like you to write up _why_ you _actively_ build a model where 
write_sigio_thread(), after there is activity on a single fd, removes it from 
current_poll, while the irq handler almost always calls reactivate_fd() to 
undo this; most drivers do it for each IRQ, except for TELNETD_IRQ and 
XTERM_IRQ, which must be one-shot; but they call free_irq, so this is not 
very useful for them, and anyway they should request this behaviour with a 
flag if they need it (or they can ignore subsequent irqs until irq freeing by 
setting their own flags).

If this is used to serialize irqs, it is a bad solution, and irq serialization 
is probably a bad idea this way - it should be handled at another level, i.e. 
the existing irq disabling inside irq processing; for IRQs running on 
multiple CPUs the solution is likely to use a spinlock anyway in most cases 
(this is the usual rule I think).

In particular (and a comment patch is preferred to a mail) why 
arch/um/os-Linux/sigio.c has a list of fds to poll, i.e. current_poll, and 
arch/um/os-Linux/irq.c has another one, i.e. pollfds, and there is finally 
active_fds used for irq too; also if current_poll excludes just the "SIGIO 
write" irq it is also redundant.

arch/um/os-Linux/irq.c:os_free_irq_by_cb, line 94 reads as:

printk("os_free_irq_by_cb - mismatch between "
"active_fds and pollfds, fd %d vs %d\n",

which can be probably considered as a sign of non-normalization (in DB 
parlance) of data structure.

active_fds could probably be a set of pointers to pollfds array - there should 
theoretically be a single array holding everything and active_fds pointing to 
it.

Failing that (since the pollfds array must be such to be used by poll), I do 
not see why active_fds must contain fds instead of relying on ones in 
pollfds.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade

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
