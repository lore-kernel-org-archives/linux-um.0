Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C4YIP-0002P5-B0 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Sep 2004 22:13:33 -0700
Received: from parcelfarce.linux.theplanet.co.uk
	([195.92.249.252] helo=www.linux.org.uk ident=93)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34) id 1C4YIN-0000iQ-Js
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Sep 2004 22:13:33 -0700
Message-ID: <413D4366.5020902@pobox.com>
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Current state of UML
References: <200408190301.i7J30xek004150@ccure.user-mode-linux.org>
	<200408251746.53523.blaisorblade_spam@yahoo.it>
	<413B76DB.5010600@pobox.com>
	<200409061956.34557.blaisorblade_spam@yahoo.it>
	<413D3BC8.1050902@pobox.com>
	<Pine.LNX.4.58.0409070002220.1556@gradall.private.brainfood.com>
In-Reply-To: <Pine.LNX.4.58.0409070002220.1556@gradall.private.brainfood.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Tue, 07 Sep 2004 01:13:10 -0400
To: Adam Heath <adam@doogie.org>
Cc: BlaisorBlade <blaisorblade_spam@yahoo.it>, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

Adam Heath wrote:
> Sounds like a syslog bug, that should have been fixed long ago.

Perhaps...  strace running inside UML host seems to stop at nanosleep, 
of all places:

read(3, "676\n", 4096)                  = 4
close(3)                                = 0
munmap(0x40017000, 4096)                = 0
kill(676, SIG_0)                        = -1 ESRCH (No such process)
clone(child_stack=0, 
flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, 
child_tidptr=0x4013d2e8) = 716
rt_sigaction(SIGTERM, {0x15559810, [TERM], SA_RESTORER|SA_RESTART, 
0x40048f38}, {SIG_DFL}, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGCHLD, NULL, {SIG_DFL}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
nanosleep({300, 0},


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
