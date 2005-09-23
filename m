Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EJARK-0000F8-DW	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 24 Sep 2005 06:51:42 -0700
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EJARI-0007dC-E8
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 24 Sep 2005 06:51:42 -0700
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Any way to give /dev/console a controlling TTY?
References: <200509231135.27882.rob@landley.net>
	<200509231950.32370.blaisorblade@yahoo.it>
In-Reply-To: <200509231950.32370.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509231408.32522.rob@landley.net>
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
Date: Fri, 23 Sep 2005 14:08:32 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Friday 23 September 2005 12:50, Blaisorblade wrote:
> On Friday 23 September 2005 18:35, Rob Landley wrote:
> > I'm the strange guy using UML via the stdio console, ala:
> >
> > ./linux rootfstype=hostfs MEM=48m rw init=/bin/sh
>
> Ah, init=/bin/sh, that's why you have /dev/console.

Yup.  Very useful thing to do with UML, I've found.  (That or 
init=/some/shell/script.sh, although it has the nasty habit of falling back 
to /sbin/init if that file is not found...)

Unfortunately, when you do wrap a shell script, ctrl-c won't get you out.

> I feared somebody again using /dev/console in inittab.

Nope, trying to wrap a shell script in a UML instance so I can build and link 
against a libc with more recent kernel headers than the kernel the parent 
system is running.  (Otherwise I get segfaults when the libc tries to do 
things the parent kernel doesn't support.)

P.S.  The failure case i reported earlier (where 2.6.11 works but 2.6.13.1 
doesn't) involves building the busybox "install" command against uclibc.  
That seems to be what's failing.  I'm still trying to narrow down the 
reproduction case to something small enough to attach to the list, but it's 
been a busy week...)

> > LD_ASSUME_KERNEL=2.4.1
> >
> > And it would be very nice if ctrl-c would work with that.  I tried
> > commenting out the "!noctty &&" test in line 1872, but it didn't make any
> > difference.
> >
> > Anybody see an obvious way to make /dev/console a controlling TTY?
>
> Guess that /dev/console is not a TTY, so that it not possible. I mean,
> you'd have to patch (uselessly) the very TTY core layer.

Well, actually the test on line 1872 of drivers/char/tty_io.c does in fact 
seem to be trying to determine what should and shouldn't be a tty.

It _seems_ like that code is trying to figure out what is and isn't a 
controlling tty:

        if (!noctty &&
            current->signal->leader &&
            !current->signal->tty &&
            tty->session == 0) {
                task_lock(current);
                current->signal->tty = tty;
                task_unlock(current);
                current->signal->tty_old_pgrp = 0;
                tty->session = current->signal->session;
                tty->pgrp = process_group(current);
        }

The first test is the one I commented out, and I guess one of the next 3 tests 
is still blocking it...

> Or make Linux use /dev/tty0 instead of /dev/console when starting init -
> which is simpler. There is maybe even a console= switch

There is indeed a console= switch, but I haven't found a way to get it to do 
anything useful.  (when I use console=/dev/tty0 it immediately exits with no 
error message.  Same for console=4,1.  Strangely, console=tty0 boots, but 
seems to be a NOP.)

> What about something like init="kludgy script which calls, say, a mixture
> of setsid, <> /dev/tty0, open(1) and such stuff to make sh start?

Given enough effort I can workaround the problem instead of fixing it, sure.

> Maybe sh doesn't even need that, but login(8) needs setsid. I never
> remember the exact combination, however.

The necessary magic is in the busybox init.c, but I don't see how it applies 
here...

Rob


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
