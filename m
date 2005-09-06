Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ECgWT-0004Mn-Dq	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Sep 2005 09:42:13 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1ECgWS-0004Cd-5P
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Sep 2005 09:42:13 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] stack and scheduler patches
Message-ID: <20050906153704.GA5771@ccure.user-mode-linux.org>
References: <431637F9.6030101@oracle.com>
	<20050902165935.GA6651@ccure.user-mode-linux.org>
	<200509041351.32837.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509041351.32837.blaisorblade@yahoo.it>
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
Date: Tue, 6 Sep 2005 11:37:04 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Allan Graves <allan.graves@oracle.com>

On Sun, Sep 04, 2005 at 01:51:32PM +0200, Blaisorblade wrote:
> Also, what is the difference between your "stack trace" patch, which adds a 
> member to thread_struct, for each process, so I'd like a minimum of 
> justification, and one of the sysrq options which does exactly this?

What this does, and sysrq t doesn't, is allow you to put a breakpoint
on that show_regs call and force a particular thread back into
context.  Then you can poke around the stack with gdb.  You could so
this in tt mode, but not previously in skas mode, and people have
missed this.

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
