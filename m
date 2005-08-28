Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E9NUp-0001DC-G0	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 28 Aug 2005 06:46:51 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E9NUo-0004k7-9a
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 28 Aug 2005 06:46:51 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] gdb ignoring skas breakpoints?
Message-ID: <20050828134015.GC3192@ccure.user-mode-linux.org>
References: <430FC6BF.2020806@oracle.com>
	<200508271126.10514.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508271126.10514.blaisorblade@yahoo.it>
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
Date: Sun, 28 Aug 2005 09:40:15 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Allan Graves <allan.graves@oracle.com>

On Sat, Aug 27, 2005 at 11:26:10AM +0200, Blaisorblade wrote:
> However, apart from that, I've seen that happen too when trying to do things 
> like break panic. I think I've never seen it working. I don't know if Jeff 
> has it working (he's been staying with gdb 5.x to avoid lots of problems in 
> new releases).

I'm now suffering with a modern breakpoint-missing gdb just like
everyone else.  What I do is stick a
	while(stop_here) sleep(1);
at the point where I want to stop, and rebuild and reboot.

When it freezes at the sleep, I attach gdb to it, set stop_here=0,
finish my way out of the sleep, and continue debugging from there.

				Jeff


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
