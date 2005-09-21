Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EI6sc-0006jQ-3n	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Sep 2005 08:51:30 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EI6sY-0006C1-Hb
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Sep 2005 08:51:30 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Review needed for ubd fixes
References: <200509172245.j8HMjqJD009056@ccure.user-mode-linux.org>
	<200509201401.13750.blaisorblade@yahoo.it>
	<20050920190618.GA9417@ccure.user-mode-linux.org>
In-Reply-To: <20050920190618.GA9417@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509211749.46125.blaisorblade@yahoo.it>
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
Date: Wed, 21 Sep 2005 17:49:43 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

On Tuesday 20 September 2005 21:06, Jeff Dike wrote:
> On Tue, Sep 20, 2005 at 02:01:11PM +0200, Blaisorblade wrote:
> > Hmm, this kind of thing is exactly the one for which mempool's were
> > created - have you looked at whether using them (which can be used for
> > atomic purposes) would be better?

> Yeah, that would be worth looking into.

> > I've not looked at the code, but have you tested that with
> > sleep-inside-spinlock checking enabled?

> > However, ok, you do release spinlocks so you should be safe. However, in
> > your custom allocation routines, you're going to sleep possibly, so why
> > do you use GFP_ATOMIC? There's absolutely no need. If there's a need, you
> > can't take the semaphore afterwards.

> ?

> GFP_ATOMIC doesn't always mean that you're in an interrupt.
> Generally, it means not to sleep in kmalloc.
Yes, but GFP_ATOMIC was needed in first place because we where in an atomic 
section (not for interrupts, but because we were under a spinlock).

> And here, if it fails, 
> I'll use the static buffers.
Since you're going to possibly sleep, it's better to allow kmalloc to sleep in 
first place!

> > These two atomics + one wait queue are very similar to a semaphore, even
> > if not identical. The semaphore value would be submitted - started. The
> > change is that the driver sleep at the first increment of "started"
> > rather than at the last one, but it should be ok. And much less
> > error-prone. If you keep your custom design, you should at least unify
> > the two vars with the difference.

> The wait queue allows the correct thread to be woken up.  If I used a
> semaphore, its value would be the same for all threads, and they would
> all be woken up when that value goes to 0.  With a wait queue, each
> thread has a different value of started, and they wait for submitted
> to catch up to it.
Ok, filtered wait queues. And I also see why you used two atomics rather than 
one. I'll have to think deep about this, though.
> Meanwhile, any other sleeping threads stay 
> sleeping because submitted hasn't caught up to their values of started.
[...]
> I'm concerned about the COW bitmap.  That's something that the upper
> layers know nothing about, so requests could overlap without there
> being barriers between that.

> However, this is an artifact of the implementation, where the section
> of bitmap that will be written out is copied into the aio request when
> it is started.  If I grabbed the bitmap section and set the bits in it
> just before it is written out, then the sequencing stuff might be able
> to just go away.
Is the COW bitmap mmap'ed? Because otherwise we'd need to queue up an 
additional write request, which creates problems.

Btw, msync() allows sync'ing only a specific region, which fsync() doesn't 
allow. Don't know whether we need this really, however (we probably don't do 
it, but we should).

Also, I kept forgetting to mention one thing: Device mapper has the support 
for COW volumes, like we do. E.g. when you create a snapshot, it is not a 
static immutable copy of the original, it's writable too!

Sure, less granular than COW devices, it doesn't copy 512 bytes at a time 
(which may help with performance though), but works on the host too!

I was waiting to let lists know of this after writing a conversion program, 
which I never finished.
> We rely on the block layer to put write barriers 
> between requests with overlapping data.
Don't think it's reasonable to expect this. I think that filesystems like ext2 
will never produce write barriers - they are needed for journaled FS's.
> 				Jeff

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
