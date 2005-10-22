Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ETM2c-0004cB-RV	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 22 Oct 2005 09:16:18 -0700
Received: from moutng.kundenserver.de ([212.227.126.184])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1ETM2a-0006fN-Ph
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 22 Oct 2005 09:16:18 -0700
Subject: Re: [uml-devel] Strange behaviour of hwrng
From: Gerd Stolpmann <info@gerd-stolpmann.de>
In-Reply-To: <200510220252.00871.blaisorblade@yahoo.it>
References: <1129919051.27787.42.camel@localhost.localdomain>
	 <200510212042.29634.blaisorblade@yahoo.it>
	 <1129921606.27787.61.camel@localhost.localdomain>
	 <200510220252.00871.blaisorblade@yahoo.it>
Content-Type: text/plain
Message-Id: <1129997766.27787.80.camel@localhost.localdomain>
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
Date: Sat, 22 Oct 2005 18:16:06 +0200
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

Am Samstag, den 22.10.2005, 02:52 +0200 schrieb Blaisorblade:
> > Obviously, the real hardware generators block when there is not enough
> > entropy, and rngd was written for them. I think there are two ways of
> > fixing the problem:
> 
> > (1) Change rngd. If it sees -EAGAIN, it sleeps for a moment. This is not
> > easy, because it has to find out the available bit rate of entropy, in
> > order to determine a reasonable frequency of polling /dev/hwrng.
> We could implement poll() for that purpose, 
> > (2) Fix /dev/hwrng such that it blocks when it is out of entropy. Looks
> > like the same problem, only within the kernel.
> 
> Proper solution: use a separate _host_ thread, which either sits blocked in a 
> blocking read or calls poll() on the host /dev/random, and have it do the 
> work. It's not easy however.
> The ubd driver works currently this way, but the thing is not trivial to get 
> right (and the UBD rewrite in the works has shown that).
> 
> A simpler solution is to increase the parameter passed to schedule_timeout. We 
> currently sleep for one hundredth of second (actually one jiffy).
> 
> But only if need_resched(), which is wrong. I.e. if a timeslice lasts 80 ms 
> (as is possible) we'll sleep 1 ms every 80 ones, which is unfair. Also, 
> there's no need to continously poll the host /dev/random.
> 
> So, in rng_dev_read, in this piece of code:
>                        if(need_resched()){
>                                 current->state = TASK_INTERRUPTIBLE;
>                                 schedule_timeout(1);
>                         }
> 
> Remove the need_resched() checking, and retest. You can also test increasing 
> the param to schedule timeout (it's currently 10 ms, but it's better to use 
> HZ to mean a second and, say, HZ/100 to mean 10ms).

Ok, I tested that with schedule_timeout(HZ), i.e. it polls once per
second. This looks good enough for the case that the host /dev/random is
slow. rngd reports that it gets about 60 random bits/sec, which is about
the same as before with busy waiting.

The code looks now:

                        if(1){
                                current->state = TASK_INTERRUPTIBLE;
                                schedule_timeout(HZ);
                        }

It would be interesting how well this works for a hardware entropy
generator. I don't have such a board, however.

Another question is how fair we are. It may happen that host processes
like sshd starve that need entropy only from time to time, because all
randomness was pulled out of /dev/random from greedy UML kernels.
Ideally, the UMLs take only entropy when the entropy pool is filled to a
certain watermark at minimum.

Gerd
-- 
------------------------------------------------------------
Gerd Stolpmann * Viktoriastr. 45 * 64293 Darmstadt * Germany 
gerd@gerd-stolpmann.de          http://www.gerd-stolpmann.de
Telefon: 06151/153855                  Telefax: 06151/997714
------------------------------------------------------------



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
