Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KKaiD-00074e-22 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 20 Jul 2008 08:20:37 -0700
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]
	helo=tadamune.kami.home)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KKai9-0008MY-LB
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 20 Jul 2008 08:20:37 -0700
Date: Mon, 21 Jul 2008 00:20:22 +0900
From: Mattia Dongili <malattia@linux.it>
Message-ID: <20080720152022.GE1520@inferi.kami.home>
References: <5df78e1d0807030053x8a9bfabo582ea78e74b2c65b@mail.gmail.com>
	<20080703135639.GA8262@c2.user-mode-linux.org>
	<5df78e1d0807031806s74c13c84idadc62c1d1e0e93b@mail.gmail.com>
	<5df78e1d0807091925q64c0121fk3d33c37df8d80d18@mail.gmail.com>
	<20080710170210.GB18429@c2.user-mode-linux.org>
	<5df78e1d0807140206m43291128t32f1489177ad6e3d@mail.gmail.com>
	<20080714144612.GA5751@c2.user-mode-linux.org>
	<5df78e1d0807160252j1b610c41la1a2f5092ae04be7@mail.gmail.com>
	<5df78e1d0807162155t594936c9qe5bc1616fae97f77@mail.gmail.com>
	<20080718205342.GE13572@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080718205342.GE13572@c2.user-mode-linux.org>
Subject: Re: [uml-devel] 2.6.25 uml kernel crashes when it calls down() on
	a	semaphore with zero counter
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jiaying Zhang <jiayingz@google.com>

On Fri, Jul 18, 2008 at 04:53:42PM -0400, Jeff Dike wrote:
> On Thu, Jul 17, 2008 at 12:55:09PM +0800, Jiaying Zhang wrote:
> > The patch below solves the 2.6.25 uml crash problem for me. Looks like the
> > problem should be away in 2.6.26 kernel because down_interruptible has
> > changed to the C code since 2.6.26. But I got kernel panic while booting
> > the 2.6.26 kernel :(.
> > 
> > --- linux-2.6.25.4/lib/semaphore-sleepers.c     2008-05-15
> > 23:00:12.000000000 +0800
> > +++ linux-2.6.25.4-new/lib/semaphore-sleepers.c 2008-07-17
> > 12:20:47.000000000 +0800
> > @@ -48,12 +48,12 @@
> >   *    we cannot lose wakeup events.
> >   */
> > 
> > -void __up(struct semaphore *sem)
> > +asmregparm void __up(struct semaphore *sem)
> >  {
> >         wake_up(&sem->wait);
> >  }
> 
> You continue to ignore a few important facts:
> 
>     1 - There are a ton of semaphores in UML
>     2 - They all work, except for yours
>     Therefore, a patch which changes all semphores across all
> architectures for which asmregparam has meaning can't possibly be the
> correct fix.
> 
> However, you might have treated this as an important clue, and looked
> at whether your broken semaphore has a different set of declarations
> in force than those in the rest of the kernel.

Jeff,
it's not entirely clear to me why, but that patch fixes a segfault that
I experience when booting uml 2.6.25 built with gcc-4.3 on a 2.6.25
host (I also applied your ICE workaround patch).
I'm booting a debian sid image that I usually run before uploading the
new uml package in debian.
I've got no fancy modules written by me and the segfault is 100%
reproducible with that debian image (a different image -a gentoo-
doesn't crash).

I'll provide more info tomorrow, I'll try to further trace the crash
with gdb.

cheers
-- 
mattia
:wq!

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
