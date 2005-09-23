Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EIs8s-0002yH-Kr	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Sep 2005 11:19:26 -0700
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EIs8m-0000MT-2l
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Sep 2005 11:19:20 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Any way to give /dev/console a controlling TTY?
References: <200509231135.27882.rob@landley.net>
In-Reply-To: <200509231135.27882.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509231950.32370.blaisorblade@yahoo.it>
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
Date: Fri, 23 Sep 2005 19:50:32 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Rob Landley <rob@landley.net>

On Friday 23 September 2005 18:35, Rob Landley wrote:
> I'm the strange guy using UML via the stdio console, ala:
>
> ./linux rootfstype=hostfs MEM=48m rw init=/bin/sh
Ah, init=/bin/sh, that's why you have /dev/console. I feared somebody again 
using /dev/console in inittab.
> LD_ASSUME_KERNEL=2.4.1 

> And it would be very nice if ctrl-c would work with that.  I tried
> commenting out the "!noctty &&" test in line 1872, but it didn't make any
> difference.

> Anybody see an obvious way to make /dev/console a controlling TTY?
Guess that /dev/console is not a TTY, so that it not possible. I mean, you'd 
have to patch (uselessly) the very TTY core layer.

Or make Linux use /dev/tty0 instead of /dev/console when starting init - which 
is simpler. There is maybe even a console= switch

What about something like init="kludgy script which calls, say, a mixture of 
setsid, <> /dev/tty0, open(1) and such stuff to make sh start?

Maybe sh doesn't even need that, but login(8) needs setsid. I never remember 
the exact combination, however.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.messenger.yahoo.com



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
