Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EHoS8-0002Tx-Ox	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Sep 2005 13:10:56 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EHoS5-0007yQ-Hd
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Sep 2005 13:10:56 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Review needed for ubd fixes
Message-ID: <20050920190618.GA9417@ccure.user-mode-linux.org>
References: <200509172245.j8HMjqJD009056@ccure.user-mode-linux.org>
	<200509201401.13750.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509201401.13750.blaisorblade@yahoo.it>
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
Date: Tue, 20 Sep 2005 15:06:18 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

On Tue, Sep 20, 2005 at 02:01:11PM +0200, Blaisorblade wrote:
> Hmm, this kind of thing is exactly the one for which mempool's were created -
> have you looked at whether using them (which can be used for atomic purposes)
> would be better?

Yeah, that would be worth looking into.

> I've not looked at the code, but have you tested that with 
> sleep-inside-spinlock checking enabled?
> 
> However, ok, you do release spinlocks so you should be safe. However, in your
> custom allocation routines, you're going to sleep possibly, so why do you use
> GFP_ATOMIC? There's absolutely no need. If there's a need, you can't take the
> semaphore afterwards.

?

GFP_ATOMIC doesn't always mean that you're in an interrupt.
Generally, it means not to sleep in kmalloc.  And here, if it fails,
I'll use the static buffers.

> Also, GFP_KERNEL|GFP_ATOMIC is bogus - GFP_ATOMIC must be used alone, when 
> needed.

OK.

> About AIO, I've read on http://lse.sourceforge.net/io/aio.html that, indeed, 
> the host AIO code isn't really Asynchronous for buffered I/O, but only for 
> O_DIRECT I/O (which we don't seem to use).

There's another patch, called o_direct, which I didn't send out, which
fixes this.

> These two atomics + one wait queue are very similar to a semaphore, even if 
> not identical. The semaphore value would be submitted - started. The change 
> is that the driver sleep at the first increment of "started" rather than at 
> the last one, but it should be ok. And much less error-prone. If you keep 
> your custom design, you should at least unify the two vars with the 
> difference.

The wait queue allows the correct thread to be woken up.  If I used a
semaphore, its value would be the same for all threads, and they would
all be woken up when that value goes to 0.  With a wait queue, each
thread has a different value of started, and they wait for submitted
to catch up to it.  Meanwhile, any other sleeping threads stay
sleeping because submitted hasn't caught up to their values of started.

> However, I would like to note that you're not always forced to sequence 
> requests - write barriers were recently implemented, so the filesystem 
> explicitly serializes requests when needed, rather than ask for strictly 
> sequential processing. It's not especially hard to do, when you use your 
> custom semaphore code - you can say "down() but don't sleep".

I'm concerned about the COW bitmap.  That's something that the upper
layers know nothing about, so requests could overlap without there
being barriers between that.

However, this is an artifact of the implementation, where the section
of bitmap that will be written out is copied into the aio request when
it is started.  If I grabbed the bitmap section and set the bits in it
just before it is written out, then the sequencing stuff might be able
to just go away.  We rely on the block layer to put write barriers
between requests with overlapping data.

				Jeff


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
