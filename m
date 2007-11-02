Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1InmEM-00046i-S3 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Nov 2007 19:25:54 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1InmEL-0001JV-9P
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Nov 2007 19:25:54 -0700
Date: Thu, 1 Nov 2007 22:25:40 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071102022540.GA12253@c2.user-mode-linux.org>
References: <472A4DAC.3060104@BitWagon.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <472A4DAC.3060104@BitWagon.com>
Subject: Re: [uml-devel] why allocate page for stack in clone(, stack,
	~CLONE_VM & (...)) ?
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
To: John Reiser <jreiser@BitWagon.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, Nov 01, 2007 at 03:05:32PM -0700, John Reiser wrote:
> In arch/um/os/start_up.c, function start_ptraced_child() does:
>         pid = clone(ptrace_child, (void *) sp, SIGCHLD, NULL);
> where sp points into a newly- mmap()ed page.  Instead, why not
> avoid the mmap() entirely via:
>         pid = clone(ptrace_child, NULL,        SIGCHLD, NULL);
> 
> Because the flags to clone() do not contain CLONE_VM, then the clone()
> is equivalent to a fork() with respect to address space.

If you look at what's currently in mainline, you'll see it does
exactly what you suggest - the patch in question is this one:
	http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=3cdaf45578b9aa1eb748d0a32678ee5a0180575b

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
