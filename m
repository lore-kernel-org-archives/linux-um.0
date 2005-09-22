Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EIXvy-0002vj-Tw	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Sep 2005 13:44:46 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EIXvx-0005WI-IL
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Sep 2005 13:44:47 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] [PATCH 06/10] uml: run mconsole "sysrq" in process
	context
Message-ID: <20050922203743.GA11648@ccure.user-mode-linux.org>
References: <200509211923.21861.blaisorblade@yahoo.it>
	<20050921172857.10219.71071.stgit@zion.home.lan>
	<20050921205028.GB9918@ccure.user-mode-linux.org>
	<200509222120.20922.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509222120.20922.blaisorblade@yahoo.it>
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
Date: Thu, 22 Sep 2005 16:37:43 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Thu, Sep 22, 2005 at 09:20:20PM +0200, Blaisorblade wrote:
> sysrq t is broken (and stays), 

There's a fix on the way for that.  This has nothing to do with interrupt
context anyway.

> but additionally there are some warnings from 
> some commands (enable sleep inside spinlock checking and spinlock debugging), 
> which go to the down_read inside handle_page_fault IIRC. So try to run in 
> process context.

Which ones?  They should be fixed.

It is fairly fundamental to sysrq that it work from interrupt context.  You
may be diagnosing a system which can't context switch any more.

This patch should be dropped, and the real problems fixed.

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
