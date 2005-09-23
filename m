Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EIuD4-0000Z0-IN	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Sep 2005 13:31:54 -0700
Received: from marasystems.com ([83.241.133.2] helo=filer.marasystems.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EIuD2-00056q-LI
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Sep 2005 13:31:54 -0700
From: Henrik Nordstrom <uml@hno.marasystems.com>
Subject: Re: [uml-devel] Any way to give /dev/console a controlling TTY?
In-Reply-To: <200509232108.51050.blaisorblade@yahoo.it>
Message-ID: <Pine.LNX.4.61.0509232229090.14136@filer.marasystems.com>
References: <200509231135.27882.rob@landley.net>
	<200509231331.47282.rob@landley.net>
	<Pine.LNX.4.61.0509232048230.14136@filer.marasystems.com>
	<200509232108.51050.blaisorblade@yahoo.it>
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
Date: Fri, 23 Sep 2005 22:31:38 +0200 (CEST)
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Henrik Nordstrom <uml@hno.marasystems.com>, Rob Landley <rob@landley.net>

On Fri, 23 Sep 2005, Blaisorblade wrote:

> So in this case he should use init=/sbin/ctty sh, right?

But you can't.. init= takes a single path to the binary to use, no 
arguments. But it's trivial to modify ctty to autmatically start a shell 
for you.

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
