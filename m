Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EJVxA-00035p-TA	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 25 Sep 2005 05:50:00 -0700
Received: from marasystems.com ([83.241.133.2] helo=filer.marasystems.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EJVx8-0000EI-Gj
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 25 Sep 2005 05:50:01 -0700
From: Henrik Nordstrom <uml@hno.marasystems.com>
Subject: Re: [uml-devel] Any way to give /dev/console a controlling TTY?
In-Reply-To: <200509231408.32522.rob@landley.net>
Message-ID: <Pine.LNX.4.61.0509251423150.12255@filer.marasystems.com>
References: <200509231135.27882.rob@landley.net>
	<200509231950.32370.blaisorblade@yahoo.it>
	<200509231408.32522.rob@landley.net>
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
Date: Sun, 25 Sep 2005 14:49:53 +0200 (CEST)
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, 23 Sep 2005, Rob Landley wrote:

> There is indeed a console= switch, but I haven't found a way to get it to do
> anything useful.  (when I use console=/dev/tty0 it immediately exits with no
> error message.  Same for console=4,1.  Strangely, console=tty0 boots, but
> seems to be a NOP.)

See Documentation/serial-console.txt and Documentation/devices.txt for 
details on how the console= option and /dev/console works.

In short console= tells the kernel where to log messages. Can be specified 
multiple times if you want the kernel to report messages on more than one 
tty. If none is specified the kernel probes all the available tty drivers 
in a predefined order, usually tty0 (vt), ttyS0 (first serial port), lp. 
The first found console driver is then linked to /dev/console for 
userspace to attach to, and given as stdin/out/err to init.

Note: tty0 is a magic vt device linked to the current foreground virtual 
terminal, not one specific terminal. This should only be used in 
singleuser mode as it competes with the real ttyX for the same virtual 
terminal.

The ctty program mentioned has only been truly tested from inittab. Does 
not seem to work proper when used as init= so it's probably missing some 
process group thing or similar. Did work when executed interactively from 
a init=/bin/sh shell however. To be honest it skips quite many steps in 
the terminal initialization compared to how getty etc opens their 
terminal.

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
