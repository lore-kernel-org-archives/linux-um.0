Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ET7ah-0002mk-TD	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 Oct 2005 17:50:31 -0700
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1ET7af-0002ub-Ev
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 Oct 2005 17:50:32 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Strange behaviour of hwrng
References: <1129919051.27787.42.camel@localhost.localdomain>
	<200510212042.29634.blaisorblade@yahoo.it>
	<1129921606.27787.61.camel@localhost.localdomain>
In-Reply-To: <1129921606.27787.61.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510220252.00871.blaisorblade@yahoo.it>
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
Date: Sat, 22 Oct 2005 02:52:00 +0200
To: Gerd Stolpmann <info@gerd-stolpmann.de>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Friday 21 October 2005 21:06, Gerd Stolpmann wrote:
> Am Freitag, den 21.10.2005, 20:42 +0200 schrieb Blaisorblade:
> > On Friday 21 October 2005 20:24, Gerd Stolpmann wrote:
> > > Hi list,
> > >
> > > I recently tested the hwrng driver. In principal, it works, but it
> > > sometimes eats up all host CPU time. In particular, I can see that the
> > > UML system does a (blocking) read on /dev/hwrng,
> >
> > Could you please elaborate on that? Who is doing the read, the rng tools?
>
> Yes, one of the rngd threads is doing the read:
>
> play:~# strace -p 517
> Process 517 attached - interrupt to quit
> read(3,  <unfinished ...>
>
> top shows it consumes 12.5% CPU time (on the UML system) although it is
> blocking, I guess it is system time accounted for this process. On the
> host system, UML consumes more than 70% CPU time.

> > Also, are they doing only a single read (in which case, it's we the ones
> > who are looping and we're broken) or they are astonished by our -EAGAIN
> > and keep trying (in which case, they are broken)?
>
> Obviously, they don't get the -EAGAIN, so they are only doing a single
> read. (We should see the -EAGAIN with strace if it occurred, shouldn'd
> we.)
Yes, we'd see it. Anyway, after seeing rngd is doing a blocking read, I 
guessed that.
> > Actually, from looking at the code
> > (arch/um/drivers/random.c:rng_dev_read()) it appears that we _do_ loop
> > ourselves, if the read is blocking. Not sure how to handle that.
>
> I think this is the problem.
Yes, agreed.
> > We could return maybe -EIO, possibly when a rate limit is exceeded (not
> > trivial to do, though - I must learn using timers first).
>
> Maybe an opportunity...
>
> > > and that the host
> > > system loops while reading from /dev/random which almost always returns
> > > -EAGAIN. (Found that out with strace, in the hope the output is
> > > correct.)
> >
> > Well, if the host hasn't enough entropy, it's reasonable for it to return
> > -EAGAIN.
>
> Of course, it it will do most of the time.
Well, the host should have more entropy than the guest. But if the host hasn't 
a real hardware generator, yes, that will happen. For the normal rngd 
context, the hardware is expected to give a continous flow.
> > And we should do the same (the loop is actually executed by the UML code,
> > right?).

> If the descriptor is non-blocking.
Theoretically yes, in practice this limitation is a problem.
> > However, probably the tools inside UML don't expect a lot to get -EAGAIN
> > from an hardware generator. So possibly they are not ready to handle that
> > well.

> Obviously, the real hardware generators block when there is not enough
> entropy, and rngd was written for them. I think there are two ways of
> fixing the problem:

> (1) Change rngd. If it sees -EAGAIN, it sleeps for a moment. This is not
> easy, because it has to find out the available bit rate of entropy, in
> order to determine a reasonable frequency of polling /dev/hwrng.
We could implement poll() for that purpose, 
> (2) Fix /dev/hwrng such that it blocks when it is out of entropy. Looks
> like the same problem, only within the kernel.

Proper solution: use a separate _host_ thread, which either sits blocked in a 
blocking read or calls poll() on the host /dev/random, and have it do the 
work. It's not easy however.
The ubd driver works currently this way, but the thing is not trivial to get 
right (and the UBD rewrite in the works has shown that).

A simpler solution is to increase the parameter passed to schedule_timeout. We 
currently sleep for one hundredth of second (actually one jiffy).

But only if need_resched(), which is wrong. I.e. if a timeslice lasts 80 ms 
(as is possible) we'll sleep 1 ms every 80 ones, which is unfair. Also, 
there's no need to continously poll the host /dev/random.

So, in rng_dev_read, in this piece of code:
                       if(need_resched()){
                                current->state = TASK_INTERRUPTIBLE;
                                schedule_timeout(1);
                        }

Remove the need_resched() checking, and retest. You can also test increasing 
the param to schedule timeout (it's currently 10 ms, but it's better to use 
HZ to mean a second and, say, HZ/100 to mean 10ms).

In any case, give me an answer on this.
Bye!
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
