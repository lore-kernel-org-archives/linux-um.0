Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EIsit-0004hs-NE	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Sep 2005 11:56:39 -0700
Received: from marasystems.com ([83.241.133.2] helo=filer.marasystems.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EIsis-0004zf-6p
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Sep 2005 11:56:39 -0700
From: Henrik Nordstrom <uml@hno.marasystems.com>
Subject: Re: [uml-devel] Any way to give /dev/console a controlling TTY?
In-Reply-To: <200509231331.47282.rob@landley.net>
Message-ID: <Pine.LNX.4.61.0509232048230.14136@filer.marasystems.com>
References: <200509231135.27882.rob@landley.net>
	<200509231331.47282.rob@landley.net>
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
Date: Fri, 23 Sep 2005 20:56:32 +0200 (CEST)
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, 23 Sep 2005, Rob Landley wrote:

>> Anybody see an obvious way to make /dev/console a controlling TTY?

The user-space process who wants it as a controlling tty needs to run

   ioctl(0, TIOCSCTTY, (void *) 1);

You should also take care to set up the termios parameters correctly.

At http://marasystems.com/download/ctty/ you can find a little tool we use 
in embedded systems making /dev/console a controlling TTY. We use from 
inittab in the main console entries (single and console).

ls:S:wait:ctty ash
sh:0123456:respawn:ctty console

(console is our console command line program)

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
