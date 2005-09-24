Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EJJEA-0003wi-Ug	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 24 Sep 2005 16:14:42 -0700
Received: from marasystems.com ([83.241.133.2] helo=filer.marasystems.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EJJE8-0000wS-9Y
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 24 Sep 2005 16:14:42 -0700
From: Henrik Nordstrom <uml@hno.marasystems.com>
Subject: Re: [uml-devel] Any way to give /dev/console a controlling TTY?
In-Reply-To: <200509241603.53845.blaisorblade@yahoo.it>
Message-ID: <Pine.LNX.4.61.0509250103240.30315@filer.marasystems.com>
References: <200509231135.27882.rob@landley.net>
	<200509232108.51050.blaisorblade@yahoo.it>
	<Pine.LNX.4.61.0509232229090.14136@filer.marasystems.com>
	<200509241603.53845.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
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
Date: Sun, 25 Sep 2005 01:14:29 +0200 (CEST)
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Henrik Nordstrom <uml@hno.marasystems.com>, user-mode-linux-devel@lists.sourceforge.net, Rob Landley <rob@landley.net>

On Sat, 24 Sep 2005, Blaisorblade wrote:

> init= doesn't take argument, yes, but IIRC unhandled arguments are
> automatically passed to init, like unhandled assignment are passed in env.
> vars. Or not?

Right. Seems to work just fine even if somewhat confusing...

    sh init=/bin/ctty
or
    init=/bin/ctty sh

is the same thing..

Regards
Henrik


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
