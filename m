Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ET2EA-0007La-Hs	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 Oct 2005 12:06:54 -0700
Received: from moutng.kundenserver.de ([212.227.126.190])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1ET2E8-0000Ce-Ty
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 Oct 2005 12:06:54 -0700
Subject: Re: [uml-devel] Strange behaviour of hwrng
From: Gerd Stolpmann <info@gerd-stolpmann.de>
In-Reply-To: <200510212042.29634.blaisorblade@yahoo.it>
References: <1129919051.27787.42.camel@localhost.localdomain>
	 <200510212042.29634.blaisorblade@yahoo.it>
Content-Type: text/plain
Message-Id: <1129921606.27787.61.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Date: Fri, 21 Oct 2005 21:06:46 +0200
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

Am Freitag, den 21.10.2005, 20:42 +0200 schrieb Blaisorblade:
> On Friday 21 October 2005 20:24, Gerd Stolpmann wrote:
> > Hi list,
> >
> > I recently tested the hwrng driver. In principal, it works, but it
> > sometimes eats up all host CPU time. In particular, I can see that the
> > UML system does a (blocking) read on /dev/hwrng,
> 
> Could you please elaborate on that? Who is doing the read, the rng tools? 

Yes, one of the rngd threads is doing the read:

play:~# strace -p 517
Process 517 attached - interrupt to quit
read(3,  <unfinished ...>

top shows it consumes 12.5% CPU time (on the UML system) although it is
blocking, I guess it is system time accounted for this process. On the
host system, UML consumes more than 70% CPU time.

> Also, are they doing only a single read (in which case, it's we the ones who 
> are looping and we're broken) or they are astonished by our -EAGAIN and keep 
> trying (in which case, they are broken)?

Obviously, they don't get the -EAGAIN, so they are only doing a single
read. (We should see the -EAGAIN with strace if it occurred, shouldn'd
we.)

> Actually, from looking at the code (arch/um/drivers/random.c:rng_dev_read()) 
> it appears that we _do_ loop ourselves, if the read is blocking. Not sure how 
> to handle that.

I think this is the problem.

> We could return maybe -EIO, possibly when a rate limit is exceeded (not 
> trivial to do, though - I must learn using timers first).

Maybe an opportunity...

> > and that the host 
> > system loops while reading from /dev/random which almost always returns
> > -EAGAIN. (Found that out with strace, in the hope the output is
> > correct.)
> 
> Well, if the host hasn't enough entropy, it's reasonable for it to return 
> -EAGAIN.

Of course, it it will do most of the time.

> And we should do the same (the loop is actually executed by the UML code, 
> right?).

If the descriptor is non-blocking.

> However, probably the tools inside UML don't expect a lot to get -EAGAIN from 
> an hardware generator. So possibly they are not ready to handle that well.

Obviously, the real hardware generators block when there is not enough
entropy, and rngd was written for them. I think there are two ways of
fixing the problem:

(1) Change rngd. If it sees -EAGAIN, it sleeps for a moment. This is not
easy, because it has to find out the available bit rate of entropy, in
order to determine a reasonable frequency of polling /dev/hwrng.

(2) Fix /dev/hwrng such that it blocks when it is out of entropy. Looks
like the same problem, only within the kernel.

Gerd

> 
> > Nevertheless rngd seems to work, because when killing with SIGUSR1 it
> > shows some reasonable statistics.
> 
> > My test setup is as follows:
> 
> > - Host system: 2.6.12.6 with SKAS3 v8.2 patch
> > - UML system: 2.6.14-rc5, in SKAS3 mode.
> >   Using rngd from Debian Sarge.
> >   TLS is disabled.
> 
> > Let me know if you need more information.
> 
> > Gerd
> 
-- 
------------------------------------------------------------
Gerd Stolpmann * Viktoriastr. 45 * 64293 Darmstadt * Germany 
gerd@gerd-stolpmann.de          http://www.gerd-stolpmann.de
Telefon: 06151/153855                  Telefax: 06151/997714
------------------------------------------------------------



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
