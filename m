Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EJApU-0001Eh-EO	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 24 Sep 2005 07:16:40 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EJApT-0003gz-Op
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 24 Sep 2005 07:16:40 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Any way to give /dev/console a controlling TTY?
References: <200509231135.27882.rob@landley.net>
	<200509231950.32370.blaisorblade@yahoo.it>
	<200509231408.32522.rob@landley.net>
In-Reply-To: <200509231408.32522.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509241609.15575.blaisorblade@yahoo.it>
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
Date: Sat, 24 Sep 2005 16:09:14 +0200
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Friday 23 September 2005 21:08, Rob Landley wrote:
> On Friday 23 September 2005 12:50, Blaisorblade wrote:
> > On Friday 23 September 2005 18:35, Rob Landley wrote:
> > > I'm the strange guy using UML via the stdio console, ala:

> > > ./linux rootfstype=hostfs MEM=48m rw init=/bin/sh

> > Ah, init=/bin/sh, that's why you have /dev/console.

> Yup.  Very useful thing to do with UML, I've found.  (That or
> init=/some/shell/script.sh, although it has the nasty habit of falling back
> to /sbin/init if that file is not found...)

> Unfortunately, when you do wrap a shell script, ctrl-c won't get you out.

> > I feared somebody again using /dev/console in inittab.

> Nope, trying to wrap a shell script in a UML instance so I can build and
> link against a libc with more recent kernel headers than the kernel the
> parent system is running.  (Otherwise I get segfaults when the libc tries
> to do things the parent kernel doesn't support.)

> P.S.  The failure case i reported earlier (where 2.6.11 works but 2.6.13.1
> doesn't) involves building the busybox "install" command against uclibc.
> That seems to be what's failing.  I'm still trying to narrow down the
> reproduction case to something small enough to attach to the list, but it's
> been a busy week...)
>
> > > LD_ASSUME_KERNEL=2.4.1
> > >
> > > And it would be very nice if ctrl-c would work with that.  I tried
> > > commenting out the "!noctty &&" test in line 1872, but it didn't make
> > > any difference.
> > >
> > > Anybody see an obvious way to make /dev/console a controlling TTY?
> >
> > Guess that /dev/console is not a TTY, so that it not possible. I mean,
> > you'd have to patch (uselessly) the very TTY core layer.

> The first test is the one I commented out, and I guess one of the next 3
> tests is still blocking it...

> > Or make Linux use /dev/tty0 instead of /dev/console when starting init -
> > which is simpler. There is maybe even a console= switch

> There is indeed a console= switch, but I haven't found a way to get it to
> do anything useful.  (when I use console=/dev/tty0 it immediately exits
> with no error message.
it doesn't expect a /dev/ in front of it.
> Same for console=4,1.  Strangely, console=tty0 
> boots, but seems to be a NOP.)
Given what Henrik said about console being a wrapper of tty0, I expect that 
you could do console=tty1 and have things go there, but /dev/console would 
still behave like /dev/console (i.e. it doesn't become a controlling terminal 
unless requested, to avoid Ctrl-C on init scripts). Using Henrik's ctty is 
the proper solution.

> > Maybe sh doesn't even need that, but login(8) needs setsid. I never
> > remember the exact combination, however.

> The necessary magic is in the busybox init.c, but I don't see how it
> applies here...
Well, I remember something as "/bin/bash <> /dev/tty8" doesn't work without 
the magic, and you need to do more or less this.
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
