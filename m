Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1ImXu7-0008Hc-G7 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Oct 2007 09:55:57 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1ImXu6-0005Ni-0h
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Oct 2007 09:55:55 -0700
Date: Mon, 29 Oct 2007 12:55:29 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071029165529.GA6055@c2.user-mode-linux.org>
References: <20071028073843.GD2502@hacking>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071028073843.GD2502@hacking>
Subject: Re: [uml-devel] [Git Patch] arch/um/os-Linux/: varied improvements
	and fixes
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
To: WANG Cong <xiyou.wangcong@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

On Sun, Oct 28, 2007 at 03:38:43PM +0800, WANG Cong wrote:
> This patch contains varied fixes and improvements for some files under
> arch/um/os-Linux/, such as a typo fix in a perror message, a missing
> argument fix for a printf, some constifying for pointers and so on.

Generally looks good, thanks.


>  		printf("failed to install handler for signal %d - errno = %d\n",
> -		       errno);
> +		       sig, errno);

Nice spotting - I wonder why gcc didn't complain about this.

> -	sigprocmask(on ? SIG_UNBLOCK : SIG_BLOCK, &sigset, &old);
> +	if (sigprocmask(on ? SIG_UNBLOCK : SIG_BLOCK, &sigset, &old) < 0)
> +		return -1;

In cases like this, I return -errno, not -1.  I'll fix this up.

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
