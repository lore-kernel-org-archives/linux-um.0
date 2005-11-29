Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eh8zY-0006n7-AA for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Nov 2005 09:10:08 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Eh8zR-0007JZ-4h
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Nov 2005 09:10:08 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Testing requested - [PATCH] Fixing SKAS0 compilation
	problem / TT mode bug report
Message-ID: <20051129175556.GA14058@ccure.user-mode-linux.org>
References: <200511272159.38069.blaisorblade@yahoo.it>
	<20051128042327.GA28500@ccure.user-mode-linux.org>
	<200511291728.56515.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511291728.56515.blaisorblade@yahoo.it>
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
Date: Tue, 29 Nov 2005 12:55:56 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, Nov 29, 2005 at 05:28:56PM +0100, Blaisorblade wrote:
> So, again: can we finally rewrite clone.c in assembly? Or, otherwise, to use a 
> unique assembly macro joining mmap, the return and trap_myself?

I would favor the second, although I would just join the mmap and storing of 
the error value.  The stack switching is at the heart of our recent problems
here, so some asm which hides that should be OK.  I think the rest is OK with
the pseudo-C, right?

				Jeff


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
