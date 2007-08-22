Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1INvR8-0003W2-8T for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 22 Aug 2007 12:00:14 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1INvR6-0001Ya-Ow
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 22 Aug 2007 12:00:14 -0700
Date: Wed, 22 Aug 2007 14:59:52 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070822185952.GD11966@c2.user-mode-linux.org>
References: <46975C78.5010903@nagafix.co.uk>
	<20070713160500.GB7468@c2.user-mode-linux.org>
	<4697BFCB.2060701@nagafix.co.uk>
	<20070713184545.GC9472@c2.user-mode-linux.org>
	<46AF757F.9080103@nagafix.co.uk>
	<20070807152131.GB6141@c2.user-mode-linux.org>
	<46B8980A.6010902@nagafix.co.uk> <46C31489.9040704@nagafix.co.uk>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <46C31489.9040704@nagafix.co.uk>
Subject: Re: [uml-devel] 2.6.21.5 crashes [was link failure,
	multiple definition of 'in6addr_any']
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Antoine Martin <antoine@nagafix.co.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, Aug 15, 2007 at 03:58:17PM +0100, Antoine Martin wrote:
> SysRq doesn't dump anything anymore (or did it ever? IIRC it did)

I was just looking at that.  You need CONFIG_MAGIC_SYSRQ enabled,
which isn't by default for some reason.  Then, there is a bug in
returning stuff to the mconsole client, which I have a patch for.
Then, there's a problem with large amounts of data being passed back.

However, if sysrq is enabled, data will end up in the kernel log as
usual, where it can be looked at with gdb even if the UML isn't
healthy enough to run dmesg.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
