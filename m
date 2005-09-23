Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EIsgy-0004Uf-HY	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Sep 2005 11:54:40 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EIsgu-0004Zf-5h
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Sep 2005 11:54:40 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Any way to give /dev/console a controlling TTY?
References: <200509231135.27882.rob@landley.net>
	<Pine.LNX.4.61.0509232038110.14136@filer.marasystems.com>
In-Reply-To: <Pine.LNX.4.61.0509232038110.14136@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509232053.24982.blaisorblade@yahoo.it>
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
Date: Fri, 23 Sep 2005 20:53:24 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Henrik Nordstrom <uml@hno.marasystems.com>, Rob Landley <rob@landley.net>

On Friday 23 September 2005 20:47, Henrik Nordstrom wrote:
> On Fri, 23 Sep 2005, Rob Landley wrote:
> > I'm the strange guy using UML via the stdio console, ala:

> > ./linux rootfstype=hostfs MEM=48m rw init=/bin/sh LD_ASSUME_KERNEL=2.4.1

> > And it would be very nice if ctrl-c would work with that.  I tried
> > commenting out the "!noctty &&" test in line 1872, but it didn't make any
> > difference.

> > Anybody see an obvious way to make /dev/console a controlling TTY?

> The stdin given by the kernel to init is not a controlling TTY as this
> would be disasterous (imagine someone sending breaks during the boot
> sequence, breaking various init tasks or even init itself...), but any
> init related process (but only one) can claim it as the controlling TTY
> and will then be given signals.
>
> This is not unique to UML but applies to all architectures.

> There is nothing wrong with using /dev/console instead of a "real" tty.
> /dev/console is no more than an alias for the first console tty.
Ahhh..
> But you 
> won't get it as a controlling TTY unless explicitly asked for.
How?

Anyway, Henrik, thanks for your enlightenment.
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
