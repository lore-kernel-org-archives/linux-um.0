Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AvLiO-00014M-I9 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 23 Feb 2004 11:26:04 -0800
Received: from mailgate.uni-paderborn.de ([131.234.22.32])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1AvLac-0007zU-Me
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 23 Feb 2004 11:18:02 -0800
Message-ID: <403A5289.8070405@upb.de>
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
MIME-Version: 1.0
Subject: Re: [uml-devel] kernel BUG at kernel/exit.c:793!
References: <c156t0$g3b$1@sea.gmane.org>
	<200402231850.i1NIoxmX024417@ccure.user-mode-linux.org>
In-Reply-To: <200402231850.i1NIoxmX024417@ccure.user-mode-linux.org>
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
Date: Mon, 23 Feb 2004 20:20:41 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, jdike@sonycom.com

>>Kernel panic: kernel BUG at kernel/exit.c:793! 
> 
> We're in hot pursuit of this bug, but no one has tracked it down yet.

What is known about this bug?
Does it only happen in TT mode? Or also in SKAS mode?

BTW: do you use some kind of bug-tracker like BugZilla or whatever?

I will try to reproduce the bug later this week,
but i dought that i will succeed.



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
