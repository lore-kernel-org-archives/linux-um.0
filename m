Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EJLNh-0001B9-VK	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 24 Sep 2005 18:32:41 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EJLNg-0006Hu-L7
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 24 Sep 2005 18:32:42 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Curiosity about nested UML invocations...
Message-ID: <20050925012527.GB10546@ccure.user-mode-linux.org>
References: <200509241913.24060.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509241913.24060.rob@landley.net>
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
Date: Sat, 24 Sep 2005 21:25:27 -0400
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sat, Sep 24, 2005 at 07:13:23PM -0500, Rob Landley wrote:
> So what does "nesting level" actually do, anyway?  Trying to run UML from 
> within itself (giving the outer invocation mem=128M), I get the following 
> error:
> 
> sh-3.00# ./linux rootfstype=hostfs rw init=/bin/sh LD_ASSUME_KERNEL=2.4.1
> Checking for /proc/mm...not found
> Checking for the skas3 patch in the host...found
> UML running in SKAS0 mode
> os_mode_fd: No such file or directory
> sh-3.00#

In skas mode, it means nothing.  The fact that it doesn't run inside itself
means there's some other bug.

				Jeff


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
