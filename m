Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EHmUz-0004uL-Tt	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Sep 2005 11:05:45 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EHmUs-0002wI-1M
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Sep 2005 11:05:42 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Review needed for ubd fixes
References: <200509172245.j8HMjqJD009056@ccure.user-mode-linux.org>
In-Reply-To: <200509172245.j8HMjqJD009056@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200509201401.13750.blaisorblade@yahoo.it>
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
Date: Tue, 20 Sep 2005 14:01:11 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

On Sunday 18 September 2005 00:45, Jeff Dike wrote:
> I've spent some time working on the ubd and AIO problems that have cropped
> up recently.  Patches are attached - a critical look at them would be
> appreciated.
>
> I'm going to start with a problem that hasn't exactly cropped up, and move
> on to the other ones from there.

> That is that the ubd driver must issue I/O requests to the host even if
> there is no memory available.  It must make progress, because the request
> for which it can't get memory might be the swapping that will free some up.

> The driver allocates memory for several purposes -
> 	a header-type buffer per request which holds the bitmap data
> 	one aio request per chunk - a request may be broken into chunks because
> of COWing - some pieces from the backing file, some from the COW file

> To allow the driver to always make progress, even when no memory is
> available, I added a static instance of each buffer and made the kmalloc
> calls atomic. When kmalloc fails, then the static buffer is used.
Hmm, this kind of thing is exactly the one for which mempool's were created - 
have you looked at whether using them (which can be used for atomic purposes) 
would be better?
> When it 
> is in use, the user acquires a semaphore, which is released in the
> interrupt handler when the buffer is freed.  This implies that future I/O
> submissions will sleep on the semaphore, so we have changed the reason for
> sleeping rather than eliminating it.
I've not looked at the code, but have you tested that with 
sleep-inside-spinlock checking enabled?

However, ok, you do release spinlocks so you should be safe. However, in your 
custom allocation routines, you're going to sleep possibly, so why do you use 
GFP_ATOMIC? There's absolutely no need. If there's a need, you can't take the 
semaphore afterwards.

Also, GFP_KERNEL|GFP_ATOMIC is bogus - GFP_ATOMIC must be used alone, when 
needed.

Grep kernel/*.c to make sure, or look at the definition.
> Any I/O submissions which need memory will sleep on the semaphore until the
> buffer is released, resulting in synchronous, one at a time, I/O submission
> until the memory shortage has cleared up.
About AIO, I've read on http://lse.sourceforge.net/io/aio.html that, indeed, 
the host AIO code isn't really Asynchronous for buffered I/O, but only for 
O_DIRECT I/O (which we don't seem to use).

We're safe, sure, and the new code is anyhow better in using the new 
blockdevice model.
> Now that it is established that we must sleep, the next problem is making
> sure the requests get submitted to the host in the order that they were
> queued to the driver.  Because we must sleep, we must drop the queue
> spinlock, which opens the queue to any other processes that want to do I/O.
>  One of these can queue to the allocation semaphore (or just kmalloc memory
> now that some is available) and sneak ahead of a process handling an
> earlier request.

> To solve this, I add two atomic variables and a wait queue.  One of the
> variables, started, counts the number of requests that have been submitted
> to the driver and the other, submitted, counts the number that have been
> submitted to the host.  started is incremented before any submissions,
> submitted is incremented after all submissions for the request.

> The driver gets the value of started and waits for submitted to catch up to
> it.  When that happens, it is now that requests's turn, and it wakes up
> from the sequence wake queue.
These two atomics + one wait queue are very similar to a semaphore, even if 
not identical. The semaphore value would be submitted - started. The change 
is that the driver sleep at the first increment of "started" rather than at 
the last one, but it should be ok. And much less error-prone. If you keep 
your custom design, you should at least unify the two vars with the 
difference.

I'm not confident about the races between the two different variables, even if 
it may be perfectly safe (Tanenbaum uses something very similar, with even 
two vars, for the producer-consumer example). But it must be examined.

And yes, on a semaphore you can call up() as many times as you want (which is 
non-obvious maybe - I didn't realize well until one week ago). In fact, 
provisions are made to initialize a semaphore with initial count bigger than 
1.

However, I would like to note that you're not always forced to sequence 
requests - write barriers were recently implemented, so the filesystem 
explicitly serializes requests when needed, rather than ask for strictly 
sequential processing. It's not especially hard to do, when you use your 
custom semaphore code - you can say "down() but don't sleep".
> I believe these three fixes - dropping the spinlock around host I/O
> submission, adding the static buffers, and sequencing requests - cover the
> scheduling while atomic problem and associated problems.

> Next is a deadlock that I found during a kernel build loop.  The AIO thread
> seems to be able to fill the pipe back to UML with I/O completions.  When
> this happens, it sleeps in a write and stops calling io_getevents.  If UML
> keeps submitting events, the AIO ring buffer will fill, and io_submit will
> start returning -EAGAIN.  At this point, UML will try to write the error to
> itself through the same pipe that the AIO thread has filled.  It will now
> sleep. Since interrupts are off, that pipe can never be emptied since it is
> handled by the driver's interrupt routine, and we are deadlocked.

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
